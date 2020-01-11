#!/bin/bash

if which node > /dev/null
then

    info "node is installed, skipping node setup..."

else

    NODE_STABLE_BRANCH="10.x"

    # sudo apt-get install --only-upgrade libstdc++6
    node_info=$(curl -sL https://deb.nodesource.com/setup_$NODE_STABLE_BRANCH | sudo -E bash - )

    if [ "$(echo $node_info | grep "not currently supported")." == "." ]; then
		sudo apt-get install -y nodejs
    fi

fi

node -v
npm -v