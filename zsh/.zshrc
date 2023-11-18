zsh_plugins=${ZDOTDIR:-~}/.zsh_plugins.zsh

# Lazy-load antidote.
fpath+=(${ZDOTDIR:-~}/.antidote)
autoload -Uz $fpath[-1]/antidote

# Generate static file in a subshell when .zsh_plugins.txt is updated.
if [[ ! $zsh_plugins -nt ${zsh_plugins:r}.txt ]]; then
  (antidote bundle <${zsh_plugins:r}.txt >|$zsh_plugins)
fi

# Source your static plugins file.
source $zsh_plugins

eval "$(starship init zsh)"
eval "$(zoxide init zsh)" #for Zoxide
eval "$(pyenv init --path)"
# eval "$(fnm env --use-on-cd)" #for fnm

HISTSIZE=10000
SAVEHIST=10000
export ABBR_USER_ABBREVIATIONS_FILE=~/.config/zsh/abbreviations
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR="nvim"
export VISUAL="nvim"
export PATH="$HOME/.local/bin:$PATH"

alias gb="cd .."
alias gh="cd ~/"
alias fzfd="cd \$(find * -type d | fzf)"
alias eza="eza -all"
alias lg="lazygit"
alias vi="nvim"
alias vin="NVIM_APPNAME=nvchad nvim"
alias vil="NVIM_APPNAME=lazyvim nvim"

#for good movement
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^k" history-substring-search-up
bindkey "^j" history-substring-search-down
bindkey "^ " autosuggest-accept

# pnpm
export PNPM_HOME="/Users/kamal.singh/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
