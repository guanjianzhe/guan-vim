# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto --exclude-dir=\.git --exclude-dir=\.repo --exclude=tags --exclude=system.map --exclude=System.map --exclude=.tmp_System.map --exclude-dir=\.svn --exclude-dir=\.idea --exclude-dir=\build'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
	#export GREP_OPTIONS='--exclude-dir=\.git --exclude-dir=\.repo'
	#export GREP_OPTIONS='--exclude-dir=\.git --exclude-dir=\.repo --exclude=tags --exclude=system.map --exclude=System.map --exclude=.tmp_System.map'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# local .bashrc
if [ -f ~/.bashrc_local ]; then
    . ~/.bashrc_local
fi

# guan
if [ "$TERM" == "xterm"  ]; then
    export TERM=xterm-256color
fi

# impotant for git
export LANGUAGE='en_US.UTF-8 git'

##export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_91
#export JAVA_HOME=/usr/lib/jvm/java-8
#export JRE_HOME=${JAVA_HOME}/jre
#export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
#export PATH=${JAVA_HOME}/bin:$PATH

#for go
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/workspace
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

#for server60 vim
export PATH=~/tools/vim/bin:$PATH

## for ds-5
#export PATH=$PATH:/usr/local/DS-5_v5.24.0/bin

#export PATH=$PATH:/usr/local/DS-5_v5.24.0/sw/FLEXnet_11.13.1.2/redhat-enterprise-64bit
#export PATH=$PATH:/usr/local/license/

# All of bash history revisited: load time solved plus directory history
# repo: https://github.com/djoot/all-bash-history
# readme: http://nodsw.com/blog/leeland/2012/03/07-all-bash-history-revisited-load-time-solved-plus-directory-history
# 1. 
# cd ${HOME}/tools
# in $HOME/tools git clone https://github.com/djoot/all-bash-history.git
# 2. 
# cd $HOME
# ln -s /home/guanjianzhe/tools/all-bash-history/acd_func.sh bin/.
# ln -s /home/guanjianzhe/tools/all-bash-history/a_loghistory_func.sh  bin/.
# ln -s /home/guanjianzhe/tools/all-bash-history/bashrc.user .bashrc.user
# source ~/.bashrc.user

# for cmd markdown, android st
export PATH=$PATH:/usr/local/cmd_markdown_linux64:/usr/local/android-studio/bin

# for android studio
export PATH=~/tools/android-studio/bin:$PATH
#export PATH=/home/guanjianzhe/Android/Sdk/platform-tools:$PATH
export PATH=/home/guanjianzhe/aosp_out/lineage/host/linux-x86/bin:/home/guanjianzhe/Android/Sdk/platform-tools:$PATH

# for android aosp
export OUT_DIR_COMMON_BASE=/home/guanjianzhe/aosp_out

export PATH=$PATH:/usr/local/DS-5/bin

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@local\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

#vim
export PATH=/home/guanjianzhe/install/vim/bin/:$PATH

# for android system compile
export USE_CCACHE=1
~/lineage/prebuilts/misc/linux-x86/ccache/ccache -M 50G
export ANDROID_JACK_VM_ARGS="-Xmx4g -Dfile.encoding=UTF-8 -XX:+TieredCompilation"

# for android system compile
function mkf()
{
croot && \
#make clean-framework -j8 && \
#mmm frameworks/base/ -j8 && \
make framework -j8 && \
adb root && \
adb remount && \
adb push $OUT/system/framework/framework.jar /system/framework/ && \
adb reboot
}

function mks()
{
croot && \
#make clean-services -j8 && \
#mmm frameworks/base/services -j8 && \
make framework -j8 && \
make services -j8 && \
adb root && \
adb remount && \
adb push $OUT/system/framework/framework.jar /system/framework/ && \
adb push $OUT/system/framework/services.jar /system/framework/ && \
adb reboot
}

function mkp()
{
#make clean-android.policy -j8 && \
mmm frameworks/base/policy -j8 && \
adb root && \
adb remount && \
adb push $OUT/system/framework/android.policy.jar /system/framework/ && \
adb reboot
}

function mkr()
{
#make clean-framework-res -j8 && \
mmm frameworks/base/core/res/ -j8 && \
adb root && \
adb remount && \
adb push $OUT/system/framework/framework-res.apk /system/framework/ && \
adb reboot
}

function mkSettings()
{
make Settings -j8 && \
adb root && \
adb remount && \
adb push $OUT/system/priv-app/Settings/Settings.apk /system/priv-app/Settings/
#adb reboot
}

setTitle() {
    echo -e "\033]0;$@\007"
}

source ~/lineage/sdk/bash_completion/adb.bash

# add this configuration to ~/.bashrc
export HH_CONFIG=hicolor         # get more colors
shopt -s histappend              # append new history items to .bash_history
export HISTCONTROL=ignorespace   # leading space hides commands from history
export HISTFILESIZE=10000        # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"   # mem/file sync
# if this is interactive shell, then bind hh to Ctrl-r (for Vi mode check doc)
if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hh -- \C-j"'; fi

