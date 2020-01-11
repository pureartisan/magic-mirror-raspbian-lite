#!/bin/bash

if which node > /dev/null
then

    info "node is installed, skipping node setup..."

else

    cd ~/

    info 'Downloading latest LTS node: v12.14.1'
    curl -o node-v12.14.1-linux-arm64.tar.gz  https://nodejs.org/dist/v12.14.1/node-v12.14.1-linux-arm64.tar.gz

    info 'Extracting node v12.14.1'
    tar -xzf node-v12.14.1-linux-arm64.tar.gz

    info 'Setting up node and npm'
    sudo cp -R node-v12.14.1-linux-arm64/* /usr/local/

    info 'Cleaning up node setup files'
    sudo rm -rf node-v12.14.1-linux-arm64

fi
