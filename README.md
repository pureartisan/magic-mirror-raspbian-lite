# Magic Mirror for Raspbian Lite

A quick and easy, single command to setup [Magic Mirror](https://github.com/MichMich/MagicMirror) on Raspbian Lite. This script will install all required dependencies and a minimal GUI to run MagicMirror on Raspbian Lite (non-desktop version).

## Quick Setup

Simply run the command on your Raspberry Pi (this has been tested on Pi Zero W).

*NOTE*: This script can take a while as it updates Rasbian package manager and pulls in all dependencies.

```
bash -c "$(curl -sL https://raw.githubusercontent.com/pureartisan/magic-mirror-raspbian-lite/master/install.sh)"
```

Sit back and relax, or go have a coffee! :)

### Minimum Requirements

It is expected that you have the following already setup:
* Raspbian Lite installed
* The Raspberry Pi has an active internet connection
* You have something better to do while the script does it's magic!!! :)

## What does this do?

This script sets up the following in your Raspbian Lite setup:
* [X11](https://www.x.org/wiki/) (minimal GUI required to run a browser)
* [Midori](https://www.midori-browser.org/) (light weight webkit based browser, lighter/faster than using chromium)
* [Node](https://nodejs.org/en/) (required by MagicMirror)
* [MagicMirror](https://magicmirror.builders/)
* [Plymouth](https://gitlab.freedesktop.org/plymouth/plymouth) (pretty splash screens used by MagicMirror)
* Auto login to Raspberry Pi