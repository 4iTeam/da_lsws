#!/usr/bin/env bash

for FILE in /usr/local/directadmin/data/users/*/httpd.conf; do
USER=`grep -im 1 "extUser" $FILE | perl -pi -e 's/extUser//i' | perl -pi -e 's/\s+//g'`;
GROUP=`grep -im 1 "extGroup" $FILE | perl -pi -e 's/extGroup//i' | perl -pi -e 's/\s+//g'`;
grep -i "docRoot" $FILE | perl -pi -e 's/\s*docroot\s*//i' | while read -r line ; do
    if [ ! -f $line/.htaccess ]; then
        touch  $line/.htaccess
    fi
    chown $USER:$GROUP $line/.htaccess
done

done
