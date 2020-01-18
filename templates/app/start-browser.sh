#!/bin/bash

MAGIC_MIRROR_HOST='%%MAGIC_MIRROR_HOST%%'
MAGIC_MIRROR_PORT='%%MAGIC_MIRROR_PORT%%'

# clean up error notifications in chromium (crash reports)
sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' ~/.config/chromium/'Local State'
sed -i 's/"exited_cleanly":false/"exited_cleanly":true/; s/"exit_type":"[^"]\+"/"exit_type":"Normal"/' ~/.config/chromium/Default/Preferences

unclutter & \ # hide mouse cursor
matchbox-window-manager & \ # window manager for xinit
chromium-browser --noerrdialogs --kiosk --incognito --disable-translate "http://$MAGIC_MIRROR_HOST:$MAGIC_MIRROR_PORT"
