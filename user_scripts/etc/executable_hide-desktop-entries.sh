#!/bin/bash

# Script to hide .desktop files by adding NoDisplay=true

DESKTOP_DIR="$HOME/.local/share/applications"

echo "Desktop Entry Hider"
echo "==================="
echo ""

# Get list of .desktop files (full paths, handles spaces in names)
mapfile -t files < <(printf '%s\n' "$DESKTOP_DIR"/*.desktop)

# Check if the glob matched anything (no match returns the literal pattern)
if [ ${#files[@]} -eq 0 ] || [ ! -e "${files[0]}" ]; then
  echo "No .desktop files found in $DESKTOP_DIR"
  exit 1
fi

is_hidden() {
  grep -qE "^(NoDisplay=true|NotShowIn=.+)" "$1" 2>/dev/null
}

# Display files with numbers, skipping already hidden
echo "Available .desktop files:"
has_visible=false
for i in "${!files[@]}"; do
  if is_hidden "${files[$i]}"; then
    continue
  fi
  has_visible=true
  echo "  $((i + 1)). ${files[$i]##*/}"
done

if [ "$has_visible" = false ]; then
  echo "  (all entries are already hidden)"
  exit 0
fi

echo ""
echo "Enter numbers to hide (space-separated, e.g., '1 3 5'), or 'all' for all, or 'q' to quit:"
read -r selection

if [ "$selection" = "q" ]; then
  echo "Cancelled."
  exit 0
fi

# Parse selection, filtering out already hidden
selected_indices=()
if [ "$selection" = "all" ]; then
  for i in "${!files[@]}"; do
    is_hidden "${files[$i]}" || selected_indices+=("$i")
  done
else
  for num in $selection; do
    idx=$((num - 1))
    if [ "$idx" -ge 0 ] && [ "$idx" -lt ${#files[@]} ]; then
      if is_hidden "${files[$idx]}"; then
        echo "Warning: ${files[$idx]##*/} is already hidden, skipping"
      else
        selected_indices+=("$idx")
      fi
    else
      echo "Warning: Invalid number $num, skipping"
    fi
  done
fi

if [ ${#selected_indices[@]} -eq 0 ]; then
  echo "No valid selections made."
  exit 0
fi

echo ""
echo "Will hide the following files:"
for idx in "${selected_indices[@]}"; do
  echo "  - ${files[$idx]##*/}"
done

echo ""
echo "Proceed? (y/n):"
read -r confirm

if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
  echo "Cancelled."
  exit 0
fi

# Process files
for idx in "${selected_indices[@]}"; do
  file="${files[$idx]}"
  name="${file##*/}"

  if grep -q "^NoDisplay=" "$file" 2>/dev/null; then
    # Replace existing NoDisplay line
    if [ -w "$file" ]; then
      sed -i 's/^NoDisplay=.*/NoDisplay=true/' "$file"
    else
      sudo sed -i 's/^NoDisplay=.*/NoDisplay=true/' "$file"
    fi
    echo "  Updated: $name"
  else
    # Add NoDisplay=true after [Desktop Entry] header
    if [ -w "$file" ]; then
      sed -i '/^\[Desktop Entry\]/a NoDisplay=true' "$file"
    else
      sudo sed -i '/^\[Desktop Entry\]/a NoDisplay=true' "$file"
    fi
    echo "  Hidden:  $name"
  fi
done

echo ""
echo "Done! ${#selected_indices[@]} entries hidden."
