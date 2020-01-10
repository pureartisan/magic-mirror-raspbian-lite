#!/bin/bash

cd ~/
HOME_DIR=$(pwd)

MM_RASP_LITE="magic-mirror-raspbian-lite"
MAGIC_MIRROR_RASP_LITE_DIR="$HOME_DIR/$MM_RASP_LITE"

MAGIC_MIRROR_NAME="magic-mirror"
MAGIC_MIRROR_DIR="$HOME_DIR/$MAGIC_MIRROR_NAME"

MAGIC_MIRROR_APP_DIR="$HOME_DIR/magic-mirror-app"

# Updating package managers
echo 'Updating Pi - this may take a while...'
sudo apt-get update
echo 'Upgrading Pi - this may take a while...'
sudo apt-get upgrade
sudo apt-get upgrade --fix-missing

echo 'Installing git'
sudo apt install -y git

echo 'Cloning "Magic Mirror"'
# remove if it already exists
sudo rm -rf "$MAGIC_MIRROR_RASP_LITE_DIR"
# now clone again
git clone https://github.com/MichMich/MagicMirror "$MAGIC_MIRROR_NAME"

echo 'Cloning "Magic Mirror for Raspbian Lite"'
# remove if it already exists
sudo rm -rf "$MAGIC_MIRROR_RASP_LITE_DIR"
# now clone again
git clone https://github.com/pureartisan/magic-mirror-raspbian-lite.git "$MM_RASP_LITE"

echo 'Creating app directory'
# remove if it already exists
sudo rm -rf "$MAGIC_MIRROR_APP_DIR"
# create app dir
mkdir -p "$MAGIC_MIRROR_APP_DIR"

# export so the child scripts can access them
export MAGIC_MIRROR_RASP_LITE_DIR
export MAGIC_MIRROR_DIR
export MAGIC_MIRROR_APP_DIR

# start the proper setup
$MAGIC_MIRROR_RASP_LITE_DIR/setup/run.sh
$MAGIC_MIRROR_RASP_LITE_DIR/setup/cleanup.sh

echo 'Rebooting now...'
sudo reboot