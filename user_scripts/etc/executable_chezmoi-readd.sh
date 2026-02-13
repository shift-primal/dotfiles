#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="$(chezmoi source-path)"

# Collapse file paths to their top-level managed directory.
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

# Remove roots already covered by a parent root.
deduplicate_roots() {
  local -a sorted
  mapfile -t sorted < <(sort)
  local -a result=()

  for root in "${sorted[@]}"; do
    local covered=false
    for kept in "${result[@]}"; do
      if [[ "$root" == "$kept"/* ]]; then
        covered=true
        break
      fi
    done
    [[ "$covered" == false ]] && result+=("$root")
  done
  printf '%s\n' "${result[@]}"
}

# ── Get all managed roots ─────────────────────────────────────────────────
mapfile -t all_roots < <(
  chezmoi managed --path-style relative | while IFS= read -r m; do
    collapse_to_root "$m"
  done | sort -u
)

# ── Build a set of dirty roots from chezmoi status (updated/deleted) ──────
declare -A dirty_roots
while IFS= read -r line; do
  [[ -z "$line" ]] && continue
  target="$(awk '{print $NF}' <<<"$line")"
  dirty_roots["$(collapse_to_root "$target")"]=1
done < <(chezmoi status)

# ── Check for managed files that no longer exist on disk ──────────────────
while IFS= read -r managed; do
  [[ ! -e "$HOME/$managed" ]] && dirty_roots["$(collapse_to_root "$managed")"]=1
done < <(chezmoi managed --path-style relative)

# ── Build managed file lookup set ─────────────────────────────────────────
declare -A managed_set
while IFS= read -r m; do
  managed_set["$m"]=1
done < <(chezmoi managed --path-style relative)

# ── Check each clean root for new (untracked) files on disk ───────────────
for root in "${all_roots[@]}"; do
  [[ -v dirty_roots["$root"] ]] && continue
  root_path="$HOME/$root"
  [[ -d "$root_path" ]] || continue

  while IFS= read -r file; do
    rel="${file#"$HOME/"}"
    if [[ ! -v managed_set["$rel"] ]]; then
      dirty_roots["$root"]=1
      break
    fi
  done < <(find "$root_path" -type f)
done

# ── Collect, deduplicate, and filter roots ────────────────────────────────
mapfile -t roots < <(printf '%s\n' "${!dirty_roots[@]}" | deduplicate_roots)

if [[ ${#roots[@]} -eq 0 ]]; then
  echo "Nothing to do — everything is in sync."
  exit 0
fi

echo "${#roots[@]} root(s) to sync:"
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
echo
echo "==> Step 2: Syncing roots..."
for r in "${roots[@]}"; do
  echo "  forgetting ~/$r"
  chezmoi forget --force "$HOME/$r"

  if [[ -e "$HOME/$r" ]]; then
    echo "  adding    ~/$r"
    if ! chezmoi add "$HOME/$r" 2>&1; then
      echo "  warning: some files in ~/$r could not be added (skipped)"
    fi
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
