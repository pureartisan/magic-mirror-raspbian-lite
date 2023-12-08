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
sudo sed -i -e "s|%%ENTRY_POINT%%|$MM_SERVER_STARTUP|g" "$SERVICE_PATH"
sudo sed -i -e "s|%%USER%%|$USER|g" "$SERVICE_PATH"
sudo sed -i -e "s|%%HOME_DIR%%|$HOME_DIR|g" "$SERVICE_PATH"

# reset permissions
sudo chmod 644 "$SERVICE_PATH"
sudo chown root:root "$SERVICE_PATH"

ACTION='Enabling'
if ! $MAGIC_MIRROR_SETUP; then
    ACTION='Disabling'
fi

info "$ACTION Magic Mirror Service..."
sudo systemctl daemon-reload

# now we can check if the user wants to setup
if $MAGIC_MIRROR_SETUP; then
    success "Enabling service"
    sudo systemctl enable "$SERVICE_NAME"
else
    success "Skipping Magic Mirror server setup (per user input)"
    sudo systemctl disable "$SERVICE_NAME"
fi