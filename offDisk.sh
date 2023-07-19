#!/bin/bash

# offDisk.sh
# Bash script to unmount and power off an external hard drive
# This script is intended to be used with a single partition disk
# Mimics the "Power Off" functionality available in gnome-disk-utility

# Requirements
# - udisksctl

# Setup
# Set the UUID as a global variable named (off_disk_uuid)
# OR set it locally below in (disk_uuid)

# to fetch UUID:
# lsblk --output NAME,SIZE,disk_uuid

disk_uuid=""

set -e # exit script on unhandled error

if [[ -z $disk_uuid ]]; then
    if [[ -z $off_disk_uuid ]]; then
        echo "Error: disk UUID not found locally or globally"
        echo "If you wish to set it globally, add the following"
        echo "to your .bashrc:"
        echo "export off_disk_uuid=\"<your-disk-uuid-here>\""
        exit 1
    else
        disk_uuid=$off_disk_uuid
    fi
fi

echo "NOTICE: Powering off disk with UUID: $disk_uuid"

block_device=$(readlink -f /dev/disk/by-uuid/"$disk_uuid")
if [[ $block_device =~ $disk_uuid ]]; then
    echo "ERROR: disk with the given disk_uuid was not found"
    exit 1
fi

block_disk=${block_device/[0-9]/}

mountpoint=$(mount | grep $block_disk | awk '{ print $3 }')
umount "$mountpoint"

sudo udisksctl power-off -b "$block_disk"

echo "SUCCESS: Disk has been powered off successfully"
