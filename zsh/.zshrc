# source antidote
source /usr/share/zsh-antidote/antidote.zsh

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load
source ~/.zsh_plugins.zsh

eval "$(starship init zsh)"
eval "$(zoxide init zsh)" #for Zoxide
eval "$(fnm env --use-on-cd)" #for fnm

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
alias exa="exa -all"
alias lg="lazygit"
alias vi="nvim"
alias vin="NVIM_APPNAME=nvchad nvim"
alias vil="NVIM_APPNAME=lazyvim nvim"
alias pd="pnpm dev"

#for good movement
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^k" history-substring-search-up
bindkey "^j" history-substring-search-down
bindkey "^ " autosuggest-accept
