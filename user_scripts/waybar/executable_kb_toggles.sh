#!/bin/bash

find_led() {
	local name="$1"
	for path in /sys/class/leds/*"::${name}"; do
		[[ -f "${path}/brightness" ]] && echo "${path}/brightness" && return
	done
}

CAPS_PATH=$(find_led "capslock")
NUM_PATH=$(find_led "numlock")

caps_state=0
num_state=0

[[ -f "$CAPS_PATH" ]] && caps_state=$(cat "$CAPS_PATH")
[[ -f "$NUM_PATH" ]] && num_state=$(cat "$NUM_PATH")

caps_class=$([[ "$caps_state" == "1" ]] && echo "caps-on" || echo "caps-off")
num_class=$([[ "$num_state" == "1" ]] && echo "num-on" || echo "num-off")

echo "{\"text\": \"󰎤 󰪛\", \"tooltip\": \"Num Lock: $([[ $num_state == 1 ]] && echo ON || echo OFF)  Caps Lock: $([[ $caps_state == 1 ]] && echo ON || echo OFF)\", \"class\": [\"${num_class}\", \"${caps_class}\"]}"
