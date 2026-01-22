#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# Rofi Screenshot/Recording Menu for Hyprcap
# Matches power-menu.sh style │ Bash 5+ │ Hyprland
# ─────────────────────────────────────────────────────────────────────────────

set -euo pipefail

# ─────────────────────────────────────────────────────────────────────────────
# Single Instance Lock
# ─────────────────────────────────────────────────────────────────────────────
exec 9>"${XDG_RUNTIME_DIR}/rofi-screenshot.lock"
flock -n 9 || exit 0

# ─────────────────────────────────────────────────────────────────────────────
# Configuration
# ─────────────────────────────────────────────────────────────────────────────

RECORDINGS_DIR="/home/kasper/Videos/Hyprcap_recordings"
SCREENSHOT_DIR="/home/kasper/Pictures/Hyprcap_screenshots"

# User Defined Icons
declare -Ar ICONS=(
  [screenshot]="󰹑"
  [screenshot_monitor]="󰍹"
  [screenshot_window]="󱂬"
  [record]="󰻂"
  [record_monitor]="󰍹"
  [record_window]="󱂬"
  [stop]="󰓛"
  [cancel]="󰜺"
  [confirm]=""
  [back]="󰁍"
  [monitor]="󰍹"
  [window]="󱂬"
  [active]="󰆤"
)

# Menu entries
declare -Ar MENU=(
  [screenshot]="${ICONS[screenshot]}  Screenshot Region"
  [screenshot_monitor]="${ICONS[screenshot_monitor]}  Screenshot Monitor"
  [screenshot_window]="${ICONS[screenshot_window]}  Screenshot Window"
  [record]="${ICONS[record]}  Record Region"
  [record_monitor]="${ICONS[record_monitor]}  Record Monitor"
  [record_window]="${ICONS[record_window]}  Record Window"
  [stop]="${ICONS[stop]}  Stop Recording"
)

# Display order
declare -ar ORDER=(screenshot screenshot_monitor screenshot_window record record_monitor record_window stop)

# Actions requiring confirmation
declare -Ar CONFIRM=([stop]=1)

# Actions requiring monitor selection
declare -Ar NEEDS_MONITOR=([screenshot_monitor]=1 [record_monitor]=1)

# Actions requiring window selection
declare -Ar NEEDS_WINDOW=([screenshot_window]=1 [record_window]=1)

# ─────────────────────────────────────────────────────────────────────────────
# Helper Functions
# ─────────────────────────────────────────────────────────────────────────────

get_monitors() {
  hyprctl monitors -j | jq -r '.[].name'
}

get_windows() {
  # Output: address|class|title (one per line)
  hyprctl clients -j | jq -r '.[] | select(.title != "") | "\(.address)|\(.class)|\(.title)"'
}

# ─────────────────────────────────────────────────────────────────────────────
# Action Dispatcher
# ─────────────────────────────────────────────────────────────────────────────

execute() {
  local action=$1
  local target=${2:-}

  case $action in
  screenshot)
    setsid hyprcap --output-dir "$SCREENSHOT_DIR" -w -c shot -s region &>/dev/null 9>&- &
    ;;
  screenshot_monitor)
    setsid hyprcap --output-dir "$SCREENSHOT_DIR" -w -c shot -s "monitor:$target" &>/dev/null 9>&- &
    ;;
  screenshot_window)
    setsid hyprcap --output-dir "$SCREENSHOT_DIR" -w -c shot -s "window:$target" &>/dev/null 9>&- &
    ;;
  record)
    setsid hyprcap --output-dir "$RECORDINGS_DIR" -w rec-start -s region &>/dev/null 9>&- &
    ;;
  record_monitor)
    setsid hyprcap --output-dir "$RECORDINGS_DIR" -w rec-start -s "monitor:$target" &>/dev/null 9>&- &
    ;;
  record_window)
    setsid hyprcap --output-dir "$RECORDINGS_DIR" -w rec-start -s "window:$target" &>/dev/null 9>&- &
    ;;
  stop)
    setsid hyprcap rec-stop &>/dev/null 9>&- &
    ;;
  esac
}

