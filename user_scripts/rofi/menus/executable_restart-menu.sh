#!/usr/bin/env bash

set -euo pipefail

declare -Ar ICONS=(
	[waybar]=""
	[cancel]="󰜺"
	[confirm]=""
)

declare -Ar MENU=(
	[waybar]="${ICONS[waybar]}  Waybar"

)

declare -ar ORDER=(waybar)

declare -Ar CONFIRM=([waybar]=1)

execute() {
	case $1 in
	waybar)
		setsid killall waybar && sleep 1 && waybar &>/dev/null 9>&- &
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
