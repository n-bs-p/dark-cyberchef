#!/bin/sh
# =========================================
# This script runs in the builder container.
#
# This is intended to be run in the /app/
# directory as stated in the Dockerfile.
#
# It downloads the latest Cyberchef release
# and modifies the default theme.
#
# =========================================
CC_ZIP=$(curl -s https://api.github.com/repos/gchq/CyberChef/releases/latest | jq -r '. | .assets[].browser_download_url')
CC_ZIPNAME=$(echo $CC_ZIP | sed 's/^.*\///')
CC_RELEASE=$(echo $CC_ZIPNAME | sed 's/\.zip$//')
# download the zip
wget -q $CC_ZIP
unzip -q $CC_ZIPNAME
# set default to solarized dark
sed -i 's/theme:"classic"/theme:"solarizedDark"/g' /app/assets/main.js
# make it index.html so it's easier for nginx to point to:
mv $CC_RELEASE.html index.html
# put my mark on it for fun:
sed -i 's/\(<span>Version [0-9\.]*\)/\1: delivered by <a href="https:\/\/github.com\/n-bs-p\/dark-cyberchef">dark cyberchef<\/a>/' /app/index.html
# remove original zip
rm $CC_ZIPNAME
