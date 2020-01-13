#!/bin/bash

MAGIC_MIRROR_HOST='%%MAGIC_MIRROR_HOST%%'
MAGIC_MIRROR_PORT='%%MAGIC_MIRROR_PORT%%'

unclutter & \ # hide mouse cursor
matchbox-window-manager & \ # window manager for xinit
midori -e Fullscreen -e Navigationbar -a "http://$MAGIC_MIRROR_HOST:$MAGIC_MIRROR_PORT"
