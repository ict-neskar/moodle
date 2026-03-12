#!/bin/sh

set -e 

cd /var/www/html

# if [ -f /var/www/html/config.php ]; then
#     # Check if xsendfile configuration exists, if not append it
#     if ! grep -q "xsendfile.*X-Accel-Redirect" /var/www/html/config.php; then
#         sed -i '/require_once.*lib\/setup\.php/i \
# $CFG->xsendfile = '\''X-Accel-Redirect'\'';\
# $CFG->xsendfilealiases = array(\
#     '\''/dataroot/'\'' => $CFG->dataroot\
# );' /var/www/html/config.php
#     fi
# else
#     echo "Moodle is not installed. Please run the installation script first."
#     exit 1
# fi
