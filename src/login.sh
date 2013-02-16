#!/bin/sh

read -p "Username: " -e -r username
read -p "Password: " -e -r -s password
echo ""

password_md5=`echo -n "$password" | md5sum | awk '{ print $1 }'`
unset password

echo $username
echo $password_md5

response=`curl -s \
               --data-urlencode "username=$username" \
               --data-urlencode "password=$password_md5" \
               --data-urlencode "drop=0" \
               --data-urlencode "type=1" \
               --data-urlencode "n=100" \
               http://net.tsinghua.edu.cn/cgi-bin/do_login`
echo $response
