#!/bin/bash

cd "$MAGIC_MIRROR_DIR"

ARM=$(uname -m)

info 'Installing Magic Mirror dependencies'

# Raspberry Pi Zero?
if [ "$ARM" == 'armv6l' ]; then
    # MagicMirror has a dependency for electron
    # But electron only supports `armv7l`
    npm --arch=armv7l install electron
else
    npm install install
fi

info 'Setting up default config'
# Copy default sample file
cp config/config.js.sample config/config.js