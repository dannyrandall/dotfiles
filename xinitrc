xset r rate 275 35
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/notification-daemon-1.0/notification-daemon &
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
export SSH_AUTH_SOCK
export GPG_AGENT_INFO
export GNOME_KEYRING_CONTROL

#sleep 5
#xrandr --output DisplayPort-1-1 --mode 1920x1200 --pos 0x0 --rotate normal --output VGA-1 --off --output HDMI-1 --off --output DP-1 --primary --mode 1920x1200 --pos 1920x0 --rotate normal --output DVI-1-0 --mode 1920x1200 --pos 3840x0 --rotate normal
xrandr --output DisplayPort-1-1 --auto
sleep 1 
xrandr --output DP-1 --auto --primary --right-of DisplayPort-1-1
sleep 1 
xrandr --output DVI-1-0 --auto --right-of DP-1
sleep 1 
exec bspwm
