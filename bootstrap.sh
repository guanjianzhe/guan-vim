#!/usr/bin/env bash

#   Copyright 2014 Steve Francia
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

############################  SETUP PARAMETERS
app_name='spf13-vim'
[ -z "$APP_PATH" ] && APP_PATH="$HOME/.spf13-vim-3"
[ -z "$REPO_URI" ] && REPO_URI='https://github.com/spf13/spf13-vim.git'
[ -z "$REPO_BRANCH" ] && REPO_BRANCH='3.0'
debug_mode='1'
fork_maintainer='1'
[ -z "$VUNDLE_URI" ] && VUNDLE_URI="https://github.com/gmarik/vundle.git"

# guan-vim 仓库环境变量
guan_app_name='guan-vim'
[ -z "$GUAN_APP_PATH" ] && GUAN_APP_PATH="$HOME/.guan-vim"
[ -z "$GUAN_REPO_URI" ] && GUAN_REPO_URI='https://github.com/guanjianzhe/guan-vim.git'
[ -z "$GUAN_REPO_BRANCH" ] && GUAN_REPO_BRANCH='master'
# 1: 没有网络
no_network_mode='1'

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

############################ SETUP FUNCTIONS

do_backup() {
    if [ -e "$1" ] || [ -e "$2" ] || [ -e "$3" ]; then
        msg "Attempting to back up your original vim configuration."
        today=`date +%Y%m%d_%s`
        for i in "$1" "$2" "$3"; do
            [ -e "$i" ] && [ ! -L "$i" ] && mv -v "$i" "$i.$today";
        done
        ret="$?"
        success "Your original vim configuration has been backed up."
        debug
   fi
}

sync_repo() {
    local repo_path="$1"
    local repo_uri="$2"
    local repo_branch="$3"
    local repo_name="$4"

    if [ "$no_network_mode" -eq '1' ]; then
        msg "Your are in no_network_mode. Will NOT sync from github."
        return 1
    fi

    msg "Trying to update $repo_name"

    if [ ! -e "$repo_path" ]; then
        mkdir -p "$repo_path"
        git clone -b "$repo_branch" "$repo_uri" "$repo_path"
        ret="$?"
        success "Successfully cloned $repo_name."
    else
        cd "$repo_path" && git pull origin "$repo_branch"
        ret="$?"
        success "Successfully updated $repo_name"
    fi

    debug
}

create_symlinks() {
    local source_path="$1"
    local target_path="$2"

    lnif "$source_path/.vimrc"         "$target_path/.vimrc"
    lnif "$source_path/.vimrc.bundles" "$target_path/.vimrc.bundles"
    lnif "$source_path/.vimrc.before"  "$target_path/.vimrc.before"
    lnif "$source_path/.vim"           "$target_path/.vim"

    if program_exists "nvim"; then
        lnif "$source_path/.vim"       "$target_path/.config/nvim"
        lnif "$source_path/.vimrc"     "$target_path/.config/nvim/init.vim"
    fi

    touch  "$target_path/.vimrc.local"

    ret="$?"
    success "Setting up vim symlinks."
    debug
}

setup_fork_mode() {
    local source_path="$2"
    local target_path="$3"

        success "setup_fork_mode...."
    if [ "$1" -eq '1' ]; then
        touch "$target_path/.vimrc.fork"
        touch "$target_path/.vimrc.bundles.fork"
        touch "$target_path/.vimrc.before.fork"

        lnif "$source_path/.vimrc.fork"         "$target_path/.vimrc.fork"
        lnif "$source_path/.vimrc.bundles.fork" "$target_path/.vimrc.bundles.fork"
        lnif "$source_path/.vimrc.before.fork"  "$target_path/.vimrc.before.fork"

        # put my bashrc, gitconfig and ctag with git here
        touch "$target_path/.bashrc"
        touch "$target_path/.bash_aliases"
        touch "$target_path/.gitconfig"
        touch "$target_path/.git_template"

        lnif "$source_path/tools/bash_configs/.bashrc"          "$target_path/.bashrc"
        lnif "$source_path/tools/bash_configs/.bash_aliases"    "$target_path/.bash_aliases"
        lnif "$source_path/tools/bash_configs/.gitconfig"       "$target_path/.gitconfig"
        lnif "$source_path/tools/ctags_with_git/.git_template"  "$target_path/.git_template"

        ret="$?"
        success "Created fork maintainer files."
        debug
    fi
}

setup_vundle() {

    if [ "$no_network_mode" -eq '1' ]; then
        msg "Your are in no_network_mode. Will NOT sync from github."
        return 1
    fi

    local system_shell="$SHELL"
    export SHELL='/bin/sh'

    vim \
        -u "$1" \
        "+set nomore" \
        "+BundleInstall!" \
        "+BundleClean" \
        "+qall"

    export SHELL="$system_shell"

    success "Now updating/installing plugins using Vundle"
    debug
}

############################ MAIN()
variable_set "$HOME"
program_must_exist "vim"
program_must_exist "git"

do_backup       "$HOME/.vim" \
                "$HOME/.vimrc" \
                "$HOME/.gvimrc"

# repo sync spf13-vim
sync_repo       "$APP_PATH" \
                "$REPO_URI" \
                "$REPO_BRANCH" \
                "$app_name"
# links for spf13-vim
create_symlinks "$APP_PATH" \
                "$HOME"

# repo sync guan-vim
sync_repo       "$GUAN_APP_PATH" \
                "$REPO_URI" \
                "$GUAN_REPO_BRANCH" \
                "$guan_app_name"

# *.fork symlinks change to guan-vim directory
setup_fork_mode "$fork_maintainer" \
                "$GUAN_APP_PATH" \
                "$HOME"

sync_repo       "$HOME/.vim/bundle/vundle" \
                "$VUNDLE_URI" \
                "master" \
                "vundle"

# why using default bundles setting??
setup_vundle    "$APP_PATH/.vimrc.bundles.default"

msg             "\nThanks for installing $app_name."
msg             "© `date +%Y` http://vim.spf13.com/"

