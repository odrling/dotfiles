
# dbus
eval "$(dbus-launch --sh-syntax --exit-with-session)"

# set wallpaper
setoutput &

# notification daemon
dunst &
# compositor
picom &
# default screen brightness
xbacklight -set 30 &

# default keyboard layout
sethid &

# hide cursor when unused
unclutter --ignore-scrolling -b

# fcitx
export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
fcitx &

# map left control to escape
xcape -e 'Control_L=Escape' &

[ -e "$HOME/.xinitrc.local" ] && . "$HOME/.xinitrc.local"

# start dwm
exec dwm
