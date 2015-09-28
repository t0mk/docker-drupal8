#!/bin/bash

chown www-data:www-data /app -R

APACHE_WEB_ROOT=/app
if [ -f ${APACHE_WEB_ROOT}/index.php ]; then
    DESIRED_UID=$(stat -c "%u" ${APACHE_WEB_ROOT}/index.php)
    DESIRED_GID=$(stat -c "%g" ${APACHE_WEB_ROOT}/index.php)

    # are there existing user or group for such IDs? ...
    EXISTING_USER=$(getent passwd $DESIRED_UID | cut -f 1 -d:)
    EXISTING_GROUP=$(getent group $DESIRED_GID | cut -f 1 -d:)


    # ... if yes, change those account IDs
    if [ -n "$EXISTING_USER" ]; then
        NEW_UID=$((($RANDOM % 500) + 300))
        usermod -u $NEW_UID $EXISTING_USER
    fi

    # ... same for group 
    if [ -n "$EXISTING_GROUP" ]; then
        NEW_GID=$((($RANDOM % 500) + 300))
        groupmod -g $NEW_GID $EXISTING_GROUP
    fi

    # finally change uid and gid of www-data
    usermod -u $DESIRED_UID www-data
    groupmod -g $DESIRED_GID www-data

    echo "Permissions corrected for www-data user"
fi

echo "Running Apache"
a2enmod rewrite
source /etc/apache2/envvars

if [ "$ALLOW_OVERRIDE" = "**False**" ]; then
    unset ALLOW_OVERRIDE
else
    sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf
    a2enmod rewrite
fi

source /etc/apache2/envvars
tail -F /var/log/apache2/* &
exec apache2 -D FOREGROUND
