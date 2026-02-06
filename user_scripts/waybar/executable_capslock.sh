#!/bin/bash

# Caps Lock indicator for Waybar
# Reads the LED state from /sys/class/leds/

LED_PATH="/sys/class/leds/input13::capslock/brightness"

if [[ -f "$LED_PATH" ]]; then
    state=$(cat "$LED_PATH")
    if [[ "$state" == "1" ]]; then
        echo '{"text": "󰪛", "tooltip": "Caps Lock: ON", "class": "on"}'
    else
        echo '{"text": "", "tooltip": "Caps Lock: OFF", "class": "off"}'
    fi
else
    echo '{"text": "", "tooltip": "Caps Lock LED not found", "class": "off"}'
fi
