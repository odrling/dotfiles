
# dbus
eval "$(dbus-launch --sh-syntax --exit-with-session)"

# set wallpaper
setoutput &

# notification daemon
dunst &
# night light
redshift -l 43.6006786:1.3628012 -t 6000:2500 &
# compositor
xcompmgr &
# status bar
dwmblocks &
# default screen brightness
xbacklight -set 30 &

# default keyboard layout
setxkbmap -layout fr -variant oss -option "caps:none,shift:both_capslock" &

# hide cursor when unused
unclutter --ignore-scrolling -b

# sound daemons
jack_control start
audio_input &
audio_output &
pulseaudio --start

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
