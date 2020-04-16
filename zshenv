export VIRTUAL_ENV_DISABLE_PROMPT="yup"
export LANG="en_US.UTF-8"
export LSCOLORS="ExfxcxdxBxegedabagacad"
export EDITOR="vim"
export VISUAL="vim"
export PAGER="less"
export LESS="-R"
export ANDROID_HOME="$HOME/Library/Android/sdk"

path=(
  "$HOME/.local/bin"
  "$HOME/.rbenv/bin"
  "$HOME/Library/Python/2.7/bin"
  "$HOME/.cargo/bin"
  "/sbin"
  "/usr/sbin"
  "/usr/local/bin"
  "/usr/local/sbin"
  $path
)

:maybe-source() {
  local file="$1"
  test -f "$file" && source "$file"
}

:maybe-source ~/.after.zshenv.zsh
