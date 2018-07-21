#!/usr/bin/env bash

echo "Start configure...";

DALSWS=/usr/local/da_lsws
SCRIPTS=$DALSWS/scripts


cp -f ./conf/daconf/* /usr/local/directadmin/data/templates/custom


cp -f ./conf/httpd_config.conf /usr/local/lsws/conf/

chown apache:apache /usr/local/lsws/autoupdate -R
chown apache:apache /usr/local/lsws/cachedata -R
chown apache:apache /usr/local/lsws/admin/conf -R
chown apache:apache /usr/local/lsws/admin/tmp -R
chgrp apache /usr/local/lsws/admin/cgid

chown apache:apache /usr/local/lsws/conf -R
chown apache:apache /usr/local/lsws/phpbuild -R
chown apache:apache $DALSWS/conf/*.conf
usermod -a -G apache lsadm



ALL_POST=/usr/local/directadmin/scripts/custom/all_post.sh
if [ ! -f $ALL_POST ]; then
    echo "">$ALL_POST
fi

COUNT=`cat $ALL_POST | grep -c $SCRIPTS/da_post.sh`
if [ $COUNT -lt 1 ]; then
	echo "$SCRIPTS/da_post.sh" >> $ALL_POST
fi

chmod +x $ALL_POST
chmod +x $SCRIPTS/*.sh
chmod +x $DALSWS/bin/*
echo "All file deployed! Build config...";

/usr/local/directadmin/custombuild/build rewrite_confs


echo "Build listener";
./scripts/build-listeners.pl

echo "Restarting service...";
service litespeed stop
service litespeed start


