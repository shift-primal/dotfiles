#!/usr/bin/env bash

# Recording indicator script for Waybar
# Checks hyprcap recording status via PID file

REC_PID_PATH="${XDG_RUNTIME_DIR:-/run}/hyprcap_rec.pid"
RECORDINGS_DIR="$HOME/Videos/Hyprcap_recordings"

is_recording() {
    if [[ -f "$REC_PID_PATH" ]]; then
        local pid
        pid=$(cat "$REC_PID_PATH" 2>/dev/null)
        if [[ -n "$pid" ]] && kill -0 "$pid" 2>/dev/null; then
            return 0
        fi
    fi
    return 1
}

get_elapsed() {
    local start_time elapsed hours mins secs
    start_time=$(stat -c %Y "$REC_PID_PATH" 2>/dev/null)
    elapsed=$(($(date +%s) - start_time))

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
        setsid hyprcap --output-dir "$RECORDINGS_DIR" -w rec-start -s region &>/dev/null &
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
    echo '{"text": "󰑊", "tooltip": "Click to record region\\nRight-click for menu", "class": "idle"}'
fi
