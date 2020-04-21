
# set wallpaper
setoutput || setwallpaper

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
setxkbmap fr oss &

# hide cursor when unused
unclutter --ignore-scrolling -b

# start dwm
exec ck-launch-session dbus-launch dwm
