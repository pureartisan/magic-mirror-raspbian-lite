#!/bin/bash

TEMPLATE_DIR=$MAGIC_MIRROR_RASP_LITE_DIR/templates

info "Copying app files '$MAGIC_MIRROR_APP_DIR'"
cp $TEMPLATE_DIR/app/* $MAGIC_MIRROR_APP_DIR

# replace placeholders
FILES=$MAGIC_MIRROR_APP_DIR/*
for f in $FILES
do
    sudo sed -i -e "s|%%MAGIC_MIRROR_DIR%%|$MAGIC_MIRROR_DIR|g" "$f"
    sudo sed -i -e "s|%%MAGIC_MIRROR_HOST%%|$MAGIC_MIRROR_HOST|g" "$f"
    sudo sed -i -e "s|%%MAGIC_MIRROR_PORT%%|$MAGIC_MIRROR_PORT|g" "$f"
done

# make files executable
sudo chmod a+x -R "$MAGIC_MIRROR_APP_DIR"