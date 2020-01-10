#!/bin/bash

TEMPLATE_DIR=$MAGIC_MIRROR_RASP_LITE_DIR/templates

echo 'Copying app files...'
cp $TEMPLATE_DIR/app/* $MAGIC_MIRROR_APP_DIR

# make files executable
sudo chmod +x -R $MAGIC_MIRROR_APP_DIR