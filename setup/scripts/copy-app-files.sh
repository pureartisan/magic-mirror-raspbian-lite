#!/bin/bash

TEMPLATE_DIR=$MAGIC_MIRROR_RASP_LITE_DIR/templates

info "Copying app files '$MAGIC_MIRROR_APP_DIR'"
cp $TEMPLATE_DIR/app/* $MAGIC_MIRROR_APP_DIR

# make files executable
sudo chmod a+x -R "$MAGIC_MIRROR_APP_DIR"