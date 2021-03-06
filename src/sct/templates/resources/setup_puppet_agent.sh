#!/bin/sh

#
# This script registers 'puppet' in /etc/hosts
#
. /etc/profile

grep "puppet" /etc/hosts || echo "@puppetServer puppet" >> /etc/hosts
echo -e "START=yes\nDAEMON_OPTS=\"\"\n" > /etc/default/puppet

rm -fr /var/lib/puppet/ssl/*
/etc/init.d/puppet start

SWAP_DISKS=$(blkid -s TYPE | grep -i swap | cut -d ":" -f 1)
for DSK in $SWAP_DISKS; do
    swapon $DSK
done
