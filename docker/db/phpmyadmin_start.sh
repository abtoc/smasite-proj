#!/bin/bash
if [ ! -f /usr/share/phpmyadmin/config.inc.php ]; then
    cp /var/www/html/config.sample.inc.php /var/www/html/config.inc.php
    echo "\$cfg['Servers'][\$i]['controluser'] = 'root';" >> /var/www/html/config.inc.php
    echo "\$cfg['Servers'][\$i]['controlpass'] = '${MYSQL_ROOT_PASSWORD}';"  >> /var/www/html/config.inc.php
    sed -i -e "s/^\$cfg\['blowfish_secret'\] = .\+$/\$cfg\['blowfish_secret'\] = '${PMA_BLOWFISH_SECRET}';/" /var/www/html/config.inc.php
fi
exec /usr/sbin/apache2ctl -D FOREGROUND
