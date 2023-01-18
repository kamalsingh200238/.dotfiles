# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# source antidote
source ${ZDOTDIR:-~}/.antidote/antidote.zsh

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load
source ~/.zsh_plugins.sh

# For History
HISTSIZE=10000
SAVEHIST=10000  # Save most-recent 1000 lines
HISTFILE=~/.cache/zsh/.zsh_history

#for Zoxide
eval "$(zoxide init zsh)"

#my aliases 
# source ~/.config/zsh/alias
# source ~/.config/zsh/export

export ABBR_USER_ABBREVIATIONS_FILE=~/.config/zsh/abbreviations
#for loading in utf-8 so my tmux doesn't go crazy
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR="nvim"
export PATH="$HOME/.local/bin:$PATH"

alias gb="cd .."
alias gh="cd ~/"
alias fzd="cd \$(find * -type d | fzf)"
alias exa="exa -all"
alias lf="lfrun"
alias lg="lazygit"
alias vi="nvim"
# for my dotfiles
alias myzsh="nvim ~/.zshrc"
alias myvi="cd ~/.config/nvim && vi"
alias prd="pnpm run dev"
alias avi="nvim -u ~/.config/astronvim/entry.lua"
# for tmux
alias tks="tmux kill-server"
alias tl="tmux ls"
alias ta="tmux a"
alias nixq="nix-env -q"

#for good movement
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
