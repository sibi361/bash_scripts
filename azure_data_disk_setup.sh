#!/bin/bash
# azure_data_disk_setup.sh
# create ext4 FS on a blank data disk attached to an ms azure vm
# and edit fstab to mount it at the specified MOUNTPOINT at boot

set -e

MOUNTPOINT="/datadrive"

sudo parted /dev/sdc --script mklabel gpt mkpart xfspart xfs 0% 100%
sudo /sbin/mkfs.ext4 /dev/sdc1
sudo partprobe /dev/sdc1

sudo mkdir $MOUNTPOINT
sudo mount /dev/sdc1 $MOUNTPOINT

sudo chown $USER:$USER $MOUNTPOINT

sudo cp /etc/fstab /etc/fstab.bak
UUID_STRING=$(sudo blkid | grep "/dev/sdc" | awk '{ print $2 }')
FSTAB_STRING="$UUID_STRING   /datadrive   ext4   defaults,nofail   1   2"
echo "$FSTAB_STRING" | sudo tee -a /etc/fstab

