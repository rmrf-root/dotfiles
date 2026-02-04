#!/usr/bin/env bash
set -e

echo "==Dotfiles setup=="

ask() {
    while true; do
        read -rp "$1 [y/n]: " yn
        case "$yn" in
            [Yy]*) return 0 ;;
            [Nn]*) return 1 ;;
            *) echo "Please answer y or n." ;;
        esac
    done
}

# --- Install base packages ---
if ask "Install base packages (git, base-devel)?"; then
    sudo pacman -S --needed --noconfirm git base-devel
fi

# --- Install yay-bin ---
if ask "Install yay-bin (AUR helper)?"; then
    if ! command -v yay >/dev/null; then
        git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
        (cd /tmp/yay-bin && makepkg -si --noconfirm)
    else
        echo "yay already installed."
    fi
fi

# --- Install official packages ---
if ask "Install official packages?"; then
    sudo pacman -S --needed --noconfirm \
    zsh zsh-autosuggestions zsh-syntax-highlighting wiremix waybar \
    ttf-jetbrains-mono swww stow slurp rofi openssh nnn nerd-fonts \
    neovim impala grim git fastfetch btop brightnessctl bluetui
fi

# --- Install AUR packages ---
if ask "Install AUR packages?"; then
    yay -S --needed --noconfirm wallust ungoogled-chromium-bin
fi

# --- Pacman include ---
if ask "Install Pacman config?"; then
    sudo sed -i '/^Include = \/etc\/pacman.d\/local.conf$/d' /etc/pacman.conf
    sudo sed -i '/^\[options\]/a Include = /etc/pacman.d/local.conf' /etc/pacman.conf
fi

# --- System dark color scheme (Chromium-compatible) ---
if ask "Set system color scheme to dark (Chromium, GTK, portals)?"; then
    mkdir -p "$HOME/.config/gtk-3.0"
    cat > "$HOME/.config/gtk-3.0/settings.ini" <<EOF
[Settings]
gtk-application-prefer-dark-theme=1
EOF
fi

# --- Stow dotfiles ---
if ask "Stow dotfiles?"; then
    read -rp "Enter path to dotfiles directory (default: $HOME/dotfiles): " DOTFILES_DIR
    DOTFILES_DIR=${DOTFILES_DIR:-$HOME/dotfiles}
    cd "$DOTFILES_DIR"
    if [ -d ~/.config/ ]; then
	    mv ~/.config ~/.config.bak
	    echo "moved existing .config to .config.bak"
    fi
    stow config shell userscripts wallpapers
    if ask "Stow pacman configs to /? (requires sudo)"; then
        sudo stow -t / pacman
    fi
fi

# --- OpenSSH setup ---
if ask "Generate SSH key for GitHub?"; then
    read -rp "Enter your email for SSH key: " GIT_EMAIL
    if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
        ssh-keygen -t ed25519 -C "$GIT_EMAIL" -f "$HOME/.ssh/id_ed25519" -N ""
    fi
    eval "$(ssh-agent -s)"
    ssh-add "$HOME/.ssh/id_ed25519"

    echo
    echo "=== COPY THIS SSH KEY TO GITHUB ==="
    cat "$HOME/.ssh/id_ed25519.pub"
    echo "=================================="
    read -rp "Press ENTER after adding the key to GitHub..."
fi

# --- Git remote setup ---
if ask "Update Git remote to SSH?"; then
    read -rp "Enter GitHub username: " GIT_USER
    read -rp "Enter repository name: " GIT_REPO
    ssh -T git@github.com || true
    git remote set-url origin git@github.com:${GIT_USER}/${GIT_REPO}.git || true
fi

# --- TTY1 autologin ---
if ask "Enable TTY1 autologin?"; then
    read -rp "Enter username for autologin: " AUTOLOGIN_USER
    sudo mkdir -p /etc/systemd/system/getty@tty1.service.d
    sudo tee /etc/systemd/system/getty@tty1.service.d/override.conf >/dev/null <<EOF
[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin ${AUTOLOGIN_USER} --noclear %I \$TERM
EOF
    sudo systemctl daemon-reexec
    sudo systemctl restart getty@tty1
fi

echo "== Setup complete =="
