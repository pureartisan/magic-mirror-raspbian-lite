#!/bin/bash

SERVICE_NAME='magic-mirror'
SERVICE_FILE="$SERVICE_NAME.service"

TEMPLATE_DIR=$MAGIC_MIRROR_RASP_LITE_DIR/templates
SYSTEMD_PATH=/etc/systemd/system
SERVICE_PATH="$SYSTEMD_PATH/$SERVICE_FILE"

MM_SERVER_STARTUP="$MAGIC_MIRROR_APP_DIR/start-server.sh"

info "Copying service file into '$SYSTEMD_PATH'"
sudo cp "$TEMPLATE_DIR/systemd/$SERVICE_FILE" "$SERVICE_PATH"

# replace placeholders
sed -i -e "s|%%ENTRY_POINT%%|$MM_SERVER_STARTUP|g" "$SERVICE_PATH"

# reset permissions
sudo chomod 755 "$SERVICE_PATH"
sudo chown root:root "$SERVICE_PATH"

info 'Enabling Magic Mirror Service...'
sudo systemctl daemon-reload
sudo systemctl enable "$SERVICE_NAME"