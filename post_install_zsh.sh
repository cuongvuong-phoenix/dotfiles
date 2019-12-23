#!/bin/bash

source "$HOME/.dotfiles/framework.sh"

printf "Configuring extras for 'zsh'\n"
# Configure 'oh-my-zsh'
printf "\toh-my-zsh\n"
if [ -d "$HOME/.oh-my-zsh" ]; then
    print_wtabs 2 "FOUND 'oh-my-zsh'"
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
        print_wtabs 2 "Installing 'oh-my-zsh'" "SUCCEED"
    else
        print_wtabs 2 "Installing 'oh-my-zsh'" "FAILED"
        exit 1
    fi
fi

printf "\tzsh-autosuggestions\n"
check_and_download "zsh-autosuggestions" "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" "git clone "https://github.com/zsh-users/zsh-autosuggestions" "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions""
if [ $? -eq 1 ]; then
    exit 1
fi 

printf "\tzsh-syntax-highlighting\n"
check_and_download "zsh-syntax-highlighting" "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" "git clone "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting""
if [ $? -eq 1 ]; then
    exit 1
fi

printf "\tpowerlevel10k\n"
# Install 'Powerlevel10k' for 'oh-my-zsh'
check_and_download "powerlevel10k" "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" "git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k""
if [ $? -eq 1 ]; then
    exit 1
fi

printf "Successfully installed and configured 'oh-my-zsh' for 'zsh'.\n"
printf "To get the best experience on 'zsh', you should install 'Hack Nerd Font' and change Terminal's theme to 'Breeze':\n"

exit 0