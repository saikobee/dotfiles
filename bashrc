# Set up ls colors
eval $(dircolors)

# Make the shell line editor behave like vi!
set -o vi

# Add my programs to the path
export PATH="$HOME/cakemenu:$HOME/Abundant/src:$HOME/bin:$PATH"

# No more \a
setterm -blength 0 >/dev/null 2>&1

# Stop blanking the terminal
setterm -blank 0 >/dev/null 2>&1

# Colors for man/less
#export LESS_TERMCAP_mb=$'\E[01;31m'
#export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01m'
export LESS_TERMCAP_md=$'\E[01m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;41;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'

# ANSI formatting for pretty-ness
export RI="-f ansi"

alias wu='ssh bmock@shell.willamette.edu'

alias dim='echo ${COLUMNS}x${LINES}'
alias sl='sl -alF'
alias rb='exec /proc/self/exe'

alias t="ssh-agent tmux"
alias T="tmux attach"

HomeDo() {
    cd
    "$@"
}

OneOut() {
    "$@" 2>&1
}

Q() {
    "$@" >/dev/null
}

QQ() {
    "$@" >/dev/null 2>/dev/null
}

g() {
    (
    cd
    eval $(ssh-agent)
    OneOut HomeDo startx > ~/.x.log
    )
}

# Surpress annoying FIXME messages from wine to speed up gameplay
export WINEDEBUG="fixme-all"

export EDITOR='vim'
export VISUAL='vim'
export BROWSER='chromium'
export PAGER='less'

# Force Java to anti-alias text
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on"

alias img="viewnior"

alias ls='ls --color=auto'
alias l='ls -hl'
alias la='l -a'
alias ..='cd ..'
alias vim='vim -p'
alias du='ncdu'
alias df='pydf'

# Quicker job control
alias k='kill %%'
alias kk='kill -9 %%'

alias irb='irb --readline -r irb/completion'

# Make package management easier
alias y="packer --noconfirm"
alias yn='packer -S --noconfirm'
alias yss='packer -Ss'
aur() {
    pkg=$1; shift

    cd ~/aur
    packer -G "$pkg"
    rm "$pkg."*
    cd "$pkg"
}
alias abs='sudo abs'
alias p='pacman'
alias sp='sudo pacman'
alias update='sp -Syu --noconfirm'

Size() {
    du -h "$@" \
    | sort -h  \
    | tac      \
    | less
}

# Move around the fs tree faster
alias go='cd "$_"'
alias gou='cd "$(dirname "$_")"'
mkgo() {
    mkdir -p "$1"
    cd "$1"
}

# Tab size 4
# Allow ANSI color sequences
export LESS="-R"

# Greet me with ASCII/ANSI art,
# if the file exists and we're not doing SSH
[ "$(tty)" != "/dev/tty1" ] &&
[ -f "$HOME/.welcome"     ] &&
[ -z "$SSH_CLIENT"        ] &&
[ -z "$TMUX"              ] && {
    cat "$HOME/.welcome"
}
