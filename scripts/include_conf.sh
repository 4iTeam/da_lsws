#!/usr/bin/env bash

CFG=/usr/local/lsws/conf/httpd_config.conf
COUNT=`cat $CFG | grep -c directadmin.conf`
if [ $COUNT -lt 1 ]; then
	echo "Include /usr/local/da_lsws/conf/directadmin.conf" >> $CFG
fi
service litespeed restart
