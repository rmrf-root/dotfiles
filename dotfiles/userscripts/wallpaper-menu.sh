#!/bin/bash
CHOICE=$(find "wallpapers" -type f \( -iname "*.jpg" -o -iname "*.png" \) | sort | rofi -dmenu -i -p "Select Wallpaper")

if [ -n "$CHOICE" ]; then
    ~/userscripts/set-wallpaper.sh "$CHOICE"
fi
