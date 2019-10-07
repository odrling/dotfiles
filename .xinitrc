
setoutput || setwallpaper

dunst &
redshift -l 43.6006786:1.3628012 -t 6000:2500 &
xcompmgr &
slstatus &
xbacklight -set 30 &

setxkbmap fr oss &

unclutter --ignore-scrolling -b

exec ck-launch-session dbus-launch dwm
