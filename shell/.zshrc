if [ -z "$WAYLAND_DISPLAY" ]; then
    exec start-hyprland
fi

PS1=' %F{cyan}%~ %(!.%F{red}❯.%F{green}❯)%f '

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

export EDITOR=nvim
export VISUAL=nvim

alias zshconf='nvim .zshrc'
alias hyprconf='nvim .config/hypr/hyprland.conf'
alias set-wallpaper='userscripts/set-wallpaper.sh'
alias ff='fastfetch'
alias shutdown='shutdown now'
alias reboot='sudo reboot now'
alias pkg='comm -23 <(pacman -Slq | sort) <(pacman -Qq | sort) | fzf --preview 'pacman -Si {}''
alias yaypkg='comm -23 <(yay -Ss | sort) <(pacman -Qq | sort) | fzf --preview 'pacman -Ss ''
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'
