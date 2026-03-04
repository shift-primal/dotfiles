##!/usr/bin/env bash
## Auto-toggle gamemode submap based on focused window class
## Listens to Hyprland IPC for activewindow events
#
## Define game window patterns (regex)
#GAME_PATTERNS=(
#    "^steam_app_"
#    # Add more patterns here:
#    # "^cs2$"
#    # "^gamescope$"
#    # "^lutris"
#)
#
## Track current state internally
#IN_GAMEMODE=false
#
#is_game() {
#    local class="$1"
#    for pattern in "${GAME_PATTERNS[@]}"; do
#        if [[ "$class" =~ $pattern ]]; then
#            return 0
#        fi
#    done
#    return 1
#}
#
#handle_focus() {
#    local class="$1"
#
#    if is_game "$class"; then
#        if [[ "$IN_GAMEMODE" == false ]]; then
#            hyprctl dispatch submap gamemode
#            notify-send -t 2000 -u low "Gamemode" "Enabled"
#            IN_GAMEMODE=true
#        fi
#    else
#        if [[ "$IN_GAMEMODE" == true ]]; then
#            hyprctl dispatch submap reset
#            notify-send -t 2000 -u low "Gamemode" "Disabled"
#            IN_GAMEMODE=false
#        fi
#    fi
#}
#
## Listen to Hyprland socket for activewindow events
#socat -U - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do
#    if [[ "$line" =~ ^activewindow\>\> ]]; then
#        # Format: activewindow>>CLASS,TITLE
#        class="${line#activewindow>>}"
#        class="${class%%,*}"
#        handle_focus "$class"
#    fi
#done
