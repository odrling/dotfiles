
# dbus
eval "$(dbus-launch --sh-syntax --exit-with-session)"

# notification daemon
dunst &
# compositor
picom &

# default keyboard layout
sethid &

# hide cursor when unused
unclutter --ignore-scrolling -b

[ -e "$HOME/.xinitrc.local" ] && . "$HOME/.xinitrc.local"

command -v gentoo-pipewire-launcher && gentoo-pipewire-launcher &

# keyboard layout
setxkbmap -layout fr -variant oss -option "caps:escape,shift:both_capslock"

# disable bell
xset -b

# set wallpaper
setoutput

fcitx &

# start dwm
exec dwm
