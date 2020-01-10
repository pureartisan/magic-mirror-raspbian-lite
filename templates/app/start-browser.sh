#!/bin/bash

unclutter & \ # hide mouse cursor
matchbox-window-manager & \ # window manager for xinit
midori \ # load the browser
    -e Fullscreen \
    -a http://localhost:8080