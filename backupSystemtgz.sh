#!/bin/bash
# Small Script to backup the root system to a compressed tgz file- Change the destination directory to your needs.
tar cvpzf /media/Storage/backup_$HOSTNAME-$(date +%Y-%m-%d_%H%M%S).tgz --exclude=/proc --exclude=/lost+found --exclude=/mnt --exclude=/var/cache/pacman --exclude=/sys --exclude=/home --exclude=/.snapshots --exclude=/media /
