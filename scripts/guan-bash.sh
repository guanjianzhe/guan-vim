#!/bin/bash

set -x
set -e


############################  SETUP PARAMETERS
app_name='guan-bash'
[ -z "$APP_PATH" ] && APP_PATH="$HOME/.guan-vim"
debug_mode='1'

############################  BASIC SETUP TOOLS
msg() {
    printf '%b\n' "$1" >&2
}

success() {
    if [ "$ret" -eq '0' ]; then
        msg "\33[32m[✔]\33[0m ${1}${2}"
    fi
}

error() {
    msg "\33[31m[✘]\33[0m ${1}${2}"
    exit 1
}

debug() {
    if [ "$debug_mode" -eq '1' ] && [ "$ret" -gt '1' ]; then
        msg "An error occurred in function \"${FUNCNAME[$i+1]}\" on line ${BASH_LINENO[$i+1]}, we're sorry for that."
    fi
}

program_exists() {
    local ret='0'
    command -v $1 >/dev/null 2>&1 || { local ret='1'; }

    # fail on non-zero return value
    if [ "$ret" -ne 0 ]; then
        return 1
    fi

    return 0
}

program_must_exist() {
    program_exists $1

    # throw error on non-zero return value
    if [ "$?" -ne 0 ]; then
        error "You must have '$1' installed to continue."
    fi
}

variable_set() {
    if [ -z "$1" ]; then
        error "You must have your HOME environmental variable set to continue."
    fi
}

lnif() {
    if [ -e "$1" ]; then
        ln -sf "$1" "$2"
    fi
    ret="$?"
    debug
}


create_symlinks() {
    local source_path="$1"
    local target_path="$2"

    touch "$target_path/.bash_profile"
    touch "$target_path/.gitconfig"
    touch "$target_path/.bashrc"
    touch "$target_path/.bash_aliases"

    lnif "$source_path/tools/bash_configs/.bash_profile"   "$target_path/.bash_profile"
    lnif "$source_path/tools/bash_configs/.gitconfig"      "$target_path/.gitconfig"
    lnif "$source_path/tools/bash_configs/.bashrc"         "$target_path/.bashrc"
    lnif "$source_path/tools/bash_configs/.bash_aliases"   "$target_path/.bash_aliases"

    ret="$?"
    success "Created tools bash files."
    debug
}

############################ MAIN()
create_symlinks "$APP_PATH" \
                "$HOME"

# install ctags_with_git
touch   "$HOME/.git_template"
lnif ~/.guan-vim/tools/ctags_with_git/.git_template    ~/.git_template
#ln -sf "$/tools/ctags_with_git/.git_template"    "$HOME/.git_template"

success "Created ctags with git."

# do_backup

# sync_repo

# create_symlinks

# ...
