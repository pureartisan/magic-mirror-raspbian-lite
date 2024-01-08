#!/bin/bash

TEMPLATE_DIR=$MAGIC_MIRROR_RASP_LITE_DIR/templates
COMMENT_MM_RASP_LITE='#### Auto entry - Magic Mirror Raspbian Lite'

XINITRC=~/.xinitrc
XINITRC_BACKUP=~/.xinitrc.backup

XSERVERRC=~/.xserverrc
XSERVERRC_BACKUP=~/.xserverrc.backup

BASHRC=~/.bashrc
BASHRC_BACKUP=~/.bashrc.backup

info 'Setting up X Server on startup'

# -----------------------------------------------
# changes to .xinitrc
# -----------------------------------------------

# create backup if file already exists
if [ -f "$XINITRC" ]
then
    echo "File existing, so creating backup of $XINITRC"
    cp $XINITRC $XINITRC_BACKUP
fi

info "Adding '$XINITRC' file..."

# copy the xinitrc file
cp $TEMPLATE_DIR/.xinitrc $XINITRC
sudo chmod a+x $XINITRC

# add the entry point
echo "# start app" >> $XINITRC
echo "$MAGIC_MIRROR_APP_DIR/start-browser.sh" >> $XINITRC


# -----------------------------------------------
# changes to .xserverrc
# -----------------------------------------------

# create backup if file already exists
if [ -f "$XSERVERRC" ]
then
    echo "File existing, so creating backup of $XSERVERRC"
    cp $XSERVERRC $XSERVERRC_BACKUP
fi

info "Adding '$XSERVERRC' file..."

# copy the xserverrc file
cp $TEMPLATE_DIR/.xserverrc $XSERVERRC
sudo chmod a+x $XSERVERRC


# -----------------------------------------------
# changes to .bashrc
# -----------------------------------------------

touch "$BASHRC"

if grep -q "$COMMENT_MM_RASP_LITE" "$BASHRC"
then

  echo "Entry already found, so skipping changes to $BASHRC"

else

    info "Creating backup of $BASHRC"
    if [ -f "$BASHRC" ]
    then
        cp $BASHRC $BASHRC_BACKUP
    fi

    info "Adding entry to $BASHRC"

    echo "$COMMENT_MM_RASP_LITE | START" >> $BASHRC
    # if not connecting via SSH only
    echo 'if [ -z "$SSH_CLIENT" ] || [ -z "$SSH_TTY" ]; then' >> $BASHRC
    # start xinit (browser will start using the .xinitrc file)
    echo '    xinit -- -nocursor' >> $BASHRC
    echo 'fi' >> $BASHRC
    echo "$COMMENT_MM_RASP_LITE | END" >> $BASHRC

fi
