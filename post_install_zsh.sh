#!/bin/bash

source "$HOME/.dotfiles/framework.sh"

printf "${YELLOW}Configuring extras for ${BOLD}zsh\n"
printf "${NORMAL}"
# Configure 'oh-my-zsh'
printf "\t${BOLD}${YELLOW}oh-my-zsh\n"
printf "${NORMAL}"
if [ -d "$HOME/.oh-my-zsh" ]; then
    print_wtabs 2 "${GREEN}FOUND ${BLUE}oh-my-zsh"
else
    execute_quietly "command -v curl"
    if [ $? -eq 0 ]; then
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi

    execute_quietly "command -v wget"
    if [ $? -eq 0 ]; then
        sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
    fi

    if [ -d "$HOME/.oh-my-zsh" ]; then
        print_wtabs 2 "${LIME_YELLOW}Installing ${BLUE}oh-my-zsh" 0 $(( ${#LIME_YELLOW} + ${#BLUE} )) "SUCCESS"
    else
        print_wtabs 2 "${LIME_YELLOW}Installing ${BLUE}oh-my-zsh" 1 $(( ${#LIME_YELLOW} + ${#BLUE} )) "FAILED"
        exit 1
    fi
fi

printf "\t${BOLD}${YELLOW}zsh-autosuggestions\n"
printf "${NORMAL}"
check_and_download "zsh-autosuggestions" "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" "git clone "https://github.com/zsh-users/zsh-autosuggestions" "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions""
if [ $? -eq 1 ]; then
    exit 1
fi 

printf "\t${BOLD}${YELLOW}zsh-syntax-highlighting\n"
printf "${NORMAL}"
check_and_download "zsh-syntax-highlighting" "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" "git clone "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting""
if [ $? -eq 1 ]; then
    exit 1
fi

printf "\t${BOLD}${YELLOW}powerlevel10k\n"
printf "${NORMAL}"
# Install 'Powerlevel10k' for 'oh-my-zsh'
check_and_download "powerlevel10k" "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" "git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k""
if [ $? -eq 1 ]; then
    exit 1
fi

printf "${BOLD}${GREEN}Successfully installed and configured ${UNDERLINE}oh-my-zsh${NORMAL} ${BOLD}${GREEN}for ${UNDERLINE}zsh.\n"
printf "${NORMAL}"
printf "${LIME_YELLOW}To get the best experience on ${UNDERLINE}zsh${NORMAL}${LIME_YELLOW}, you should install ${UNDERLINE}Hack Nerd Font${NORMAL}${LIME_YELLOW} and change Terminal's theme${NORMAL}${LIME_YELLOW} to ${UNDERLINE}Breeze\n"
printf "${NORMAL}"

exit 0