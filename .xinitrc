
# dbus
eval "$(dbus-launch --sh-syntax --exit-with-session)"

# notification daemon
dunst &
# compositor
picom &
# default screen brightness
backlight 50 &

# default keyboard layout
sethid &

# hide cursor when unused
unclutter --ignore-scrolling -b

# map left control to escape
xcape -e 'Control_L=Escape' &

xmodmap ~/.config/Xmodmap

[ -e "$HOME/.xinitrc.local" ] && . "$HOME/.xinitrc.local"

# keyboard layout
setxkbmap -layout fr -variant oss -option "caps:none,shift:both_capslock"

# disable bell
xset -b

# set wallpaper
setoutput

# fcitx
export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
fcitx &

# start dwm
exec dwm
