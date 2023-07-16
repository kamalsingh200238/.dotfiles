# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# source antidote
source /usr/share/zsh-antidote/antidote.zsh

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load
source ~/.zsh_plugins.zsh

# For History
HISTSIZE=10000
SAVEHIST=10000  # Save most-recent 1000 lines
# HISTFILE=~/.cache/zsh/.zsh_history

eval "$(zoxide init zsh)" #for Zoxide
eval "$(fnm env --use-on-cd)" #for fnm
export ABBR_USER_ABBREVIATIONS_FILE=~/.config/zsh/abbreviations

#for loading in utf-8 so my tmux doesn't go crazy
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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
