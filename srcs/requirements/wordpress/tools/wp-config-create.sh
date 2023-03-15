#!bin/sh

set -e

if [ ! -f "/var/www/wp-config.php" ]; then

cat << EOF > /var/www/wp-config.php
<?php
define( 'DB_NAME', '${DB_NAME}' );
define( 'DB_USER', '${DB_USER}' );
define( 'DB_PASSWORD', '${DB_PASS}' );
define( 'DB_HOST', 'mariadb' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );
define('FS_METHOD','direct');
\$table_prefix = 'wp_';
define( 'WP_DEBUG', false );
if ( ! defined( 'ABSPATH' ) ) {
define( 'ABSPATH', __DIR__ . '/' );}
require_once ABSPATH . 'wp-settings.php';
EOF
#define( 'WP_REDIS_HOST', 'redis' );
#define( 'WP_REDIS_PORT', 6379 );
#define( 'WP_REDIS_TIMEOUT', 1 );
#define( 'WP_REDIS_READ_TIMEOUT', 1 );
#define( 'WP_REDIS_DATABASE', 0 );

cd /var/www
#jseo wp-cli
wp core install --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PWD" --admin_email="$WP_ADMIN_EMAIL" --skip-email --path=/var/www/
#wp plugin install redis-cache --activate --path=/var/www/
#wp plugin update --all --path=/var/www/
wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PWD --path=/var/www/
#wp redis enable --path=/var/www/

#wp config create --dbname=$DB_ROOT --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=mariadb --dbcharset="utf8"
fi

/usr/sbin/php-fpm8 -F
