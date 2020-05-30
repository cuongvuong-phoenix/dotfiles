# Dotfiles

My personal **config files for Linux**.

![Demo Image](https://github.com/vuong-cuong-phoenix/dotfiles/blob/master/images/demo.png)

The installation will not just **_symbolically link all config files to the right place_** but also **_install some packages with appropriate Package Manager_** of your distros.

All configs/enviroment in `~/.zshrc` is mine (indentified by comments `###### XXX`). You can custom your configs/enviroments by change these.

Although I tried to calculate all possible failures can happen, but you may need to manually install packages or link config files again if something goes wrong.

## Requirements

**IMPORTANT**: If you come from a fresh distro, you'll need to **update** (_e.g:_ `sudo apt update`,...) and **upgrade** (_e.g:_ `sudo apt upgrade`,...) all the packages first, then install requirements and follow the instruction below.

-   bash shell.
-   [**tput**](https://command-not-found.com/tput).
-   **git**. (You can download this repo as _zip_ and then the installation will install **git** for you).
-   **_(Optional)_**: Install these requirements if you want to get the best experience:
    -   Terminal themes:
        -   Breeze Theme.
        -   Symphonic Theme.
        -   Brogrammer Theme.
        -   XTerm.
        -   Obsidian Theme.
        -   ... _(Dark themes)_

## Installation

1. Clone the repository into `~/.dotfiles/`:

    ```shell
    $ git clone --depth=1 git@github.com:vuong-cuong-phoenix/dotfiles.git $HOME/.dotfiles
    $ cd $HOME/.dotfiles
    ```

2. Run this command:

    ```shell
    $ ./install.sh
    ```

-   The installation will backup config file if it is exists and is not linked to the correct place. All backup files are under `./BACKUP/<CURRENT DATE_TIME>/`.
-   If you haven't install `oh-my-zsh` before, then after the first time installation of it, you'll need to **run the command above again** to get effect of configurations.
-   Install any [Nerd Font](https://github.com/ryanoasis/nerd-fonts) and set it as default font for your Terminal.

3. (Optional) Add Scripts:

-   (KDE) Move Window and focust to Desktop

## List of Packages and Configurations

-   **git**
    -   _~~.gitconfig.static: [~/.gitconfig.static](https://github.com/vuong-cuong-phoenix/dotfiles/blob/master/git/.gitconfig.static)~~ (Deprecated)_
    -   .gitignore_global: [~/.gitignore_global](https://github.com/vuong-cuong-phoenix/dotfiles/blob/master/git/.gitignore_global)
-   **curl**
-   **unzip**
-   **bash**
    -   .bash_profile: [~/.bash_profile](https://github.com/vuong-cuong-phoenix/dotfiles/blob/master/shell/.bash_profile)
    -   .bashrc: [~/.bashrc](https://github.com/vuong-cuong-phoenix/dotfiles/blob/master/shell/.bashrc)
-   **Tmux**
    -   .tmux.conf: [~/.tmux.conf](https://github.com/vuong-cuong-phoenix/dotfiles/blob/master/terminal/.tmux.conf)
-   **nvim**
    -   [Full config](https://github.com/vuong-cuong-phoenix/neovim-config)
-   **zsh**
    -   .zprofile: [~/.zprofile](https://github.com/vuong-cuong-phoenix/dotfiles/blob/master/shell/.zprofile)
    -   .zshrc: [~/.zshrc](https://github.com/vuong-cuong-phoenix/dotfiles/blob/master/shell/.zshrc)
    -   **oh-my-zsh**: `~/.oh-my-zsh`
        -   zsh-autosuggestions: `~/.oh-my-zsh/custom/plugins/zsh-autosuggestions`
        -   zsh-syntax-highlighting: `~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting`
        -   powerlevel10k: `~/.oh-my-zsh/custom/themes/powerlevel10k`
    -   DIR_COLORS: [~/.dir_colors](https://github.com/vuong-cuong-phoenix/dotfiles/blob/master/shell/.dir_colors)
-   **firefox**
    -   `export GTK_USE_PORTAL=1` to `/etc/profile.d/mozilla-common-sh`

## Known Issues

-   **(Solved)** Cannot find **Nerd Font** in **Gnome-Terminal**.  
    **==>** By default, **Gnome-Terminal** only shows _monospace-fonts_.  
    To choose **Nerd Font** as the default font for **Gnome-Terminal**, you need to install `dconf-editor`, then open it, find `/org/gnome/terminal/legacy/profiles:/<profiles-id>/font` and then change **_Custom value_** to `<font-name> <font-size>` (_e.g:_ `Hack Nerd Font 14`). Or you can just run following commands:

    -   Find profile id:

    ```shell
    $ gsettings get org.gnome.Terminal.ProfilesList list
    ```

    Then you should see your profile's id list (example):

    ```shell
    ['b1dcc9dd-5262-4d8d-a863-c897e6d979b9', 'd2a064f8-146d-45b5-8da7-d7e2f34da77e']
    ```

    -   Set font for that profile (example):

    ```shell
    $ gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ font 'Hack Nerd Font 14'
    ```
