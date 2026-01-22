#!/bin/bash

RECORDINGS_DIR="/home/kasper/Videos/Hyprcap_recordings"
SCREENSHOT_DIR="/home/kasper/Pictures/Hyprcap_screenshots/"

case "$1" in
record | rec)
  hyprcap --output-dir "$RECORDINGS_DIR" -w rec -s region
  ;;
screenshot | ss)
  hyprcap --output-dir "$SCREENSHOT_DIR" -w -c shot -s region
  ;;
h | help)
  echo "Usage: $0 {record|screenshot}"
  exit 1
  ;;
esac
