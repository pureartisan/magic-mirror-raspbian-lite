#!/bin/bash

echo 'Enabling auto login to console as user `pi`'
sudo raspi-config nonint do_boot_behaviour B2
