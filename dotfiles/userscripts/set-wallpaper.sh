#!/bin/bash

# If a new wallpaper is given as argument, set it and save path
if [ -n "$1" ]; then
    swww img "$1" --transition-type center --transition-fps 60
    wallust run "$1"
    pkill waybar && waybar
fi
