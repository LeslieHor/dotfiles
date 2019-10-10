#!/bin/bash

MODE=${1}

STRING=""
case ${MODE} in
    "window")
        STRING=${STRING}"[window] :: "
        STRING=${STRING}"h: set split h "
        STRING=${STRING}"| v: set split v "
        STRING=${STRING}"| f: toggle floating"
        STRING=${STRING}"| z: toggle fullscreen"
        STRING=${STRING}"| l: ->layout"
        ;;
    "window-layout")
        STRING=${STRING}"[window-layout] :: "
        STRING=${STRING}"t: tabbed  "
        STRING=${STRING}"| s: stacking  "
        STRING=${STRING}"| h: split h "
        STRING=${STRING}"| v: split v "
        ;;
    "frame")
        STRING=${STRING}"[frame] :: "
        STRING=${STRING}"r: rename  "
        STRING=${STRING}"| c: create frame "
        ;;
    *)
        ;;
esac

echo "${STRING}" > ~/.config/i3/i3_mode.txt
