#!/bin/bash

SETUP_SCRIPTS_DIR=$MAGIC_MIRROR_RASP_LITE_DIR/setup/scripts

# install required packages
. $SETUP_SCRIPTS_DIR/install-node.sh
. $SETUP_SCRIPTS_DIR/install-minimal-gui.sh
. $SETUP_SCRIPTS_DIR/install-browser.sh

# install magic mirror even if the user don't want to run magic mirror server
# since we use this for splash screen
. $SETUP_SCRIPTS_DIR/install-magic-mirror.sh

# setup options
. $SETUP_SCRIPTS_DIR/copy-app-files.sh
. $SETUP_SCRIPTS_DIR/setup-boot-options.sh

# now we can check if the user wants to setup
if $MAGIC_MIRROR_SETUP; then
    . $SETUP_SCRIPTS_DIR/setup-magic-mirror-service.sh
else
    success "Skipping Magic Mirror server setup (per user input)"
fi

# setup screen and bootup
. $SETUP_SCRIPTS_DIR/setup-plymouth.sh
. $SETUP_SCRIPTS_DIR/setup-xserver-on-startup.sh
