#!/bin/bash

THEME_NAME='MagicMirror'
PLYMOUTH_THEME_DIR=/usr/share/plymouth/themes
THEME_DIR=$PLYMOUTH_THEME_DIR/$THEME_NAME

echo 'Installing plymouth'
sudo apt-get install plymouth plymouth-themes

echo 'Setting up Magic Mirror splash screen'
sudo mkdir -p "$THEME_DIR"
sudo cp $MAGIC_MIRROR_DIR/splashscreen/* $THEME_DIR

echo 'Enable Magic Mirror splash screen'
sudo plymouth-set-default-theme -R "$THEME_NAME"