#!/usr/bin/env bash

set -euo pipefail

tmp_dir="/tmp/cliphist"
rm -rf "$tmp_dir"

if [[ -n "${ROFI_INFO:-}" ]]; then
  cliphist decode <<<"$ROFI_INFO" | wl-copy
  exit
fi

mkdir -p "$tmp_dir"
printf '\0prompt\x1f󰅇 Clipboard\n'

read -r -d '' prog <<'AWKEOF' || true
/^[0-9]+\s<meta http-equiv=/ { next }
match($0, /^([0-9]+)\s(\[\[\s)?binary.*(jpg|jpeg|png|bmp)/, grp) {
    system("echo " grp[1] "\\\\\t | cliphist decode >" tmp_dir "/" grp[1] "." grp[3])
    sub(/^[0-9]+\t/, "", $0)
    print $0 "\0info\x1f" grp[1] "\t\x1ficon\x1f" tmp_dir "/" grp[1] "." grp[3]
    next
}
{
    full = $0
    sub(/^[0-9]+\t/, "", $0)
    print $0 "\0info\x1f" full
}
AWKEOF
cliphist list | gawk -v tmp_dir="$tmp_dir" "$prog"