# ─────────────────────────────────────────────────────────────────────────────
# Sub-menu Renderers
# ─────────────────────────────────────────────────────────────────────────────

show_monitor_menu() {
  local action=$1
  printf '\0prompt\x1fMonitor\n'
  printf '\0no-custom\x1ftrue\n'
  # Active monitor option
  printf '%s  Active Monitor\0info\x1f%s:active\n' "${ICONS[active]}" "$action"
  # List all monitors
  while IFS= read -r mon; do
    printf '%s  %s\0info\x1f%s:%s\n' "${ICONS[monitor]}" "$mon" "$action" "$mon"
  done < <(get_monitors)
  # Back option
  printf '%s  Back\0info\x1fback\n' "${ICONS[back]}"
}

show_window_menu() {
  local action=$1
  printf '\0prompt\x1fWindow\n'
  printf '\0no-custom\x1ftrue\n'
  # Active window option
  printf '%s  Active Window\0info\x1f%s:active\n' "${ICONS[active]}" "$action"
  # List all windows
  while IFS='|' read -r addr class title; do
    # Truncate long titles
    [[ ${#title} -gt 50 ]] && title="${title:0:47}..."
    printf '%s  %s (%s)\0info\x1f%s:%s\n' "${ICONS[window]}" "$title" "$class" "$action" "$addr"
  done < <(get_windows)
  # Back option
  printf '%s  Back\0info\x1fback\n' "${ICONS[back]}"
}

show_main_menu() {
  printf '\0prompt\x1fCapture\n'
  printf '\0no-custom\x1ftrue\n'
  for k in "${ORDER[@]}"; do
    printf '%s\0info\x1f%s\n' "${MENU[$k]}" "$k"
  done
}

# ─────────────────────────────────────────────────────────────────────────────
# Rofi Interface
# ─────────────────────────────────────────────────────────────────────────────

# Parse ROFI_INFO — format: "action" or "action:target"
IFS=: read -r action target <<<"${ROFI_INFO:-}"

# Phase 1: No selection — render main menu
if [[ -z ${action:-} ]]; then
  show_main_menu
  exit 0
fi

# Phase 2: Handle cancel/back
[[ $action == cancel ]] && exit 0
[[ $action == back ]] && { show_main_menu; exit 0; }

# Phase 3: Action needs monitor selection — show sub-menu
if [[ -v NEEDS_MONITOR[$action] && -z ${target:-} ]]; then
  show_monitor_menu "$action"
  exit 0
fi

# Phase 4: Action needs window selection — show sub-menu
if [[ -v NEEDS_WINDOW[$action] && -z ${target:-} ]]; then
  show_window_menu "$action"
  exit 0
fi

# Phase 5: Validate main menu keys (only if no target)
if [[ -z ${target:-} && ! -v MENU[$action] ]]; then
  exit 1
fi

# Phase 6: Confirmation required — show dialog
if [[ -v CONFIRM[$action] && ${target:-} != confirmed ]]; then
  label=${MENU[$action]#* }
  printf '\0prompt\x1f%s?\n' "$label"
  printf '%s  Yes, Confirm\0info\x1f%s:confirmed\n' "${ICONS[confirm]}" "$action"
  printf '%s  No, Cancel\0info\x1fcancel\n' "${ICONS[cancel]}"
  exit 0
fi

# Phase 7: Execute action
if [[ ${target:-} == confirmed ]]; then
  # Confirmation actions (like stop)
  execute "$action"
elif [[ -n ${target:-} ]]; then
  # Actions with target (monitor/window)
  execute "$action" "$target"
else
  # Simple actions (like region screenshot)
  execute "$action"
fi
