#!/usr/bin/env bash

rofi -show restartmenu \
	-modi "restartmenu:~/user_scripts/rofi/menus/restart-menu.sh" \
	-no-show-icons \
	-theme-str '
window { width: 320px; }
listview { lines: 6; }
inputbar { enabled: false; }'
