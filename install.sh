#!/usr/bin/env bash
PROG="$0"
BASE_DIR=`dirname "$PROG"`
cd "$BASE_DIR"
BASE_DIR=`pwd`


if [ -x /usr/local/lsws/bin/openlitespeed ]; then
	echo "Already installed";
	exit;
fi

if [ ! -x /usr/local/directadmin/directadmin ]; then
	echo "Please install directadmin first";
	exit;
fi

if [ ! -x /usr/local/lsws/bin/litespeed ]; then
	echo "Please install litespeed first. if you don't know how to install litespeed on da check this guide";
	echo "https://www.litespeedtech.com/support/wiki/doku.php/litespeed_wiki:directadmin:custombuild-installation";
	exit;
fi
LS_SERVICE=/etc/systemd/system/lshttpd.service
if [ -e $LS_SERVICE ]; then
    service litespeed stop
    perl -pi -e 's/^Type=.*$/Type=simple/' $LS_SERVICE
    perl -pi -e 's/^PIDFile=.*$/PIDFile=\/tmp\/lshttpd\/lshttpd.pid/' $LS_SERVICE
	systemctl daemon-reload
else
	echo "Could not find service file /etc/systemd/system/lshttpd.service";
	exit;
fi


rm /usr/local/lsws -rf
rpm -ivh http://rpms.litespeedtech.com/centos/litespeed-repo-1.1-1.el7.noarch.rpm
yum install openlitespeed -y


echo "Update config files";

chmod +x ./build.sh
./build.sh;

DA_LS_SERVICE=/etc/systemd/system/dalsws.service
if [ ! -e $DA_LS_SERVICE ]; then
    cp ./bin/services/dalsws.service $DA_LS_SERVICE;
    systemctl daemon-reload
    systemctl start dalsws.service
    systemctl enable dalsws.service
fi

echo "Done";

