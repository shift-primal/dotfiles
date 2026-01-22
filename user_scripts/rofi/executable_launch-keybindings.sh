#!/usr/bin/env bash

# Path to your keybinds config
KEYBINDS_FILE="$HOME/.config/hypr/hyprland/keybinds.conf"

# Parse keybindings and format for rofi
parse_keybinds() {
    while IFS= read -r line; do
        # Skip comments and empty lines
        [[ "$line" =~ ^[[:space:]]*# ]] && continue
        [[ -z "$line" ]] && continue

        # Match bindd or binddm lines
        if [[ "$line" =~ ^bindd[m]?[[:space:]]*=[[:space:]]*([^,]+),[[:space:]]*([^,]+),[[:space:]]*\$d[[:space:]]*([^,]+), ]]; then
            modifiers="${BASH_REMATCH[1]}"
            key="${BASH_REMATCH[2]}"
            description="${BASH_REMATCH[3]}"

            # Replace $mainMod with Super
            modifiers="${modifiers//\$mainMod/Super}"

            # Clean up extra spaces
            modifiers=$(echo "$modifiers" | xargs)
            key=$(echo "$key" | xargs)
            description=$(echo "$description" | xargs)

            # Format the keybind
            keybind="${modifiers} + ${key}"

            # Output in format: "Description | Keybind"
            printf "%-50s | %s\n" "$description" "$keybind"
        fi
    done < "$KEYBINDS_FILE"
}

# Show in rofi
parse_keybinds | sort | rofi -dmenu -i -p "Keybindings" -theme-str 'window {width: 60%;}' -theme-str 'listview {columns: 1;}'
