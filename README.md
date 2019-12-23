# Dotfiles

My personal **config files for Linux**.

The installation will not just **_symbolic link all config files to the right place_** but also **_install some package_** with appropriate Package Manager of your distros.

Although I tried to calculate all possible failures can happen, but if something goes wrong, you might need to manually install packages or link config files again.

## Requirements

**IMPORTANT**: If you come from a fresh distrobution, you need to **update** (like `sudo apt update`,...) and **upgrade** (like `sudo apt upgrade`,...) all the packages in your distro, then install requirements and follow the instruction below.

-   bash shell
-   git
-   _(Optional)_: Install these requirements if you want to get the best experience.
    -   Breeze Theme:
    -   Dark-Solarized Theme:

## Installation

1. Clone the repository into `~/.dotfiles/`:

    ```shell
    git clone --depth=1 https://github.com/vuong-cuong-phoenix/dotfiles.git $HOME/.dotfiles
    cd $HOME/.dotfiles
    ```

2. Run this command:

    ```shell
    ./install.sh
    ```

-   The installation will backup config file if it is exists and is not linked to the correct place. All backup files are under `./BACKUP/<CURRENT DATE_TIME>/`
-   If you haven't install `oh-my-zsh` before, then after the first time installation of it, you need to **run the command above again** to get effect of configurations.
-   Install [Hack Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/Hack.zip) and set it as default font for your Terminal.

## List of Packages and Configurations

-   **git**
    -   .gitconfig.static: [~/.gitconfig.static](https://github.com/vuong-cuong-phoenix/dotfiles/blob/master/git/.gitconfig.static)
    -   .gitignore.static: [~/.dotfiles/git/.gitignore.static](https://github.com/vuong-cuong-phoenix/dotfiles/blob/master/git/.gitignore.static)
        > Global .gitignore for every git projects.
-   **curl**
-   **unzip**
-   **bash**
    -   .bash_profile: [~/.bash_profile](https://github.com/vuong-cuong-phoenix/dotfiles/blob/master/shell/.bash_profile)
    -   .bashrc: [~/.bashrc](https://github.com/vuong-cuong-phoenix/dotfiles/blob/master/shell/.bashrc)
-   **vim**
    -   .vimrc: [~/.vimrc](https://github.com/vuong-cuong-phoenix/dotfiles/blob/master/editor/.vimrc)
-   **zsh**
    -   .zprofile: [~/.zprofile](https://github.com/vuong-cuong-phoenix/dotfiles/blob/master/shell/.zprofile)
    -   .zshrc: [~/.zshrc](https://github.com/vuong-cuong-phoenix/dotfiles/blob/master/shell/.zshrc)
    -   **oh-my-zsh**: `~/.oh-my-zsh`
        -   zsh-autosuggestions: `~/.oh-my-zsh/custom/plugins/zsh-autosuggestions`
        -   zsh-syntax-highlighting: `~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting`
        -   powerlevel10k: `~/.oh-my-zsh/custom/themes/powerlevel10k`

## Known Issues

-   **(Solved)** Cannot find **Hack Nerd Font** in **Gnome-Terminal**.  
    **==>** By default, **Gnome-Terminal** only shows _monospace-fonts_.  
    To choose **Hack Nerd Font** as the default font for **Gnome-Terminal**, you need to install `dconf-editor`, then open it, find `/org/gnome/terminal/legacy/profiles:/<profiles-id>/font` and then change **_Custom value_** to `Hack Nerd Font <font-size>`
