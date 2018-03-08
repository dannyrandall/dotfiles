#!/bin/bash

#/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
#/usr/lib/notification-daemon-1.0/notification-daemon &
#eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
#export SSH_AUTH_SOCK
#export GPG_AGENT_INFO
#export GNOME_KEYRING_CONTROL

exec bspwm
