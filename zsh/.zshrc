# -- Duppy convention for customizations common to bash and zsh
CFG=~/.config
source $CFG/bash/common-login-customizations.sh

# --- git widgets ---
BRANCH=$'\uf126'
# BRANCH=$'\uE709'
# BRANCH=$'\uE725'
function get_git_branch() {
    echo $BRANCH$(git symbolic-ref --short HEAD 2>/dev/null)
}
function unix_secs() {
    # render unix seconds with first 5 digits dim green and last 5 digits bright green
    local secs=$(date +%s)
    echo -e "$DKGREEN${secs:0:5}$GREEN${secs:5:5}$RESET"
}

setopt PROMPT_SUBST
autoload -U colors && colors
PROMPT=\
'%K{244}'\
'%F{black}%~/%f'\
' %F{237}$(get_git_branch)%f'\
' %F{239}%n@%m%f %k'\
'$(back_from_eol 10)$(unix_secs)'\
'${CRLF}'\
'%K{244}%F{239}!%h%k %F{051}> %f'

unset RPROMPT # export RPROMPT='%F{002}$(unix_secs)%f'

# --- format stderr fancy ---
# exec 2>>( while read X; do print "\e[91m${X}\e[0m" > /dev/tty; done & )
# this method above breaks fzf

# ---- FZF -----
# Set name of the theme to load.
# ZSH_THEME="robbyrussell"

# Add fzf to PATH
export PATH="/opt/homebrew/bin:$PATH"

# Source fzf key bindings and completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.config/zsh/.fzf.zsh ] && source ~/.config/zsh/.fzf.zsh

# ---- end FZF -----


# -- Use fd instead of fzf --
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
    fd --hidden --exclude .git . "$1"
}
# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
    fd --type=d --hidden --exclude .git . "$1"
}

# --- below here appended from scripts using echo >> ~/.zshrc
source /Users/duppy/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
# bindkey -e
bindkey -v
# End of lines configured by zsh-newuser-install

# Use Cmd+Up to search history with fzf
bindkey '\e[1;5A' fzf-history-widget

# export bat theme so delta will see it
export BAT_THEME="OneDark"

DELTA_PAGER='less -RFX' # trying to make delta use less that autodetects the terminal width
alias delta='delta --theme OneDark'

alias ls='ls -F --color=auto'
alias ll='ls -lF --color=auto'
alias l='ls -lF --color=auto'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias ..='cd ..'
alias ...='cd ../..'

function _git_branch_name() {
    git symbolic-ref --short HEAD 2>/dev/null
}

function _git_branch_icon() {
    local branch=$(_git_branch_name)
    if [ -n "$branch" ]; then
        echo -n "$DKGREEN$branch$RESET"
    else
        echo -n "$DKRED????$RESET"
    fi
}

function _git_status() {
    local status=$(git status --porcelain 2>/dev/null)
    if [ -n "$status" ]; then
        echo -n "$DKRED$status$RESET"
    fi
}

function _git_upstream() {
    local upstream=$(git rev-parse --abbrev-ref @{u} 2>/dev/null)
    if [ -n "$upstream" ]; then
        echo -n "$DKBLUE$upstream$RESET"
    fi
}

function _git_ahead_behind() {
    local ahead=$(git rev-list --left-right --count HEAD...@'{u}' 2>/dev/null | awk '{print $1}')
    local behind=$(git rev-list --left-right --count HEAD...@'{u}' 2>/dev/null | awk '{print $2}')
    if [ -n "$ahead" ] || [ -n "$behind" ]; then
        echo -n "$DKBLUE$ahead$RESET$DKRED$behind$RESET"
    fi
}

function _git_commit_count() {
    local commits=$(git rev-list --count HEAD 2>/dev/null)
    if [ -n "$commits" ]; then
        echo -n "$DKBLUE$commits$RESET"
    fi
}

function _git_commit_hash() {
    local hash=$(git rev-parse HEAD 2>/dev/null)
    if [ -n "$hash" ]; then
        echo -n "$DKBLUE$hash$RESET"
    fi
}

function _git_commit_message() {
    local message=$(git log -1 --pretty=%B 2>/dev/null)
    if [ -n "$message" ]; then
        echo -n "$DKBLUE$message$RESET"
    fi
}

function _git_commit_author() {
    local author=$(git log -1 --pretty=%an 2>/dev/null)
    if [ -n "$author" ]; then
        echo -n "$DKBLUE$author$RESET"
    fi
}

function _git_commit_date() {
    local date=$(git log -1 --pretty=%ad 2>/dev/null)
    if [ -n "$date" ]; then
        echo -n "$DKBLUE$date$RESET"
    fi
}

function _git_commit_branch() {
    local branch=$(_git_branch_name)
    if [ -n "$branch" ]; then
        echo -n "$DKBLUE$branch$RESET"
    fi
}

function _git_commit_icon() {
    local icon=$(_git_commit_count)
    if [ -n "$icon" ]; then
        echo -n "$DKBLUE$icon$RESET"
    fi
}