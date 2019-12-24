#!/bin/bash

source "$HOME/.dotfiles/framework.sh"

tabs 4


# @author: vuong-cuong-phoenix
# @email: vuongcuong.phoenix@gmail.com
# @github: https://github.com/vuong-cuong-phoenix/

# This is the main setup for Linux distributions.
# Tested on:
#           - Arch Linux
#           - MX Linux
#           - Ubuntu


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

# Install and configure 'bash' shell
install_and_config shell bash .bash_profile .bashrc

echo $SEPERATED_BAR

# Install and configure 'vim' editor
install_and_config editor vim .vimrc

echo $SEPERATED_BAR

# Install and configure 'zsh' shell
install_and_config shell zsh .zprofile .zshrc
if [ $? -eq 0 ]; then
    $MAIN_DIR/post_install_zsh.sh
fi

echo $SEPERATED_BAR

printf "${BOLD}${GREEN}END dotfiles installation.\n"
printf "${NORMAL}"
printf "${BOLD}${LIME_YELLOW}You should check for what packages or configs ${RED}failed${LIME_YELLOW} and you might need to manually install it again.\n"
printf "${NORMAL}"