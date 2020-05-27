################################################################################################
#                                           SCRIPTS
### Neofetch
if command -v neofetch > /dev/null 2>&1; then
    neofetch
fi

################################################################################################
#                                           TERMINAL
export TERMINAL=/usr/bin/konsole

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export DEFAULT_USER="$USER"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="agnoster"
ZSH_THEME="powerlevel10k/powerlevel10k"

# BASE-16 COLOR SCHEMES
# BASE16_SHELL_SET_BACKGROUND=false
# BASE16_SHELL="$HOME/.config/base16-shell/"
# [ -n "$PS1" ] && \
#     [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
#         eval "$("$BASE16_SHELL/profile_helper.sh")"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(archlinux git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

################################################################################################
#                                               CUSTOMIZE
prompt_context() {}
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

#                                                   1
POWERLEVEL9K_MODE="nerdfont-complete"
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir_writable dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time root_indicator background_jobs time disk_usage)
#POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
#POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
#POWERLEVEL9K_USER_ICON="\uF415" # 
POWERLEVEL9K_ROOT_ICON="\uF09C"
POWERLEVEL9K_SUDO_ICON=$'\uF09C' # 
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"
POWERLEVEL9K_VCS_GIT_ICON='\uF408 '
POWERLEVEL9K_VCS_GIT_GITHUB_ICON='\uF408 '
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_beginning"
###

################################################################################################
###                                              ALIAS
alias vim=nvim

################################################################################################
#                                       ENVIROMENTS VARIABLES
# FZF
export FZF_DEFAULT_COMMAND="rg --files --follow --hidden"
# Java
export JAVA_HOME="/usr/lib/jvm/default"

# Flutter
export FLUTTER_HOME="${HOME}/Developments/flutter"
export PATH="${PATH}:${FLUTTER_HOME}/bin"

# Golang
export GOPATH="${HOME}/go"
export PATH="${PATH}:${GOPATH//://bin:}/bin"

# Hadoop
export HADOOP_HOME="/usr/local/hadoop"
export HADOOP_COMMON_HOME="${HADOOP_HOME}"
export HADOOP_CONF_DIR="${HADOOP_HOME}/etc/hadoop/"
export HADOOP_HDFS_HOME="${HADOOP_HOME}"
export HADOOP_YARN_HOME="${HADOOP_HOME}"
export HADOOP_MAPRED_HOME="${HADOOP_HOME}"

export PATH="${HADOOP_HOME}/bin:${HADOOP_HOME}/sbin:${PATH}"

# Anaconda
export PATH="${PATH}:${HOME}/Developments/miniconda3/bin"

# Yarn
export PATH="$(yarn global bin):${PATH}"

# IBus
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
# Dành cho những phần mềm dựa trên qt4
export QT4_IM_MODULE=ibus
# Dành cho những phần mềm dùng thư viện đồ họa clutter
export CLUTTER_IM_MODULE=ibus

################################################################################################
#                                           UTILITIES
# Choose Vim as default editor
export EDITOR=vim

# Use '.dir_colors' as default
eval "$(dircolors -b ~/.dir_colors)"

# Pipenv
eval $(pipenv --completion)

# Best options for 'ntfs-3g'
# ntfs-3g nosuid,nodev,nofail,windows_names,big_writes,utf8,uid=1000,gid=1000,umask=0022,x-gvfs-show

################################################################################################
####                                             TMUX
export TERM=xterm-256color

# if which tmux >/dev/null 2>&1; then
#    # if no session is started, start a new session
#    test -z ${TMUX} && tmux
#
#    # when quitting tmux, try to attach
#    while test -z ${TMUX}; do
#        tmux attach || break
#    done
# fi
