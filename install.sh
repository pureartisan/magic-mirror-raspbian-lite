#!/bin/bash

# stop on error
set -e

cd ~/
HOME_DIR=$(pwd)

MM_RASP_LITE="magic-mirror-raspbian-lite"
MAGIC_MIRROR_RASP_LITE_DIR="$HOME_DIR/$MM_RASP_LITE"

MAGIC_MIRROR_NAME="magic-mirror"
MAGIC_MIRROR_DIR="$HOME_DIR/$MAGIC_MIRROR_NAME"

MAGIC_MIRROR_APP_DIR="$HOME_DIR/magic-mirror-app"

MAGIC_MIRROR_SETUP=true
MAGIC_MIRROR_HOST="localhost"
MAGIC_MIRROR_PORT="8080"

MAGIC_MIRROR_RASP_LITE_GIT='https://github.com/pureartisan/magic-mirror-raspbian-lite.git'
MAGIC_MIRROR_GIT='https://github.com/MichMich/MagicMirror'

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

function drawLine() {
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =
}

function info() {
    echo -e "\e[1;45m$1\e[0m"
    drawLine
}

function success() {
    echo -e "\e[1;32m$1\e[0m"
}

# draw line before asking questions
drawLine

echo "Magic Mirror server will be installed on this Raspberry Pi."
echo "However, you can use setup and/or connect to another Magic Mirror server via the network."

echo "Would you like to setup the Magic Mirror server on this Raspberry Pi? [Y/n]"
while true; do
    read $input
    case $input in
        "" )
        [Yy]* )
            MAGIC_MIRROR_SETUP=true
            break;;
        [Nn]* )
            MAGIC_MIRROR_SETUP=false
            break;;
        * ) echo "Please answer y(es) or n(o).";;
    esac
done

if [ ! $MAGIC_MIRROR_SETUP ]; then

    echo "What is the HOST for the Magic Mirror server? Enter IP address (or hostname)."
    while true; do
        read $input
        if [ -z "$input" ]
        then
            echo "Please enter a valid host."
        else
            MAGIC_MIRROR_HOST=$input
            break;
        fi
    done

    echo "What is the PORT for the Magic Mirror server? Enter server port."
    while true; do
        read $input
        if ! [[ $input =~ '^[0-9]+$' ]]
        then
            echo "Please enter a valid port."
        else
            MAGIC_MIRROR_PORT=$input
            break;
        fi
    done

fi

drawLine
echo "The rest will be automatic, so sit back and relax..."

# Updating package managers
info 'Updating Pi - this may take a while...'
sudo apt-get -y update
info 'Upgrading Pi - this may take a while too...'
sudo apt-get -y upgrade
sudo apt-get -y upgrade --fix-missing

info 'Installing git'
sudo apt install -y git

info 'Cloning "Magic Mirror"'
# remove if it already exists
sudo rm -rf "$MAGIC_MIRROR_DIR"
# now clone again
git clone "$MAGIC_MIRROR_GIT" "$MAGIC_MIRROR_NAME"

info 'Cloning "Magic Mirror for Raspbian Lite"'
# remove if it already exists
sudo rm -rf "$MAGIC_MIRROR_RASP_LITE_DIR"
# now clone again
git clone "$MAGIC_MIRROR_RASP_LITE_GIT" "$MM_RASP_LITE"

info 'Creating app directory'
# remove if it already exists
sudo rm -rf "$MAGIC_MIRROR_APP_DIR"
# create app dir
mkdir -p "$MAGIC_MIRROR_APP_DIR"
# list the directory
cd "$MAGIC_MIRROR_APP_DIR" && cd ..
ls -la

# export so the child scripts can access them
export HOME_DIR
export MAGIC_MIRROR_RASP_LITE_DIR
export MAGIC_MIRROR_DIR
export MAGIC_MIRROR_APP_DIR
export MAGIC_MIRROR_SETUP
export MAGIC_MIRROR_HOST
export MAGIC_MIRROR_PORT

# start the proper setup
. $MAGIC_MIRROR_RASP_LITE_DIR/setup/run.sh
. $MAGIC_MIRROR_RASP_LITE_DIR/setup/cleanup.sh

info 'Rebooting now...'
sudo reboot