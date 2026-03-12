#!/bin/sh

set -e

cd /var/www/html

if [ ! -f /var/www/html/config.php ]; then
    echo "Copying config.php from /var/moodledata/_internal/config.php"
    if [ -f /var/moodledata/_internal/config.php ]; then
        cp /var/moodledata/_internal/config.php /var/www/html/config.php
    else
        echo "No config.php found in /var/moodledata/_internal/. Proceed with installation."
    fi
fi