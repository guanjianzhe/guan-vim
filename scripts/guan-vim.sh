#!/bin/bash

set -x
set -e

#sudo apt-get install git
#sudo apt-get install vim-python-jedi

# 安装ctags
sudo apt-get install ctags

# 安装YCM自动补全依赖
sudo apt-get update
sudo apt-get install build-essential cmake python-dev
sudo apt-get install silversearcher-ag

# 使用python
sudo apt-get install python-setuptools  &&
sudo easy_install pip &&
sudo pip install pyflakes  &&
sudo pip install pylint  &&
sudo pip install pep8


############################  SETUP PARAMETERS
app_name='guan-vim'
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

    touch "$target_path/.vimrc.fork"
    touch "$target_path/.vimrc.bundles.fork"
    touch "$target_path/.vimrc.before.fork"
    
    touch "$target_path/.vimrc.local"
    touch "$target_path/.vimrc.bundles.local"
    touch "$target_path/.vimrc.before.local"
    
    lnif "$source_path/.vimrc.fork"         "$target_path/.vimrc.fork"
    lnif "$source_path/.vimrc.bundles.fork" "$target_path/.vimrc.bundles.fork"
    lnif "$source_path/.vimrc.before.fork"  "$target_path/.vimrc.before.fork"

    lnif "$source_path/.vimrc.local"         "$target_path/.vimrc.local"
    lnif "$source_path/.vimrc.bundles.local" "$target_path/.vimrc.bundles.local"
    lnif "$source_path/.vimrc.before.local"  "$target_path/.vimrc.before.local"

    ret="$?"
    success "Created fork maintainer files."
    debug
}

############################ MAIN()
# 下载guan-vim
## TODO: 检查是否存在guan-vim
cd ~ && git clone https://github.com/guanjianzhe/guan-vim.git ~/.guan-vim
cd $APP_PATH && git remote add github git@github.com:guanjianzhe/guan-vim.git

create_symlinks "$APP_PATH" \
                "$HOME"

# 安装spf13
curl https://j.mp/spf13-vim3 -L > spf13-vim.sh && sh spf13-vim.sh


# do_backup

# sync_repo

# create_symlinks

# ...
