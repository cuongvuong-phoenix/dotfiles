#!/bin/bash

# @author: Vuong Chi Cuong
# @email: vuongcuong.phoenix@gmail.com
# @github: https://github.com/vuong-cuong-phoenix/

# This is the main setup for Linux distributions.
# Tested on:
#           - Arch Linux
#           - Debian
#           - Ubuntu
#           - MX Linux
#           - Kali Linux


source "$HOME/.dotfiles/framework.sh"

#--                                     MAIN
# Install 'git'
# install_and_config git git ".gitconfig.static" ".gitignore_global"
install_and_config git git ".gitignore_global"
 
# Configure .gitconfig
execute_quietly "command -v git"
if [ $? -eq 0 ]; then
    # git config --global include.path "$HOME/.gitconfig.static"
    git config --global color.diff auto
    git config --global color.status auto
    git config --global color.branch auto
    git config --global core.autocrlf input
    git config --global core.excludesfile "$HOME/.gitignore_global"
    git config --global apply.whitespace nowarn
fi

echo $SEPERATED_BAR

# Install 'cURL'
install_and_config "" curl

echo $SEPERATED_BAR

# Install 'wget'
install_and_config "" wget

echo $SEPERATED_BAR

# Install 'unzip'
install_and_config "" unzip

echo $SEPERATED_BAR

# Install and configure 'tmux'
install_and_config terminal tmux .tmux.conf

echo $SEPERATED_BAR

# Install and configure 'vim/neovim' editor
install_and_config "" nvim 
ln -fs ${HOME}/.config/nvim/configs/02.settings.vim ${HOME}/.vimrc

echo $SEPERATED_BAR

# Install and configure 'bash' shell
install_and_config shell bash .bash_profile .bashrc

echo $SEPERATED_BAR

# Install and configure 'zsh' shell
install_and_config shell zsh .zprofile .zshrc .dir_colors
if [ $? -eq 0 ]; then
    $MAIN_DIR/post_install_zsh.sh
fi

echo $SEPERATED_BAR

# Configure Firefox to use KDE portal
if command -v firefox > /dev/null 2>&1; then
    printf "${BOLD}${YELLOW}firefox ${NORMAL}${YELLOW}found => Start configuring now...\n"
    printf "${NORMAL}"

    FIREFOX_SCRIPT="/etc/profile.d/mozilla-common.sh"
    if [ -f ${FIREFOX_SCRIPT} ]; then
        if ! grep -q "GTK_USE_PORTAL=1" ${FIREFOX_SCRIPT}; then
            echo "export GTK_USE_PORTAL=1" >> ${FIREFOX_SCRIPT}

            print_wtabs 1 "${GREEN}Successfully add ${BOLD}${BLUE}GTK_USE_PORTAL=1 into ${NORMAL}${BLUE}${FIREFOX_SCRIPT}." 0 $(( ${#GREEN} + ${#BOLD} + ${#BLUE} + ${#NORMAL} + ${#BLUE} )) "SUCCEED"
        else
            print_wtabs 1 "${BOLD}${BLUE}GTK_USE_PORTAL=1 ${NORMAL}${GREEN}already inside ${BLUE}${FIREFOX_SCRIPT}" 
        fi
    else
        print_wtabs 1 "${RED}Cannot find ${BOLD}${FIREFOX_SCRIPT}." 0 $(( ${#RED} + ${#BOLD} )) "FAILED"
    fi

    printf "${NORMAL}"
fi

echo $SEPERATED_BAR

printf "${BOLD}${GREEN}COMPLETED dotfiles installation.\n"
printf "${NORMAL}"
printf "${BOLD}${LIME_YELLOW}You should check for what packages or configs ${RED}failed${LIME_YELLOW} and you might need to manually install it again.\n"
printf "${NORMAL}"