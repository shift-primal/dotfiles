#!/bin/bash

for path in /sys/class/leds/*"::capslock"; do
    if [[ -f "${path}/brightness" ]]; then
        state=$(cat "${path}/brightness")
        if [[ "$state" == "1" ]]; then
            echo '{"text": "󰪛", "tooltip": "Caps Lock: ON", "class": "on"}'
        else
            echo '{"text": "󰪛", "tooltip": "Caps Lock: OFF", "class": "off"}'
        fi
        exit 0
    fi
done

echo '{"text": "󰪛", "tooltip": "Caps Lock LED not found", "class": "off"}'
