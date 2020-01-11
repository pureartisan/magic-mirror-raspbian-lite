#!/bin/bash

cd "$MAGIC_MIRROR_DIR"

info 'Installing Magic Mirror dependencies'
npm install

info 'Setting up default config'
# Copy default sample file
cp config/config.js.sample config/config.js