#!/bin/bash

cd ~/
HOME_DIR=$(pwd)

MM_RASP_LITE="magic-mirror-raspbian-lite"
MAGIC_MIRROR_RASP_LITE_DIR="$HOME_DIR/$MM_RASP_LITE"

MAGIC_MIRROR_NAME="magic-mirror"
MAGIC_MIRROR_DIR="$HOME_DIR/$MAGIC_MIRROR_NAME"

MAGIC_MIRROR_APP_DIR="$HOME_DIR/magic-mirror-app"

# show installer splash
clear

echo -e "\e[33m"
echo '$$\      $$\                     $$\           $$\      $$\ $$\                                          $$$$$$\  '
echo '$$$\    $$$ |                    \__|          $$$\    $$$ |\__|                                        $$  __$$\ '
echo '$$$$\  $$$$ | $$$$$$\   $$$$$$\  $$\  $$$$$$$\ $$$$\  $$$$ |$$\  $$$$$$\   $$$$$$\   $$$$$$\   $$$$$$\  \__/  $$ |'
echo '$$\$$\$$ $$ | \____$$\ $$  __$$\ $$ |$$  _____|$$\$$\$$ $$ |$$ |$$  __$$\ $$  __$$\ $$  __$$\ $$  __$$\  $$$$$$  |'
echo '$$ \$$$  $$ | $$$$$$$ |$$ /  $$ |$$ |$$ /      $$ \$$$  $$ |$$ |$$ |  \__|$$ |  \__|$$ /  $$ |$$ |  \__|$$  ____/ '
echo '$$ |\$  /$$ |$$  __$$ |$$ |  $$ |$$ |$$ |      $$ |\$  /$$ |$$ |$$ |      $$ |      $$ |  $$ |$$ |      $$ |      '
echo '$$ | \_/ $$ |\$$$$$$$ |\$$$$$$$ |$$ |\$$$$$$$\ $$ | \_/ $$ |$$ |$$ |      $$ |      \$$$$$$  |$$ |      $$$$$$$$\ '
echo '\__|     \__| \_______| \____$$ |\__| \_______|\__|     \__|\__|\__|      \__|       \______/ \__|      \________|'
echo '                       $$\   $$ |                                                                                 '
echo '                       \$$$$$$  |                                                                                 '
echo '                        \______/                                                                                  '
echo -e "\e[1;32m"
echo '                                                                                                                  '
echo '$$$$$$$\                                $$\       $$\                           $$\       $$\   $$\               '
echo '$$  __$$\                               $$ |      \__|                          $$ |      \__|  $$ |              '
echo '$$ |  $$ | $$$$$$\   $$$$$$$\  $$$$$$\  $$$$$$$\  $$\  $$$$$$\  $$$$$$$\        $$ |      $$\ $$$$$$\    $$$$$$\  '
echo '$$$$$$$  | \____$$\ $$  _____|$$  __$$\ $$  __$$\ $$ | \____$$\ $$  __$$\       $$ |      $$ |\_$$  _|  $$  __$$\ '
echo '$$  __$$<  $$$$$$$ |\$$$$$$\  $$ /  $$ |$$ |  $$ |$$ | $$$$$$$ |$$ |  $$ |      $$ |      $$ |  $$ |    $$$$$$$$ |'
echo '$$ |  $$ |$$  __$$ | \____$$\ $$ |  $$ |$$ |  $$ |$$ |$$  __$$ |$$ |  $$ |      $$ |      $$ |  $$ |$$\ $$   ____|'
echo '$$ |  $$ |\$$$$$$$ |$$$$$$$  |$$$$$$$  |$$$$$$$  |$$ |\$$$$$$$ |$$ |  $$ |      $$$$$$$$\ $$ |  \$$$$  |\$$$$$$$\ '
echo '\__|  \__| \_______|\_______/ $$  ____/ \_______/ \__| \_______|\__|  \__|      \________|\__|   \____/  \_______|'
echo '                              $$ |                                                                                '
echo '                              $$ |                                                                                '
echo '                              \__|                                                                                '
echo -e "\e[0m"

function info() {
    echo -e "\e[1;45m"
    echo "$1"
    echo -e "\e[0m"
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =
}

function success() {
    echo -e "\e[1;32m"
    echo "$1"
    echo -e "\e[0m"
}

# Updating package managers
info 'Updating Pi - this may take a while...'
sudo apt-get -y update
info 'Upgrading Pi - this may take a while...'
sudo apt-get -y upgrade
sudo apt-get -y upgrade --fix-missing

info 'Installing git'
sudo apt install -y git

info 'Cloning "Magic Mirror"'
# remove if it already exists
sudo rm -rf "$MAGIC_MIRROR_RASP_LITE_DIR"
# now clone again
git clone https://github.com/MichMich/MagicMirror "$MAGIC_MIRROR_NAME"

info 'Cloning "Magic Mirror for Raspbian Lite"'
# remove if it already exists
sudo rm -rf "$MAGIC_MIRROR_RASP_LITE_DIR"
# now clone again
git clone https://github.com/pureartisan/magic-mirror-raspbian-lite.git "$MM_RASP_LITE"

info 'Creating app directory'
# remove if it already exists
sudo rm -rf "$MAGIC_MIRROR_APP_DIR"
# create app dir
mkdir -p "$MAGIC_MIRROR_APP_DIR"

# export so the child scripts can access them
export MAGIC_MIRROR_RASP_LITE_DIR
export MAGIC_MIRROR_DIR
export MAGIC_MIRROR_APP_DIR

# start the proper setup
. $MAGIC_MIRROR_RASP_LITE_DIR/setup/run.sh
. $MAGIC_MIRROR_RASP_LITE_DIR/setup/cleanup.sh

info 'Rebooting now...'
sudo reboot