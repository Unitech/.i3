# ~/.bashrc: executed by bash(1) for non-login shells.

#
# Proxy
# ssh -L 9000:localhost:8080 user@linux


# Global
# export PRODUCTION='true'
# export ENV='production'
# export RAILS_ENV='production'
# export NODE_ENV='production'
# export EXPRESS_ENV='production'

export EDITOR='emacs -nw'

. ~/.nvm/nvm.sh

[ -z "$PS1" ] && return

#
# History customization
#
HISTCONTROL=ignoredups:ignorespace
# Share same history between all terminal
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=100000
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac


if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	color_prompt=yes
    else
	color_prompt=
    fi
fi

function xtitle()
{
    case "$TERM" in
        *term | rxvt)
            echo -n -e "#\033]0;$*\007" ;;
        *)
            ;;
    esac
}

#PS1='[`node -v`] \[\033[01;34m\]\w\[\033[00m\] $ '
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[ >>>\033[00m\] '
export PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h: \[\e[33m\]\w\[\e[0m\]\n\$ '
unset color_prompt force_color_prompt

function title {
    echo -en "\033]2;$1\007"
}

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

#alias iptable='iptables -L -v -n --line-number'
alias cd..='cd ..'
alias d.='cd ..'
alias d..='cd ..'
alias cd.='cd ..'
alias ..=' cd ..'
alias l='ls -alh --group-directories-first'
alias ll='ls -lh --group-directories-first'
alias xs='cd'
alias vf='cd'
alias moer='more'
alias moew='more'
alias kk='ll'
alias lll='ls -lh'
alias la='ls -Ah'
alias df='df -h'
alias ne='emacs -nw'
#alias proxify='xtitle SSH TUNELLING && ssh -vv -CND 9999 root@filmcomplet.fr'
alias killrails='kill -s 9 `pgrep -f "rails.*"`'
alias du='du -kh'       # Makes a more readable output.
alias df='df -kTh'

alias grpe='grep'
alias mroe='more'
alias tial='tail'

alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'
alias which='type -a'

# aliases that use xtitle
alias top='xtitle Processes on $HOSTNAME && top'
alias htop='xtitle Processes on $HOSTNAME && htop'
alias make='xtitle Making $(basename $PWD) ; make'
alias ncftp="xtitle ncFTP ; ncftp"

alias listbig='find . -type f -size +10000k -exec ls -lh {} \'


alias ga='git add'
alias gp='git push'
alias gl='git log'
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gm='git commit -m'
alias gma='git commit -am'
alias gb='git branch -a -v'
alias gc='git checkout'
alias gra='git remote add'
alias grr='git remote rm'
alias gpu='git pull'
alias gcl='git clone'

function morecmd()
{
    echo "speedtest-cli: test bandwith"
    echo "multitail: display logs in multiple windows"
    echo "byobu: terminal multiplexer"
}

function githelp()
{
    echo "Git cheatsheet"
    echo "Create tag : git tag 0.6.7 && git push --tags"
    echo "Delete tag : git tag -d 0.6.7 && git push origin :refs/tags/0.6.7"
    echo "git stash ; git apply"
    echo "Undo commit : git reset --soft 'HEAD^' ; "
    echo "Clone recursive : git clone --recursive MYREPO"
}

function npmhelp()
{
    echo "Install git repo with npm : npm install git://github.com/Unitech/pm2.git -g"
}

function helpgen()
{
    echo "Remove init script : update-rc.d -f  pm2-init.sh remove"
    echo "Kill script byt start name : pkill -f name"
}

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

ulimit -S -c 0          # Don't want any coredumps.

genpasswd() {
    local l=$1
    [ "$l" == "" ] && l=20
    tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs
}

function ii()   # Get current host related info.
{
    echo -e "\nYou are logged on ${RED}$HOSTNAME"
    echo -e "\nAdditionnal information:$NC " ; uname -a
    echo -e "\n${RED}Users logged on:$NC " ; w -h
    echo -e "\n${RED}Current date :$NC " ; date
    echo -e "\n${RED}Machine stats :$NC " ; uptime
    echo -e "\n${RED}Memory stats :$NC " ; free
    myip 2>&- ;
    echo -e "\n${RED}Local IP Address :$NC" ; echo ${MY_IP:-"Not connected"}
    echo -e "\n${RED}ISP Address :$NC" ; echo ${MY_ISP:-"Not connected"}
    echo -e "\n${RED}Open connections :$NC "; netstat -pan --inet;
    echo
}

function world_date() {
    echo -e "France"
    TZ=Europe/Paris date
    echo -e "New York"
    TZ=America/New_York date
    echo -e "Los Angeles"
    TZ=America/Los_Angeles date
    echo -e "Shanghai"
    TZ=Asia/Shanghai date
    echo -e "India - Katmandu"
    TZ=Asia/Katmandu date
}

function repeat()       # Repeat n times command.
{
    local i max
    max=$1; shift;
    for ((i=1; i <= max ; i++)); do  # --> C-like syntax
        eval "$@";
    done
}

monit()
{
while [ /bin/true ]; do OLD=$NEW; NEW=`cat /proc/net/dev | grep $1 | tr -s ' ' | cut -d' ' -f "3 11"`; echo $NEW $OLD | awk '{printf("\rin: % 9.2g\t\tout: % 9.2g", ($1-$3)/1024, ($2-$4)/1024)}'; sleep 1; done
}

f(){
    history | grep -i $1
}

# Enable ruby environment with RVM
function set_rvm() {
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
    PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
}

# Get public ip
function ip() {
    wget -q -O - checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//'
}

# Multi git commands
function gff() {
    git add .; git commit -am "$1"; git push
}

function emptytrash() {
    rm -rf /home/tknew/.local/share/Trash/
}

#=========================================================================
# PROGRAMMABLE COMPLETION - ONLY SINCE BASH-2.04
# Most are taken from the bash 2.05 documentation and from Ian McDonald's
# 'Bash completion' package (http://www.caliban.org/bash/#completion).
# You will in fact need bash more recent than 3.0 for some features.
#=========================================================================

if [ "${BASH_VERSION%.*}" \< "3.0" ]; then
    echo "You will need to upgrade to version 3.0 \
for full programmable completion features."
    return
fi


# export JAVA_HOME=/usr/local/java/jre1.7.0_60
# PATH=$PATH:$HOME/bin:$JAVA_HOME/bin
