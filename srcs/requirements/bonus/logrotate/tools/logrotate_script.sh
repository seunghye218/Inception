#!/bin/sh

while :
do
    logrotate -vf /etc/logrotate.d/mariadb
    sleep 1h
done
