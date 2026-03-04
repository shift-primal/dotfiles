#!/bin/bash

set_opaque() {
  hyprctl --batch "$(hyprctl clients -j | jq -r --arg v "$1" '.[].address | "dispatch setprop address:\(.) opaque \($v);"')"

}

if pkill hyprpicker; then
  set_opaque "0"
else
  set_opaque "1 lock"
  hyprpicker -a
  set_opaque "0"
fi
