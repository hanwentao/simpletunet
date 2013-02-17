#!/bin/bash

cp -f simpletunet /usr/local/sbin
dist=`lsb_release -i | awk '{ print $NF }'`
case "$dist" in
    Debian|Ubuntu)
        cp -f examples/simpletunet-init.debian /etc/init.d/simpletunet
        update-rc.d simpletunet defaults 10
        ;;
    Gentoo)
        cp -f examples/simpletunet-init.gentoo /etc/init.d/simpletunet
        rc-update add simpletunet default
        ;;
    *)
        echo "Your distribution is not fully supported.  Please install init script by yourself."
        ;;
esac

read -p "Username: " -e -r username
read -p "Password: " -e -r -s password
echo ""
password_md5=`echo -n "$password" | md5sum | awk '{ print $1 }'`
unset password

cat >/etc/default/simpletunet <<EOF
# Configuration file of simpletunet init script
USERNAME="$username"
PASSWORD_MD5="$password_md5"
EOF
chmod 600 /etc/default/simpletunet

echo "Installation completed"
