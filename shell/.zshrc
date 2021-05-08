# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export DEFAULT_USER="$USER"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
    archlinux 
    git 
    zsh-autosuggestions 
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

#-------------------------------------------------------------------------------------------
#---------------------------------------- ZSH THEME ---------------------------------------- 
#-------------------------------------------------------------------------------------------

#---------------------------------------- General Settings ---------------------------------------- 
# Disable default context.
prompt_context() {}
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

# Font mode.
POWERLEVEL9K_MODE="nerdfont-complete"

#---------------------------------------- Prompts ---------------------------------------- 
# Format.
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user dir_writable dir vcs prompt_char)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time root_indicator background_jobs time disk_usage)

# Style.
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
# POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
# POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=" %F{cyan}\u2570\uF460\uF460\uF460%f "    # ╰

# Separators.
POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR_ICON="\uE0B0"      # 
POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR_ICON="\uE0B1"   # 
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR_ICON="\uE0B2"     # 
POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR_ICON="\uE0B3"  # 

#---------------------------------------- Segments ---------------------------------------- 
# User.
POWERLEVEL9K_ALWAYS_SHOW_USER=true
POWERLEVEL9K_USER_TEMPLATE="%n"
POWERLEVEL9K_USER_BACKGROUND="251"
POWERLEVEL9K_USER_FOREGROUND="black"
POWERLEVEL9K_USER_ICON="\uF007 "    # 

# Dir.
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_beginning"

# VCS.
POWERLEVEL9K_VCS_GIT_ICON="\uF7A1 "             #  
POWERLEVEL9K_VCS_GIT_GITHUB_ICON="\uF408 "      # 
POWERLEVEL9K_VCS_GIT_GITLAB_ICON="\uF296 "      # 
POWERLEVEL9K_VCS_GIT_BITBUCKET_ICON="\uF5A7"    # 

# Time.
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"

#----------------------------------------------------------------------------------------
#---------------------------------------- ALIAS ---------------------------------------- 
#----------------------------------------------------------------------------------------
alias vim=nvim

#----------------------------------------------------------------------------------------
#---------------------------------------- ENVIROMENT ---------------------------------------- 
#----------------------------------------------------------------------------------------
# Java.
export JAVA_HOME="/usr/lib/jvm/default"

# NodeJS.
source /usr/share/nvm/init-nvm.sh

# Yarn.
export PATH="$(yarn global bin):${PATH}"

# PNPM.
# tabtab source for packages. Uninstall by removing these lines.
# [[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true


# Flutter.
# export FLUTTER_HOME="${HOME}/Developments/flutter"
# export PATH="${PATH}:${FLUTTER_HOME}/bin"

# Rust.
source "$HOME/.cargo/env"

# Golang.
export GOPATH="${HOME}/go"
export PATH="${PATH}:${GOPATH//://bin:}/bin"

# Anaconda.
# export PATH="${PATH}:${HOME}/Developments/miniconda3/bin"

# IBus.
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
# Dành cho những phần mềm dựa trên qt4.
export QT4_IM_MODULE=ibus
# Dành cho những phần mềm dùng thư viện đồ họa clutter.
export CLUTTER_IM_MODULE=ibus

#----------------------------------------------------------------------------------------
#---------------------------------------- UTILITIES ---------------------------------------- 
#----------------------------------------------------------------------------------------
# Use vi keymap.
bindkey -v

# Theme for `bat`.
export BAT_THEME="TwoDark"

# Choose `Vim` as default editor.
export EDITOR=vim

# Use `.dir_colors` as default.
eval "$(dircolors -b ~/.dir_colors)"

# Pipenv.
eval $(pipenv --completion)

#----------------------------------------------------------------------------------------
#---------------------------------------- TMUX ---------------------------------------- 
#----------------------------------------------------------------------------------------
# export TERM="xterm-256color"

if which tmux >/dev/null 2>&1; then
   # if no session is started, start a new session
   test -z ${TMUX} && tmux

   # # when quitting tmux, try to attach remaining session
   # while test -z ${TMUX}; do
   #     tmux attach || break
   # done
fi

#----------------------------------------------------------------------------------------
#---------------------------------------- FZF ---------------------------------------- 
#----------------------------------------------------------------------------------------
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_DEFAULT_OPTS="--layout=reverse --inline-info"

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

#----------------------------------------------------------------------------------------
#---------------------------------------- SCRIPTS ---------------------------------------- 
#----------------------------------------------------------------------------------------
# # Neofetch
# if command -v neofetch > /dev/null 2>&1; then
#     neofetch
# fi

