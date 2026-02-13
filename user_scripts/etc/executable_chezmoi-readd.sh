#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="$(chezmoi source-path)"

# Collapse individual file paths to their top-level managed directory.
#   .config/hypr/hyprland/keybinds.conf  →  .config/hypr
#   .local/share/fonts/Mono.ttf          →  .local/share/fonts
#   user_scripts/rofi/launch-apps.sh     →  user_scripts/rofi
#   .bashrc                              →  .bashrc

collapse_to_root() {
  local rel="$1"
  IFS='/' read -ra parts <<<"$rel"
  local n=${#parts[@]}

  # .local/share/X/... → .local/share/X (3 levels)
  if [[ "${parts[0]}" == ".local" && "${parts[1]:-}" == "share" && $n -ge 4 ]]; then
    echo "${parts[0]}/${parts[1]}/${parts[2]}"
  # anything/X/... → anything/X (2 levels)
  elif [[ $n -ge 3 ]]; then
    echo "${parts[0]}/${parts[1]}"
  # bare files or single-depth paths stay as-is
  else
    echo "$rel"
  fi
}

# ── Gather dirty roots from chezmoi status (changed files) ────────────────
mapfile -t targets < <(chezmoi status | awk '{print $NF}')

mapfile -t roots < <(
  for t in "${targets[@]+"${targets[@]}"}"; do
    collapse_to_root "$t"
  done | sort -u
)

if [[ ${#roots[@]} -eq 0 ]]; then
  echo "Nothing to do — chezmoi status is clean."
  exit 0
fi

echo "Detected ${#targets[@]} changed target(s), collapsed to ${#roots[@]} root(s):"
printf '  ~/%s\n' "${roots[@]}"

# ── Step 1: Backup commit & push (only if repo is dirty) ─────────────────
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

# ── Step 2: Forget + re-add each dirty root ───────────────────────────────
# Re-adding a whole root directory picks up new files and drops deleted ones.
echo
echo "==> Step 2: Syncing roots..."
for r in "${roots[@]}"; do
  echo "  forgetting ~/$r"
  chezmoi forget --force "$HOME/$r"

  if [[ -e "$HOME/$r" ]]; then
    echo "  adding    ~/$r"
    chezmoi add "$HOME/$r"
  else
    echo "  removed   ~/$r (no longer exists on disk)"
  fi
done

# ── Step 3: Commit & push the clean state ─────────────────────────────────
echo
echo "==> Step 3: Committing and pushing..."
git -C "$SOURCE_DIR" add -A
git -C "$SOURCE_DIR" commit -m "readd: sync ${#roots[@]} root path(s) ($(date -Is))" || true
git -C "$SOURCE_DIR" push

echo
echo "Done! ${#roots[@]} root(s) synced."
