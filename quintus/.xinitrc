xrdb -load $HOME/.Xresources
xsetroot -solid '#222222' &
xterm

# Here Xfce is kept as default
session=${1:-i3}

case $session in
    i3|i3wm           ) exec i3;;
    kde               ) exec startplasma-x11;;
    xfce|xfce4        ) exec startxfce4;;
    ubuntu            ) exec ubuntu;;
    # No known session, try to run it as command
    *                 ) exec $1;;
esac
