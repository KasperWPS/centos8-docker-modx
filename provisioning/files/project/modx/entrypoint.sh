#!/bin/bash

if [ ! -f /var/www/html/index.php ]; then

  cp -R /modx/* /var/www/html/
  #chown -R www-data:www-data /var/www/html

fi

exec "$@"
