#!/bin/zsh

source "$HOME/.dotfiles/framework.sh"

printf "Configuring extras for 'zsh'\n"
# Set 'zsh' as default SHELL
if [ ! "$SHELL" = "$(command -v zsh)" ]; then
    printf "Set 'zsh' as your default shell!\n"
    chsh -s $(command -v zsh)
fi

# Configure 'oh-my-zsh'
printf "\toh-my-zsh\n"
check_and_download "oh-my-zsh" "$HOME/.oh-my-zsh" "sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)""
if [ $? -eq 1 ]; then
    return 1
fi

printf "\tzsh-autosuggestions\n"
check_and_download "zsh-autosuggestions" "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" "git clone "https://github.com/zsh-users/zsh-autosuggestions" "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions""
if [ $? -eq 1 ]; then
    return 1
fi 

printf "\tzsh-syntax-highlighting\n"
check_and_download "zsh-syntax-highlighting" "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" "git clone "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting""
if [ $? -eq 1 ]; then
    return 1
fi

printf "\tpowerlevel10k\n"
# Install 'Powerlevel10k' for 'oh-my-zsh'
check_and_download "powerlevel10k" "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" "git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k""
if [ $? -eq 1 ]; then
    return 1
fi

printf "Successfully installed and configured 'oh-my-zsh' for 'zsh'.\n"
printf "To get the best experience on 'zsh', you should install 'Hack Nerd Font' and change Terminal's theme to 'Breeze':\n"
printf "\tHack Nerd Font: https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/Hack.zip\n"

return 0