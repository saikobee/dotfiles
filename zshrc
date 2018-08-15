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

dim() {
  echo "$COLUMNS by $LINES"
}

__set_title() {
  local title="$1"
  if [[ $TERM != linux ]]; then
    print -Pn "\e]0;"
    # Don't allow % escapes in the parameter
    print -n "$title"
    print -Pn "\a"
  fi
}

__set_title_special() {
  local expanded_title="${(%)1}"
  __set_title "$expanded_title"
}

__install_zsh_autosuggestions() {
  git clone --depth 1 \
    https://github.com/zsh-users/zsh-autosuggestions \
    ~/.zsh-autosuggestions
}

__install_fzf() {
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
}

precmd() {
  __set_title_special "zsh %~"
  echo
}

preexec() {
  local title="$1"
  __set_title "$title"
}

# Fix the value of $SHELL if it's broken
if [[ $SHELL != *zsh ]]; then
  export SHELL="$(which zsh)"
fi

if [[ $(uname -r) = *Microsoft ]]; then
  start() {
    local first="$1"
    shift
    powershell.exe -Command Start-Process "$first" -- "$@"
  }
fi

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

if [[ $(uname) = Darwin ]]; then
  alias ls="ls -G"
else
  alias ls="ls --color=auto"
fi

alias l="ls"
alias ll="ls -hl"
alias la="ll -a"

alias t="tmux"
alias T="tmux attach -d"

alias ..="cd .."

export FZF_DEFAULT_OPTS="--color=light --bind ctrl-j:accept"

if ! which serve >/dev/null 2>&1; then
  alias serve="python -m SimpleHTTPServer"
fi

if which rbenv >/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

if [[ -f ~/.welcome ]]; then
  cat ~/.welcome
else
  uptime
fi

__set_prompt() {
  local sep=" | "
  local glyph="\$"
  local username="%n"
  local hostname="%m"
  local cwd="%~"
  local reset="%b%f%u%s"
  local c1="%B%F{green}"
  local c2="%B%F{cyan}"
  local c3="%F{blue}"
  local end="${c2}${glyph}${reset} "
  prompt="\
${reset}
${c2}${username}${reset}${c3}${sep}\
${c1}${hostname}${reset}${c3}${sep}\
${c2}${cwd}${reset}
${c3}${glyph}${reset} "
  PS2="${c3}${glyph}${reset} "
}

__set_prompt

__maybe_source ~/.zsh-autosuggestions/zsh-autosuggestions.zsh
__maybe_source ~/.travis/travis.sh
__maybe_source ~/google-cloud-sdk/path.zsh.inc
__maybe_source ~/google-cloud-sdk/completion.zsh.inc
__maybe_source ~/.fzf.zsh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=cyan"

__maybe_source ~/.after.zshrc.zsh
