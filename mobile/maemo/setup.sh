#!/bin/bash

set -x

sudo /scratchbox/sbin/sbox_ctl start
sleep 1

wget http://repository.maemo.org/stable/5.0/maemo-sdk-install_5.0.sh
sed -i -e 's/etch/squeeze/g' maemo-sdk-install_5.0.sh

echo "" | sh ./maemo-sdk-install_5.0.sh -d

sudo mkdir -p /scratchbox/users/admin/targets/FREMANTLE_X86/etc/apt/sources.list.d
sudo mkdir -p /scratchbox/users/admin/targets/FREMANTLE_ARMEL/etc/apt/sources.list.d
sudo chown -R admin.admin /scratchbox/users/admin/targets/FREMANTLE_X86 /scratchbox/users/admin/targets/FREMANTLE_ARMEL
cp /tmp/nokia.list /tmp/extras.list /scratchbox/users/admin/targets/FREMANTLE_X86/etc/apt/sources.list.d/
cp /tmp/nokia.list /tmp/extras.list /scratchbox/users/admin/targets/FREMANTLE_ARMEL/etc/apt/sources.list.d/

echo "alias ll='ls -l'" >> /scratchbox/users/admin/home/admin/.bashrc

sb-conf se FREMANTLE_X86
/scratchbox/login apt-get update
/scratchbox/login fakeroot apt-get -y --force-yes install nokia-binaries nokia-apps libqt4-dev libqt4-experimental-dev libtelepathy-qt4-dev

sb-conf se FREMANTLE_ARMEL
/scratchbox/login apt-get update
/scratchbox/login fakeroot apt-get -y --force-yes install nokia-binaries nokia-apps libqt4-dev libqt4-experimental-dev libtelepathy-qt4-dev
