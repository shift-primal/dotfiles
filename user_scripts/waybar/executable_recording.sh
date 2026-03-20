#!/usr/bin/env bash

# Recording indicator script for Waybar
# Checks hyprcap recording status via wf-recorder process

RECORDINGS_DIR="$HOME/Videos/Hyprcap_recordings"

is_recording() {
	pgrep -x wf-recorder &>/dev/null
}

get_elapsed() {
	local pid elapsed hours mins secs
	pid=$(pgrep -x wf-recorder)
	elapsed=$(ps -o etimes= -p "$pid" 2>/dev/null | tr -d ' ')

	hours=$((elapsed / 3600))
	mins=$(((elapsed % 3600) / 60))
	secs=$((elapsed % 60))

	if ((hours > 0)); then
		printf '%d:%02d:%02d' "$hours" "$mins" "$secs"
	else
		printf '%d:%02d' "$mins" "$secs"
	fi
}

toggle() {
	if is_recording; then
		hyprcap rec-stop
	else
		hyprcap -w --output-dir "$RECORDINGS_DIR" rec-start -s region &>/dev/null &
	fi
}

# Handle toggle action
if [[ "${1:-}" == "toggle" ]]; then
	toggle
	exit 0
fi

# Output status for waybar
if is_recording; then
	elapsed=$(get_elapsed)
	printf '{"text": "󰑊 %s", "tooltip": "Recording in progress\\nClick to stop", "class": "recording"}\n' "$elapsed"
else
	echo '{"text": "󰑊", "tooltip": "Click to record region\nRight-click for menu", "class": "idle"}'
fi
