#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="$(chezmoi source-path)"

# Gather changed targets from chezmoi status.
mapfile -t targets < <(chezmoi status | awk '{print $NF}')

if [[ ${#targets[@]} -eq 0 ]]; then
  echo "Nothing to do — chezmoi status is clean."
  exit 0
fi

echo "Detected ${#targets[@]} changed target(s):"
printf '  %s\n' "${targets[@]}"

# Collapse individual file paths to their top-level managed directory.
#   ~/.config/hypr/hyprland/keybinds.conf  →  .config/hypr
#   ~/.local/share/fonts/Mono.ttf          →  .local/share/fonts
#   ~/.bashrc                              →  .bashrc

collapse_to_root() {
  local rel="$1"
  IFS='/' read -ra parts <<<"$rel"
  local n=${#parts[@]}

  if [[ "${parts[0]}" == ".config" && $n -ge 3 ]]; then
    echo "${parts[0]}/${parts[1]}"
  elif [[ "${parts[0]}" == ".local" && "${parts[1]:-}" == "share" && $n -ge 4 ]]; then
    echo "${parts[0]}/${parts[1]}/${parts[2]}"
  else
    echo "$rel"
  fi
}

mapfile -t roots < <(
  for t in "${targets[@]}"; do
    collapse_to_root "$t"
  done | sort -u
)

echo
echo "Collapsed to ${#roots[@]} root path(s):"
printf '  ~/%s\n' "${roots[@]}"

# ── Step 1: Backup commit & push (only if repo is dirty) ────────────────
if [[ -n "$(git -C "$SOURCE_DIR" status --porcelain)" ]]; then
  echo
  echo "==> Step 1: Creating backup commit and pushing..."
  git -C "$SOURCE_DIR" add -A
  git -C "$SOURCE_DIR" commit -m "backup: pre-readd snapshot ($(date -Is))"
  git -C "$SOURCE_DIR" push
else
  echo
  echo "==> Step 1: Skipped — source repo is already clean."
fi

# ── Step 2: Forget collapsed roots ──────────────────────────────────────
echo
echo "==> Step 2: Forgetting ${#roots[@]} root path(s)..."
for r in "${roots[@]}"; do
  echo "  forgetting ~/$r"
  chezmoi forget --force "$HOME/$r"
done

# ── Step 3: Re-add them fresh ───────────────────────────────────────────
echo
echo "==> Step 3: Re-adding ${#roots[@]} root path(s)..."
for r in "${roots[@]}"; do
  echo "  adding ~/$r"
  chezmoi add "$HOME/$r"
done

# ── Step 4: Commit & push the clean state ───────────────────────────────
echo
echo "==> Step 4: Committing clean state and pushing..."
git -C "$SOURCE_DIR" add -A
git -C "$SOURCE_DIR" commit -m "readd: clean re-add of ${#roots[@]} root path(s) ($(date -Is))" || true
git -C "$SOURCE_DIR" push

echo
echo "Done! ${#roots[@]} root path(s) re-added cleanly."
