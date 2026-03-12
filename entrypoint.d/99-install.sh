#!/bin/sh

set -e 

cd /var/www/html

echo "Starting Moodle installation or migration if necessary..."

if [ -f /var/www/html/config.php ]; then
    if [ "${MOODLE_MIGRATE_DB}" = "true" ]; then
        echo "Migrating existing Moodle database..."
        php admin/cli/install_database.php --agree-license \
       --adminpass="${MOODLE_ADMIN_PASS:-secret}" --fullname="${MOODLE_FULL_NAME:-My Site}" --shortname="${MOODLE_SHORT_NAME:-My Site}"
    fi
else
    echo "No config.php found, starting fresh installation..."
    php admin/cli/install.php --agree-license \
        --lang=en --non-interactive \
        --dbtype="${MOODLE_DB_TYPE:-mysqli}" \
        --dbhost="${MOODLE_DB_HOST:-moodle-db}" \
        --dbname="${MOODLE_DB_NAME:-moodle}" \
        --dbuser="${MOODLE_DB_USER:-moodle}" \
        --dbpass="${MOODLE_DB_PASS:-secret}" \
        --dbport="${MOODLE_DB_PORT:-3306}" \
        --prefix="${MOODLE_DB_PREFIX:-mdl_}" \
        --wwwroot="${MOODLE_WWWROOT:-http://localhost:8080}" \
        --dataroot="/var/moodledata" \
        --adminpass="${MOODLE_ADMIN_PASS:-secret}" \
        --fullname="${MOODLE_FULL_NAME:-My Site}" \
        --shortname="${MOODLE_SHORT_NAME:-My Site}" \
        --adminemail="${MOODLE_ADMIN_EMAIL:-admin@example.com}" \
        --supportemail="${MOODLE_SUPPORT_EMAIL:-support@example.com}"
fi

if [ ! -f /var/moodledata/_internal/config.php ]; then
    echo "No backup of config.php found in /var/moodledata/_internal/. Creating one."

    echo "Backing up config.php to /var/moodledata/_internal/config.php"
    mkdir -p /var/moodledata/_internal

    cp /var/www/html/config.php /var/moodledata/_internal/config.php
fi

echo "Moodle installation or migration completed."