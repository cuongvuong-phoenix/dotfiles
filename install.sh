#!/bin/bash

# @author: Vuong Chi Cuong
# @email: vuongcuong.phoenix@gmail.com
# @github: https://github.com/vuong-cuong-phoenix/
# @repo: https://github.com/vuong-cuong-phoenix/dotfiles
#   Feel free to open issues on my github repo.
#
#
# This is the main setup for Linux distributions.
#
# Tested on:
#           - Arch Linux
#           - Manjaro
#           - Debian
#           - Ubuntu
#           - Fedora
#           - openSUSE
#           - MX Linux
#           - Kali Linux
#           - Pop!_OS
# Untested (but still have support):
#           - macOS
#           - FreeBSD
#           - Solus
#           - Slackware
#           - Gentoo
#           - CentOS
#           - Mandriva
#           - Void Linux



#---------------------------------------- ENVIROMENT ----------------------------------------
CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${CURRENT_DIR}/framework.sh"

#---------------------------------------- MAIN ----------------------------------------
# Install 'git'.
install_and_config "git" git git ".gitignore_global"
 
# Configure '.gitconfig'.
execute_quietly "command -v git"
if [ $? -eq 0 ]; then
    # Auto coloring
    git config --global color.diff auto
    git config --global color.status auto
    git config --global color.branch auto
    # Auto change into CRLF
    git config --global core.autocrlf input
    # Excluse files globally
    git config --global core.excludesfile "$HOME/.gitignore_global"
    # Nvim as default edittor
    git config --global core.editor "nvim"
    # Disable warning when have 'whitespace'
    git config --global apply.whitespace nowarn
    # 'git pull' command now always use '--rebase' strategy
    git config --global branch.autosetuprebase always
    # 'log' Aliases
    git config --global alias.lg "lg2"
    git config --global alias.lg1 "lg1-specific --all"
    git config --global alias.lg2 "lg2-specific --all"
	git config --global alias.lg1-specific "log --color --graph --decorate --abbrev-commit --pretty=format:'%C(auto)%h%C(reset) -%C(auto)%d%C(reset) %C(white)%s%C(reset) %C(dim cyan)- (%cr) %C(dim white)<%ae>%C(reset)%n'"
    git config --global alias.lg2-specific "log --color --graph --decorate --abbrev-commit --pretty=format:'%C(auto)%h%C(reset) - %C(magenta)%cD%C(reset) %C(dim cyan)(%cr)%C(reset) %C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- <%ae>%C(reset)%n'"
fi

echo $SEPERATED_BAR

################################################################
# Install 'cURL'.
install_and_config "" curl curl

echo $SEPERATED_BAR

################################################################
# Install 'wget'.
install_and_config "" wget wget

echo $SEPERATED_BAR

################################################################
# Install 'unzip'.
install_and_config "" unzip unzip

echo $SEPERATED_BAR

################################################################
# Install 'fzf'.
install_and_config "" fzf fzf

echo $SEPERATED_BAR

################################################################
# Install and config 'ripgrep'.
install_and_config "" rg ripgrep

echo $SEPERATED_BAR

################################################################
# Install 'fd'.
install_and_config "" fd fd

echo $SEPERATED_BAR

################################################################
# Install and configure 'bat'.
install_and_config "" bat bat
link_file "$CURRENT_DIR/.config/bat" "config" "$HOME/.config/bat" "config"

echo $SEPERATED_BAR

################################################################
# Install 'jq'.
install_and_config "" jq jq

echo $SEPERATED_BAR

################################################################
# # Install 'sysstat'.
install_and_config "" mpstat sysstat

echo $SEPERATED_BAR

################################################################
# # Install and configure 'neofetch'.
install_and_config "" neofetch neofetch
link_file "$CURRENT_DIR/.config/neofetch" "config.conf" "$HOME/.config/neofetch" "config.conf"

echo $SEPERATED_BAR

################################################################
# Install and configure 'alacritty'.
install_and_config "" alacritty alacritty
link_file "$CURRENT_DIR/.config/alacritty" "alacritty.yml" "$HOME/.config/alacritty" "alacritty.yml"

echo $SEPERATED_BAR

################################################################
# Install and configure 'tmux'.
install_and_config "terminal" tmux tmux .tmux.conf
if [ $? -eq 0]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo $SEPERATED_BAR

################################################################
# Install and configure 'vim/neovim'.
install_and_config "" nvim neovim

echo $SEPERATED_BAR

################################################################
# Install and configure 'ibus'.
install_and_config "" ibus ibus
if [ $? -eq 0]; then
    echo "# IBus.
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT4_IM_MODULE=ibus
export CLUTTER_IM_MODULE=ibus

ibus-daemon -drx" >> $HOME/.xinitrc
fi

echo $SEPERATED_BAR

################################################################
# Install and configure 'bash'.
install_and_config "shell" bash bash .bash_profile .bashrc

echo $SEPERATED_BAR

################################################################
# Install and configure 'zsh'.
install_and_config "shell" zsh zsh .zprofile .zshrc .dir_colors
if [ $? -eq 0 ]; then
    $CURRENT_DIR/post_install_zsh.sh
fi

echo $SEPERATED_BAR

################################################################
# Install and configure 'openssh'.
install_and_config "shell" ssh-keygen openssh
if [ $? -eq 0]; then
    ssh-keygen -t ed25519
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
fi

echo $SEPERATED_BAR

#---------------------------------------- END ----------------------------------------
printf "${BOLD}${GREEN}COMPLETED dotfiles installation.\n"
printf "${NORMAL}"
printf "${BOLD}${LIME_YELLOW}You should check for any packages/configs ${RED}FAILED${LIME_YELLOW} and then you might need to manually install it again.\n"
printf "${NORMAL}"
