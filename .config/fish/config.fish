if status is-interactive
    # Commands to run in interactive sessions can go here
    if not set -q TMUX
        exec tmux -2
    end
end

################################################################
# General settings
################################################################
source ~/.config/fish/abbreviations.fish

set -g fish_greeting

################################################################
# Vi mode
################################################################
fish_vi_key_bindings
# Emulates vim's cursor shape behavior
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_replace underscore
set fish_cursor_external line
set fish_cursor_visual block

################################################################
# Environment
################################################################
# Explicitly set `truecolor` as somehow, `tmux` doesn't set it making `delta` not displaying the correct colors
set -gx COLORTERM truecolor

set -gx EDITOR nvim
set -gx BAT_THEME TwoDark

# PNPM
set -gx PNPM_HOME "/home/bimbal/.local/share/pnpm"
fish_add_path $PNPM_HOME

# Rust
fish_add_path ~/.cargo/bin

# Go
set -gx GOPATH ~/go
fish_add_path $GOPATH/bin

# C/C++ & Ruby
set -gx ORACLE_HOME /opt/oracle
set -gx LD_LIBRARY_PATH /opt/oracle/instantclient /usr/local/lib $LD_LIBRARY_PATH
set -gx PKG_CONFIG_PATH /usr/local/lib/pkgconfig $PKG_CONFIG_PATH
set -gx GI_TYPELIB_PATH /usr/local/lib/girepository-1.0 $GI_TYPELIB_PATH

set -gx RUBY_YJIT_ENABLE 1

# Android
#set -gx JAVA_HOME /opt/android-studio/jbr
#set -gx ANDROID_HOME ~/Android/Sdk
#set -gx NDK_HOME $ANDROID_HOME/ndk/$(ls -1 $ANDROID_HOME/ndk)

################################################################
# Tools
################################################################
fzf_configure_bindings --directory=\ct --processes=\cp

mise activate fish | source
starship init fish | source
zoxide init fish | source
