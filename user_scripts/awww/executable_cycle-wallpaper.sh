#!/bin/bash

WALLPAPER_DIR="$HOME/wallpapers"
STATE_FILE="$HOME/.config/awww-cycle-state"

# Create wallpaper directory if it doesn't exist
mkdir -p "$WALLPAPER_DIR"

# Get all image files in the wallpaper directory (sorted)
mapfile -t wallpapers < <(find -L "$WALLPAPER_DIR" -maxdepth 1 -type f -not -iname "current.*" \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.gif" -o -iname "*.webp" -o -iname "*.avif" -o -iname "*.bmp" \) | sort)

# Check if there are any wallpapers
if [ ${#wallpapers[@]} -eq 0 ]; then
  echo "Error: No wallpapers found in $WALLPAPER_DIR"
  exit 1
fi

# Read the last used index (default to -1 so first run uses index 0)
if [ -f "$STATE_FILE" ]; then
  last_index=$(cat "$STATE_FILE")
else
  last_index=-1
fi

# Calculate next index (wrap around)
next_index=$(((last_index + 1) % ${#wallpapers[@]}))

# Get the next wallpaper path
next_wallpaper="${wallpapers[$next_index]}"

# Set the wallpaper using awww
awww img "$next_wallpaper" --transition-type wipe --transition-fps 144

# Get the file extension
extension="${next_wallpaper##*.}"

# Remove any existing current.* symlinks
rm -f "$WALLPAPER_DIR"/current.*

# Create new symlink
ln -sf "$next_wallpaper" "$WALLPAPER_DIR/current.$extension"

# Save the current index for next time
echo "$next_index" >"$STATE_FILE"

echo "Wallpaper set: $next_wallpaper"
echo "Symlink: ~/wallpapers/current.$extension"
