#!/usr/bin/env bash
# All-in-one TUI package manager for pacman + yay

# 1️⃣ List all packages for selection
get_package_list() {
    # Installed packages (repo + AUR)
    local installed
    installed=$(pacman -Qq; yay -Qq)  

    # Repo packages not installed
    local repo
    repo=$(comm -23 <(pacman -Slq | sort) <(pacman -Qq | sort))  

    # AUR packages not installed
    local aur
    aur=$(yay -Ss '' 2>/dev/null | grep '^aur/' | awk '{print $1}' | sed 's|^aur/||' | sort)
    aur=$(comm -23 <(echo "$aur") <(yay -Qq | sort))

    # Combine installed and installable with tags
    (
        echo "$installed" | sed 's/$/ [installed]/'
        echo "$repo" | sed 's/$/ [repo]/'
        echo "$aur"  | sed 's/$/ [AUR]/'
    ) | sort -u
}

# 2️⃣ Launch fzf with preview and actions
fzf --height=40% --border --prompt="Package Manager> " \
    --multi \
    --ansi \
    --preview-window=right:50% \
    --preview '
        pkg=$(echo {} | awk "{print \$1}"); 
        tag=$(echo {} | awk "{print \$2}");
        if [[ "$tag" == "[installed]" ]]; then
            pacman -Qi $pkg 2>/dev/null || yay -Qi $pkg 2>/dev/null;
        else
            pacman -Si $pkg 2>/dev/null || yay -Si $pkg 2>/dev/null;
        fi
    ' \
    --bind '
        enter:execute(
            pkg=$(echo {} | awk "{print \$1}");
            tag=$(echo {} | awk "{print \$2}");
            if [[ "$tag" == "[installed]" ]]; then
                read -p "Uninstall $pkg? [y/N] " ans; 
                [[ $ans == [yY] ]] && sudo pacman -Rns $pkg || echo "Skipped";
            else
                sudo yay -S $pkg || echo "Install failed";
            fi
        )'
