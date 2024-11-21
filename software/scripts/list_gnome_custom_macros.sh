#!/bin/bash

# Get all custom keybinding paths
paths=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings | tr -d "[]',")

echo "Custom Keybindings:"
for path in $paths; do
    name=$(gsettings get org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$path" name | tr -d "'")
    command=$(gsettings get org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$path" command | tr -d "'")
    binding=$(gsettings get org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$path" binding | tr -d "'")
    echo "- Name: $name"
    echo "  Command: $command"
    echo "  Binding: $binding"
    echo
done

