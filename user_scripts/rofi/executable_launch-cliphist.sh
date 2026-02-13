#!/usr/bin/env bash

rofi -show clipboard \
  -modi "clipboard:~/user_scripts/rofi/menus/cliphist-menu.sh" \
  -show-icons \
  -theme-str '
window { width: 680px; }
listview { lines: 16; }'
