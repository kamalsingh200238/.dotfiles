function gprettier --description "Global Prettier with plugins"
    set -l GLOBAL_PRETTIER_HOME "$HOME/dev/global-prettier"
    set -l original_dir (pwd)

    # Resolve all file arguments to absolute paths before cd
    set -l resolved_args
    for arg in $argv
        if test -e "$arg"
            set -a resolved_args (realpath "$arg")
        else
            # Keep flags and non-file args as-is
            set -a resolved_args "$arg"
        end
    end

    # Run prettier from the global-prettier directory
    cd $GLOBAL_PRETTIER_HOME
    ./node_modules/.bin/prettier --config prettier.config.js $resolved_args

    # Return to original directory
    cd $original_dir
end
