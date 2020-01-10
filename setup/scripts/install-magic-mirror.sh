#!/bin/bash

cd "$MAGIC_MIRROR_DIR"

echo 'Installing Magic Mirror dependencies'
npm install

echo 'Setting up default config'
# Copy default sample file
cp config/config.js.sample config/config.js