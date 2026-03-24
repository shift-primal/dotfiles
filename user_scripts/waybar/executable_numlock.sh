#!/bin/bash

for path in /sys/class/leds/*"::numlock"; do
    if [[ -f "${path}/brightness" ]]; then
        state=$(cat "${path}/brightness")
        if [[ "$state" == "1" ]]; then
            echo '{"text": "󰎤", "tooltip": "Num Lock: ON", "class": "on"}'
        else
            echo '{"text": "󰎤", "tooltip": "Num Lock: OFF", "class": "off"}'
        fi
        exit 0
    fi
done

echo '{"text": "󰎤", "tooltip": "Num Lock LED not found", "class": "off"}'
