#!/bin/bash

CONF_PATH="/etc/simpletunet.conf"
LOG_PATH="/var/log/simpletunet.log"

[ -f $CONF_PATH ] && . $CONF_PATH

if [ -z "$USERNAME" ]; then
    read -p "Username: " -e -r username
else
    username="$USERNAME"
fi
if [ -z "$PASSWORD_MD5" ]; then
    if [ -z "$PASSWORD" ]; then
        read -p "Password: " -e -r -s password
        echo ""
    else
        password="$PASSWORD"
    fi
    password_md5=`echo -n "$password" | md5sum | awk '{ print $1 }'`
    unset password
else
    password_md5="$PASSWORD_MD5"
fi

response=`curl -s \
               --data-urlencode "username=$username" \
               --data-urlencode "password=$password_md5" \
               --data-urlencode "drop=0" \
               --data-urlencode "type=1" \
               --data-urlencode "n=100" \
               http://net.tsinghua.edu.cn/cgi-bin/do_login`
echo "[`date -R`] $response" >>$LOG_PATH
