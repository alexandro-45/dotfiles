#
# ~/.bash_profile
#

#export GTK_THEME=Adwaita:dark
export MOZ_ENABLE_WAYLAND=1
export QT_QPA_PLATFORMTHEME=qt5ct
#export SSLKEYLOGFILE=~/.ssl-key.log
[[ -f ~/.bashrc ]] && . ~/.bashrc
[ "$(tty)" = "/dev/tty1" ] && exec sway
