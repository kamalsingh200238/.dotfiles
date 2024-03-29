if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_cursor_insert line
set fish_cursor_default block
set fish_cursor_visual block
set fish_cursor_replace underscore
set fish_vi_force_cursor 1

set -gx EDITOR nvim
set -gx VISUAL nvim 
set -gx PATH $HOME/go/bin $HOME/.local/bin $HOME/Library/pnpm $PATH

alias vil "env NVIM_APPNAME=lazyvim nvim"

starship init fish | source
zoxide init fish | source
