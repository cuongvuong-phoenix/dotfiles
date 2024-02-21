export ZSH="$HOME/.local/share/sheldon/repos/github.com/ohmyzsh/ohmyzsh"

export DEFAULT_USER="$USER"

export HISTSIZE=250000
export SAVESIZE=25000

eval "$(sheldon source)"

# ----------------------------------------------------------------
# ZSH THEME
# ----------------------------------------------------------------
# ---------------- General Settings ---------------- 
# Disable default context.
prompt_context() {}
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

# Font mode.
POWERLEVEL9K_MODE="nerdfont-complete"

# ---------------- Prompts ---------------- 
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

# ---------------- Segments ---------------- 
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

# ----------------------------------------------------------------
# HELPERS
# ----------------------------------------------------------------
# Avoid duplicating entry "$1" whenever add it to "$PATH"
function add_to_PATH {
  case ":$PATH:" in
    *":$1:"*) :;;           # already there.
    *) PATH="$1:$PATH";;    # prefer custom $1 first.
  esac
}

# ----------------------------------------------------------------
# ALIASES
# ----------------------------------------------------------------
alias ls=lsd
alias grep=rg
alias find=fd
alias vim=nvim

# ----------------------------------------------------------------
# ENVIRONMENTS
# ----------------------------------------------------------------
add_to_PATH "$HOME/.local/bin"

# Java.
export JAVA_HOME="/usr/lib/jvm/default"

# PNPM.
export PNPM_HOME="$HOME/.local/share/pnpm"
add_to_PATH "$PNPM_HOME"

# Yarn.
add_to_PATH "$(yarn global bin)"

# Rust.
add_to_PATH "$HOME/.cargo/bin"

# Oracle Instant Client.
export ORACLE_HOME=/opt/oracle
# Ruby (`ruby-oci8`).
export LD_LIBRARY_PATH=/opt/oracle/instantclient

# ----------------------------------------------------------------
# UTILITIES
# ----------------------------------------------------------------
# Use vi keymap.
bindkey -v

# Theme for `bat`.
export BAT_THEME="TwoDark"

# Choose `NVim` as default editor.
export EDITOR=nvim

# Use `.dir_colors` as default.
eval "$(dircolors -b ~/.dir_colors)"

# ----------------------------------------------------------------
# TMUX
# ----------------------------------------------------------------
# export TERM="xterm-256color"

# Auto start.
if which tmux >/dev/null 2>&1; then
   # if no session is started, start a new session
   test -z ${TMUX} && tmux

   # # when quitting tmux, try to attach remaining session
   # while test -z ${TMUX}; do
   #     tmux attach || break
   # done
fi

# ----------------------------------------------------------------
# FZF
# ----------------------------------------------------------------
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# Ref: https://github.com/junegunn/fzf#settings

export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_DEFAULT_OPTS="--layout=reverse"

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

# Enhancd
export ENHANCD_FILTER="fzf:fzf-tmux:fzy:peco:percol:gof:pick:icepick:sentaku:selecta"

# ----------------------------------------------------------------
# COMMANDS
# ----------------------------------------------------------------
musl-build() {
  docker run \
    -v cargo-cache:/root/.cargo/registry \
    -v "$PWD:/volume" \
    -e SQLX_OFFLINE=true \
    --rm -it clux/muslrust sh -c "cargo build --release && chown -R $(id -u):$(id -g) ./target"
}

ipv6() {
  case ${1:-check} in
    check)
      sudo sysctl -a | grep -ie "disable_ipv6"
      ;;
    on|enable)
      sudo sysctl -w net.ipv6.conf.all.disable_ipv6=0
      sudo sysctl -w net.ipv6.conf.default.disable_ipv6=0
      ;;
    off|disable)
      sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
      sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
      ;;
  esac
}

# ----------------------------------------------------------------
# Run last
# ----------------------------------------------------------------
eval "$(/usr/bin/mise activate zsh)"

