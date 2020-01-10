#!/bin/bash

if which node > /dev/null
then

    echo "node is installed, skipping node setup..."

else

    cd ~/

    echo 'Downloading latest LTS node: v12.14.1'
    curl -o node-v12.14.1-linux-arm64.tar.gz  https://nodejs.org/dist/v12.14.1/node-v12.14.1-linux-arm64.tar.gz

    echo 'Extracting node v12.14.1'
    tar -xzf node-v12.14.1-linux-arm64.tar.gz

    echo 'Setting up node and npm'
    sudo cp -R node-v12.14.1-linux-arm64/* /usr/local/

    echo 'Cleaning up node setup files'
    sudo rm -rf node-v12.14.1-linux-arm64

fi
