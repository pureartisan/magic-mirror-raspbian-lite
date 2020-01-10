#!/bin/bash

TEMPLATE_DIR=$MAGIC_MIRROR_RASP_LITE_DIR/templates
COMMENT_MM_RASP_LITE='#### Auto entry - Magic Mirror Raspbian Lite'

XINITRC=~/.xinitrc
XINITRC_BACKUP=~/.xinitrc.backup

BASHRC=~/.bashrc
BASHRC_BACKUP=~/.bashrc.backup

echo 'Setting up X Server on startup'

# -----------------------------------------------
# changes to .xinitrc
# -----------------------------------------------

# create backup if file already exists
if [ -f "$XINITRC" ]
then
    echo "File existing, so creating backup of $XINITRC"
    cp $XINITRC $XINITRC_BACKUP
fi

echo "Adding $XINITRC file..."

# copy the xinitrc file
cp $TEMPLATE_DIR/.xinitrc $XINITRC
sudo chmod a+x $XINITRC

# add the entry point
echo "# start app" >> $XINITRC
echo "$MAGIC_MIRROR_APP_DIR/start-browser.sh" >> $XINITRC


# -----------------------------------------------
# changes to .bashrc
# -----------------------------------------------

if grep -q "$COMMENT_MM_RASP_LITE" "$File"
then

  echo "Entry already found, so skipping changes to $BASHRC"

else

    echo "Creating backup of $BASHRC"
    if [ -f "$BASHRC" ]
    then
        cp $BASHRC $BASHRC_BACKUP
    fi

    echo "Adding entry to $BASHRC"

    echo "$COMMENT_MM_RASP_LITE | START" >> $BASHRC
    # if not connecting via SSH only
    echo 'if [ -z "$SSH_CLIENT" ] || [ -z "$SSH_TTY" ]; then' >> $BASHRC
    # export directory
    echo "    MAGIC_MIRROR_DIR=$MAGIC_MIRROR_DIR" >> $BASHRC
    echo '    export MAGIC_MIRROR_DIR' >> $BASHRC
    # start the magic mirror server
    echo "    $MAGIC_MIRROR_APP_DIR/start-server.sh" >> $BASHRC
    # sleep for 30 seconds, give a bit of a buffer for the server to warm up
    echo '    sleep 30' >> $BASHRC
    # start xinit (browser will start using the .xinitrc file)
    echo '    xinit -- -nocursor' >> $BASHRC
    echo 'fi' >> $BASHRC
    echo "$COMMENT_MM_RASP_LITE | END" >> $BASHRC

fi
