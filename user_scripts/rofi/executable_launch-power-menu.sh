#!/usr/bin/env bash

rofi -show powermenu \
  -modi "powermenu:~/user_scripts/rofi/menus/power-menu.sh" \
  -no-show-icons \
  -theme-str '
window { width: 320px; }
listview { lines: 6; }
inputbar { enabled: false; }'
