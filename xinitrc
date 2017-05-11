xset r rate 275 35
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
exec bspwm
