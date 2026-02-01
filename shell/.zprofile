export EDITOR=nvim
export VISUAL=nvim
export NNN_OPENER=nvim
export NNN_OPTS="eFH"
export NNN_COLORS="0000"
export NNN_FCOLORS="0000"

if [[ -z "$WAYLAND_DISPLAY" && -z "$DISPLAY" && "$(tty)" == "/dev/tty1" ]]; then
  exec start-hyprland
fi
