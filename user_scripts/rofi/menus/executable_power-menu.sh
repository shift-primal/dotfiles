#!/usr/bin/env bash

set -euo pipefail

exec 9>"${XDG_RUNTIME_DIR}/rofi-power.lock"
flock -n 9 || exit 0

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

declare -Ar MENU=(
  [lock]="${ICONS[lock]}  Lock"
  [logout]="${ICONS[logout]}  Logout"
  [suspend]="${ICONS[suspend]}  Suspend"
  [reboot]="${ICONS[reboot]}  Reboot"
  [soft_reboot]="${ICONS[soft_reboot]}  Soft Reboot"
  [shutdown]="${ICONS[shutdown]}  Shutdown"
)

declare -ar ORDER=(shutdown reboot lock logout suspend soft_reboot)

declare -Ar CONFIRM=([shutdown]=1 [reboot]=1 [logout]=1 [soft_reboot]=1)

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

IFS=: read -r key state <<<"${ROFI_INFO:-}"

if [[ -z ${key:-} ]]; then
  printf '\0prompt\x1f󰐥 Power\n'
  printf '\0no-custom\x1ftrue\n'
  for k in "${ORDER[@]}"; do
    printf '%s\0info\x1f%s\n' "${MENU[$k]}" "$k"
  done
  exit 0
fi

[[ $key == cancel ]] && exit 0

[[ -v MENU[$key] ]] || exit 1

if [[ ${state:-} == confirmed ]]; then
  execute "$key"
  exit 0
fi

if [[ -v CONFIRM[$key] ]]; then
  label=${MENU[$key]#* }
  printf '\0prompt\x1f󰐥 %s?\n' "$label"
  printf '%s Yes, Confirm\0info\x1f%s:confirmed\n' "${ICONS[confirm]}" "$key"
  printf '%s No, Cancel\0info\x1fcancel\n' "${ICONS[cancel]}"
  exit 0
fi

execute "$key"
