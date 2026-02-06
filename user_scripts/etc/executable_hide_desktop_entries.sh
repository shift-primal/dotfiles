#!/bin/bash

# Script to hide .desktop files by adding NoDisplay=true

echo "Desktop Entry Hider"
echo "==================="
echo ""

# Get list of .desktop files
mapfile -t files < <(ls -1 *.desktop 2>/dev/null)

if [ ${#files[@]} -eq 0 ]; then
    echo "No .desktop files found in current directory"
    exit 1
fi

# Display files with numbers
echo "Available .desktop files:"
for i in "${!files[@]}"; do
    # Check if already hidden
    if grep -q "^NoDisplay=true" "${files[$i]}" 2>/dev/null; then
        echo "  $((i+1)). ${files[$i]} [ALREADY HIDDEN]"
    else
        echo "  $((i+1)). ${files[$i]}"
    fi
done

echo ""
echo "Enter numbers to hide (space-separated, e.g., '1 3 5'), or 'all' for all, or 'q' to quit:"
read -r selection

if [ "$selection" = "q" ]; then
    echo "Cancelled."
    exit 0
fi

# Parse selection
if [ "$selection" = "all" ]; then
    selected_indices=("${!files[@]}")
else
    selected_indices=()
    for num in $selection; do
        idx=$((num-1))
        if [ $idx -ge 0 ] && [ $idx -lt ${#files[@]} ]; then
            selected_indices+=($idx)
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
    echo "  - ${files[$idx]}"
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

    # Check if already has NoDisplay
    if grep -q "^NoDisplay=" "$file" 2>/dev/null; then
        # Replace existing NoDisplay line
        if [ -w "$file" ]; then
            sed -i 's/^NoDisplay=.*/NoDisplay=true/' "$file"
            echo "✓ Updated $file"
        else
            sudo sed -i 's/^NoDisplay=.*/NoDisplay=true/' "$file"
            echo "✓ Updated $file (with sudo)"
        fi
    else
        # Add NoDisplay=true
        if [ -w "$file" ]; then
            echo "NoDisplay=true" >> "$file"
            echo "✓ Hidden $file"
        else
            echo "NoDisplay=true" | sudo tee -a "$file" > /dev/null
            echo "✓ Hidden $file (with sudo)"
        fi
    fi
done

echo ""
echo "Done! The selected entries are now hidden."
