#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
#[[ $- == *i* ]] && source /usr/share/blesh/ble.sh

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -la --color=auto'
PS1='[\u@\h \W]\$ '
eval "$(atuin init bash --disable-up-arrow)"
