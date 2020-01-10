# Magic Mirror for Raspbian Lite

A quick and easy, single command setup of [Magic Mirror](https://github.com/MichMich/MagicMirror) on Raspbian Lite. This script will install all required dependencies and a minimal GUI to run MagicMirror on Raspbian Lite (non-desktop version).

## Quick Setup

Simply run the command on your Raspberry Pi (this has been tested on Pi Zero W).

*NOTE*: This script can take a while as it update Rasbian package manager and pulls in all dependencies.

```
bash -c "$(curl -sL https://raw.githubusercontent.com/pureartisan/magic-mirror-raspbian-lite/master/install.sh)"
```