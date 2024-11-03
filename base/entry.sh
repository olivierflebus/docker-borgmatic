#!/bin/sh

# maybe needded
systemctl rsyslog start
systemctl cron restart
crontab -r

# fix link-count, as cron is being a pain, and docker is making hardlink count >0 (very high)
# see https://unix.stackexchange.com/questions/453006/getting-cron-to-work-on-docker
touch /etc/crontab /etc/cron.*/*

# Import your cron file
crontab /etc/borgmatic.d/crontab.txt

trap : TERM INT
tail -f /var/log/syslog & wait

