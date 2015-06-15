#!/usr/bin/bash

set -e

# To find the latest version: https://www.filebot.net/download.php?mode=s&type=deb&arch=amd64
# We'll use a specific version for reproducible builds 
if [ ! -e 'filebot_4.6_amd64.deb' ]
then
  TMP=$(mktemp)
  wget -N 'http://downloads.sourceforge.net/project/filebot/filebot/FileBot_4.6/filebot_4.6_amd64.deb' -O $TMP
  mv $TMP filebot_4.6_amd64.deb
fi

docker build --rm=true -t coppit/filebot-ui . 
