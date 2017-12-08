HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt APPEND_HISTORY
setopt EXTENDED_GLOB
setopt NO_MATCH
# zsh 5.1 doesn't have this option...
setopt GLOB_STAR_SHORT 2>/dev/null
setopt INTERACTIVE_COMMENTS
bindkey -e
zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit && compinit

# Search through history using up/down arrows
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^P" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search
bindkey "^N" down-line-or-beginning-search

dim() {
  echo "$COLUMNS by $LINES"
}

fix_ssh() {
  eval "export $(tmux showenv SSH_AUTH_SOCK)"
}

__maybe_source() {
  local file="$1"
  test -f "$file" && source "$file"
}

__set_title() {
  local title="$1"
  case "$TERM" in
  linux)
    ;;
  *)
    print -Pn "\e]0;"
    # Don't allow % escapes in the parameter
    print -n "$title"
    print -Pn "\a"
    ;;
  esac
}

__set_title_special() {
  local expanded_title="${(%)1}"
  __set_title "$expanded_title"
}

__install_zsh_autosuggestions() {
  git clone \
    git://github.com/zsh-users/zsh-autosuggestions \
    ~/.zsh-autosuggestions
}

precmd() {
  __set_title_special "zsh %~"
  echo
  echo
}

preexec() {
  local title="$1"
  __set_title "$title"
}

# Fix the value of $SHELL if it's broken
case "$SHELL" in
*zsh)
  ;;
*)
  export SHELL="$(which zsh)"
  ;;
esac

case "$(uname -r)" in
*Microsoft)
  start() {
    local first="$1"
    shift
    powershell.exe -Command Start-Process "$first" -- "$@"
  }
  ;;
esac

# Allow pasting commands with "$" from the internet
alias '$'=""

alias gco="git checkout"
alias gdd="git diff --cached"
alias ga="git add"
alias gaa="git add -A"
alias gd="git diff"
alias gm="git commit -m"
alias g="git status"
alias gl="git log"
alias gg="git commit"
alias gp="git push origin HEAD"

case "$(uname)" in
Darwin)
  alias ls="ls -G"
  ;;
*)
  alias ls="ls --color=auto"
  ;;
esac

alias l="ls"
alias ll="ls -hl"
alias la="ll -a"

alias t="tmux"
alias T="tmux attach -d"

alias ..="cd .."

if ! which serve >/dev/null 2>&1; then
  alias serve="python -m SimpleHTTPServer"
fi

# TODO: Do I want these in zshenv instead?
path=(
  "/sbin"
  "/usr/sbin"
  "/usr/local/bin"
  "/usr/local/sbin"
  "$HOME/Library/Python/2.7/bin"
  "$HOME/.local/bin"
  "$HOME/.rbenv/bin"
  "$ANDROID_HOME/tools"
  "$ANDROID_HOME/platform-tools"
  $path
)

if which rbenv >/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

if test -f ~/.welcome; then
  cat ~/.welcome
else
  uptime
fi

__set_prompt() {
  sep=" :: "
  glyph=">>-"
  username="%n"
  hostname="%m"
  cwd="%~"
  reset="%b%f%u%s"
  c1="%B%F{green}"
  c2="%B%F{cyan}"
  c3="%F{cyan}"
  prompt="\
${reset}\
${c2}${username}${reset}${c3}${sep}\
${c1}${hostname}${reset}${c3}${sep}\
${c2}${cwd}${reset}
${c2}${glyph}${reset} "
}

__set_prompt

__maybe_source ~/.zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=cyan"

__maybe_source ~/.after.zsh
