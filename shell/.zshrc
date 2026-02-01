export EDITOR=nvim
export VISUAL=nvim
export NNN_OPENER=nvim
export NNN_OPTS="eFH"
export NNN_COLORS="0000"
export NNN_FCOLORS="0000"

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]=fg=5
ZSH_HIGHLIGHT_STYLES[precommand]=fg=11,underline
ZSH_HIGHLIGHT_STYLES[alias]=fg=5,underline
ZSH_HIGHLIGHT_STYLES[arg]=fg=7
ZSH_HIGHLIGHT_STYLES[invalid]=fg=2,bold
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias zshconf='nvim .zshrc'
alias hyprconf='nvim .config/hypr/hyprland.conf'
alias set-wallpaper='userscripts/set-wallpaper.sh'
alias ff='fastfetch'
alias shutdown='shutdown now'
alias reboot='sudo reboot now'
alias pkg='comm -23 <(pacman -Slq | sort) <(pacman -Qq | sort) | fzf --preview 'pacman -Si {}''
alias yaypkg='comm -23 <(yay -Ss | sort) <(pacman -Qq | sort) | fzf --preview 'pacman -Ss ''
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'

PS1=' %F{cyan}%~ %(!.%F{red}❯.%F{green}❯)%f '
