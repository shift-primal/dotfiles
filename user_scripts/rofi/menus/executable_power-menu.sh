#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# Rofi Power Menu for Hyprland + UWSM
# Optimized for Arch Linux │ Bash 5+ │ Zero dependencies beyond core system
# ─────────────────────────────────────────────────────────────────────────────

set -euo pipefail

# ─────────────────────────────────────────────────────────────────────────────
# Single Instance Lock
# ─────────────────────────────────────────────────────────────────────────────
exec 9>"${XDG_RUNTIME_DIR}/rofi-power.lock"
flock -n 9 || exit 0

# ─────────────────────────────────────────────────────────────────────────────
# Configuration
# ─────────────────────────────────────────────────────────────────────────────

# User Defined Icons
declare -Ar ICONS=(
  [shutdown]="󰐥"
  [reboot]="󰜉"
  [suspend]="󰤄"
  [soft_reboot]="󰁯"
  [logout]="󰍃"
  [lock]="󰌾"
  [cancel]="󰜺"
  [confirm]=""
)

# Menu entries: Combines your Icons with the original Labels
declare -Ar MENU=(
  [lock]="${ICONS[lock]}  Lock"
  [logout]="${ICONS[logout]}  Logout"
  [suspend]="${ICONS[suspend]}  Suspend"
  [reboot]="${ICONS[reboot]}  Reboot"
  [soft_reboot]="${ICONS[soft_reboot]}  Soft Reboot"
  [shutdown]="${ICONS[shutdown]}  Shutdown"
)

# Display order
declare -ar ORDER=(shutdown reboot lock logout suspend soft_reboot)

# Actions requiring confirmation
declare -Ar CONFIRM=([shutdown]=1 [reboot]=1 [logout]=1 [soft_reboot]=1)

# ─────────────────────────────────────────────────────────────────────────────
# Action Dispatcher
# ─────────────────────────────────────────────────────────────────────────────

execute() {
  case $1 in
  lock)
    setsid hyprlock &>/dev/null 9>&- &
    ;;
  logout)
    setsid hyprshutdown &>/dev/null 9>&- &
    ;;
  suspend)
    setsid systemctl suspend &>/dev/null 9>&- &
    ;;
  reboot)
    systemctl reboot
    ;;
  soft_reboot)
    systemctl soft-reboot
    ;;
  shutdown)
    systemctl poweroff
    ;;
  esac
}

# ─────────────────────────────────────────────────────────────────────────────
# Rofi Interface
# ─────────────────────────────────────────────────────────────────────────────

# ROFI_INFO contains our action key from the selected entry's info field
IFS=: read -r key state <<<"${ROFI_INFO:-}"

# Phase 1: No selection — render main menu
if [[ -z ${key:-} ]]; then
  # Get pretty uptime, remove 'up ' prefix for cleanliness
  # e.g., "3 hours, 20 minutes"
  uptime_str=$(uptime -p | sed 's/^up //')

  printf '\0prompt\x1fUptime:\n'
  printf '\0no-custom\x1ftrue\n'
  printf '\0theme\x1fentry { placeholder: "%s"; }\n' "$uptime_str"
  for k in "${ORDER[@]}"; do
    printf '%s\0info\x1f%s\n' "${MENU[$k]}" "$k"
  done
  exit 0
fi

# Phase 2: Handle cancel
[[ $key == cancel ]] && exit 0

# Phase 3: Validate key exists
[[ -v MENU[$key] ]] || exit 1

# Phase 4: Confirmed action — execute
if [[ ${state:-} == confirmed ]]; then
  execute "$key"
  exit 0
fi

# Phase 5: Requires confirmation — show dialog
if [[ -v CONFIRM[$key] ]]; then
  # Strip the icon from the label for the prompt text (removes up to the first two spaces)
  label=${MENU[$key]#* }
  printf '\0prompt\x1f%s?\n' "$label"
  printf '%s Yes, Confirm\0info\x1f%s:confirmed\n' "${ICONS[confirm]}" "$key"
  printf '%s No, Cancel\0info\x1fcancel\n' "${ICONS[cancel]}"
  exit 0
fi

# Phase 6: No confirmation needed — execute directly
execute "$key"
