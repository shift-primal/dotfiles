#!/usr/bin/env bash

rofi -show keybinds \
  -modi "keybinds:~/user_scripts/rofi/menus/keybinds-menu.sh" \
  -markup-rows \
  -theme-str '
window { width: 900px; }
listview { lines: 26; }
element { padding: 4px 8px; }'
