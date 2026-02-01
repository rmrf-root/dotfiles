# Packages
## Official
zsh wiremix waybar swww stow slurp rofi nnn neovim impala grim git btop bluetui
## AUR
wallust ungoogled-chromium-bin

# Config
## Auto Login
sudo systemctl edit getty@tty1
### Put this inside
[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin user --noclear %I $TERM
