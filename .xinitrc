
unclutter &
dunst &
redshift -l 43.6006786:1.3628012 -t 6000:2000 &
xcompmgr &
slstatus &
xbacklight -set 50 &

setxkbmap fr oss &
setoutput || setwallpaper

exec ck-launch-session dbus-launch dwm
