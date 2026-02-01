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

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]=fg=12
ZSH_HIGHLIGHT_STYLES[precommand]=fg=11,underline
ZSH_HIGHLIGHT_STYLES[alias]=fg=5,underline
ZSH_HIGHLIGHT_STYLES[arg]=fg=7
ZSH_HIGHLIGHT_STYLES[invalid]=fg=2,bold

zinit ice wait lucid
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit light marlonrichert/zsh-autocomplete

zinit ice wait lucid
zinit light zsh-users/zsh-syntax-highlighting
