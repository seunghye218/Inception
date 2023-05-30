#!/bin/sh

if [ ! -f "/var/www/adminer/index.php" ];
then
  mkdir -p /var/www/adminer
  curl -s -L https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql-en.php --output /var/www/adminer/index.php
fi

exec php-fpm${PHP_VERSION} --nodaemonize
