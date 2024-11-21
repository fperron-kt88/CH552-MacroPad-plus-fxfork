#!/bin/bash

# Define shortcut configurations
declare -A shortcuts=(
    ["FX_F13"]="<Alt>Tools"
    ["FX_F14"]="Launch5"
    ["FX_F15"]="Launch6"
    ["FX_F16"]="Launch7"
    ["FX_F17"]="Launch8"
    ["FX_F18"]="Launch9"
)

# Base path for GNOME custom shortcuts
BASE_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"

# Get the current list of custom keybindings
current_bindings=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)

# Ensure the list of bindings is in a clean format
current_bindings=$(echo "$current_bindings" | tr -d "[]',")

# Initialize an updated list of bindings
new_bindings=()

# Check existing shortcuts and update as necessary
for key in "${!shortcuts[@]}"; do
    shortcut_path="$BASE_PATH/$key/"

    if [[ $current_bindings == *"$shortcut_path"* ]]; then
        # Shortcut exists; verify and update if necessary
        existing_command=$(gsettings get org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$shortcut_path" command | tr -d "'")
        existing_binding=$(gsettings get org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$shortcut_path" binding | tr -d "'")

        if [[ "$existing_command" != "fx_macro_redirect.sh --key=$key" || "$existing_binding" != "${shortcuts[$key]}" ]]; then
            echo "Updating shortcut: $key"
            gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$shortcut_path" command "fx_macro_redirect.sh --key=$key"
            gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$shortcut_path" binding "${shortcuts[$key]}"
        else
            echo "Shortcut $key is already correctly configured."
        fi
    else
        # Shortcut does not exist; create it
        echo "Creating shortcut: $key"
        gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$shortcut_path" name "$key"
        gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$shortcut_path" command "fx_macro_redirect.sh --key=$key"
        gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$shortcut_path" binding "${shortcuts[$key]}"
    fi

    # Add this shortcut to the new bindings list
    new_bindings+=("$shortcut_path")
done

# Update GNOME with the complete list of bindings
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "[$(printf "'%s', " "${new_bindings[@]}" | sed 's/, $//')]"

echo "Shortcut configuration complete."

