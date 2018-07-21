#!/usr/bin/env bash
PROG="$0"
BASE_DIR=`dirname "$PROG"`
cd "$BASE_DIR"
BASE_DIR=`pwd`

if [ -x /usr/local/lsws/bin/openlitespeed ]; then
	echo "Already installed";
	chmod 710 . -R
	exit;
fi
service litespeed stop
rm /usr/local/lsws -rf
rpm -ivh http://rpms.litespeedtech.com/centos/litespeed-repo-1.1-1.el7.noarch.rpm
yum install openlitespeed -y

LS_SERVICE=/etc/systemd/system/lshttpd.service
if [ -e $LS_SERVICE ]; then
    perl -pi -e 's/^Type=.*$/Type=simple/' $LS_SERVICE
    perl -pi -e 's/^PIDFile=.*$/PIDFile=\/tmp\/lshttpd\/lshttpd.pid/' $LS_SERVICE
	systemctl daemon-reload
	service litespeed start
else
	echo "Could not find service file";
fi


echo "Installed";
chmod +x ./build.sh
./build.sh;

DA_LS_SERVICE=/etc/systemd/system/dalsws.service
if [ ! -e $DA_LS_SERVICE ]; then
    cp ./bin/services/dalsws.service $DA_LS_SERVICE;
    systemctl daemon-reload
    systemctl start dalsws.service
    systemctl enable dalsws.service
fi