# Config
## Yay setup
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si
## Auto Login
sudo systemctl edit getty@tty1  
sudo systemctl daemon-reexec  
sudo systemctl restart getty@tty1  
### Put this inside
[Service]  
ExecStart=  
ExecStart=-/sbin/agetty --autologin user --noclear %I $TERM  
## OpenSSH setup
ssh-keygen -t ed25519 -C "email"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
## Git setup
ssh -T git@github.com
git remote set-url origin git@github.com:username/repo.git

# Packages
## Official
zsh zsh-autosuggestions zsh-syntax-highlighting wiremix waybar ttf-jetbrains-mono swww stow slurp rofi openssh nnn nerd-fonts neovim impala grim git fastfetch btop brightnessctl bluetui
## AUR
wallust ungoogled-chromium-bin
