# Required for xsession setup
. /etc/X11/Xsession
xrdb -load $HOME/.Xresources
xsetroot -solid '#222222' &

# Here i3 is kept as default
session=${1:-i3}

# Note: desktop files located in /usr/share/xsessions/

case $session in
    i3|i3wm)
        exec i3;;
    kde)
        exec startplasma-x11;;
    xfce|xfce4)
        exec startxfce4;;
    gnome)
        export XDG_SESSION_TYPE=x11
        export GNOME_BACKEND=x11
        exec gnome-session;;
    ubuntu)
        exec env GNOME_SHELL_SESSION_MODE=ubuntu /usr/bin/gnome-session --systemd --session=ubuntu;;
    work)
        xterm -e 'work-linux-connect' ; bash &
        exec env GNOME_SHELL_SESSION_MODE=ubuntu /usr/bin/gnome-session --systemd --session=ubuntu;;
    # No known session, try to run it as command
    *)
        exec $1;;
esac
