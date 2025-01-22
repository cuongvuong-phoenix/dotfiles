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
set -gx EDITOR nvim
set -gx BAT_THEME TwoDark

set -gx PNPM_HOME "/home/bimbal/.local/share/pnpm"
fish_add_path $PNPM_HOME

fish_add_path ~/.cargo/bin

set -gx GOPATH ~/go
fish_add_path $GOPATH/bin

# ruby-oci
set -gx ORACLE_HOME /opt/oracle
set -gx LD_LIBRARY_PATH /opt/oracle/instantclient

################################################################
# Tools
################################################################
fzf_configure_bindings --directory=\ct --processes=\cp

mise activate fish | source
starship init fish | source
zoxide init fish | source

