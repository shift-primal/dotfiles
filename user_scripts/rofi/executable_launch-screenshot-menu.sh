#!/usr/bin/env bash

rofi -show ssmenu \
  -modi "ssmenu:~/user_scripts/rofi/menus/screenshot-menu.sh" \
  -no-show-icons \
  -theme-str '
window { width: 360px; }
listview { lines: 7; }
inputbar { enabled: false; }'
