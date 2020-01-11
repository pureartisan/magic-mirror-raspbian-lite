#!/bin/bash

if which node > /dev/null
then

    info "node is installed, skipping node setup..."

else

    # taken from the the official magic mirror installer script:
    # https://github.com/MichMich/MagicMirror/blob/v2.10.1/installers/raspberry.sh

    cd ~/

    NODE_MAJOR_VERSION="12"
    ARM=$(uname -m)

    info "Installing node"

    # node official debian distribution doesn't support ARM, so using unofficial distribution
    sudo apt-get install -y --only-upgrade libstdc++6

    node_ver=$(curl -sL https://unofficial-builds.nodejs.org/download/release/index.tab | grep $ARM | grep -m 1 v$NODE_MAJOR_VERSION | awk '{print $1}')
    echo "Latest release in the $NODE_MAJOR_VERSION family for $ARM is $node_ver"

    NODE_TAR_FILE="node_release-$node_ver.tar.gz"

    curl -sL https://unofficial-builds.nodejs.org/download/release/$node_ver/node-$node_ver-linux-$ARM.tar.gz >"$NODE_TAR_FILE"
    echo "using release tar file = '$NODE_TAR_FILE' and extracting to '/usr/local'"

    cd /usr/local
    sudo tar --strip-components 1 -xzf "$HOME_DIR/$NODE_TAR_FILE"
    cd - >/dev/null

    rm "$HOME_DIR/$NODE_TAR_FILE"

fi

echo "Node version:"
node -v

echo "NPM version:"
npm -v