if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_cursor_insert line
set fish_cursor_default block
set fish_cursor_visual block
set fish_cursor_replace underscore
set fish_vi_force_cursor 1
set -U fifc_keybinding \cx

set -gx COMPOSER_HOME $HOME/.composer
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx PATH $HOME/go/bin $HOME/.local/bin $COMPOSER_HOME/vendor/bin $PATH

alias kickstart='NVIM_APPNAME="kickstart" nvim'

starship init fish | source
zoxide init fish | source

# pnpm
set -gx PNPM_HOME $HOME/Library/pnpm
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
