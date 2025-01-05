#!/bin/sh
cd /var/www/html

sleep 10

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
./wp-cli.phar core download --allow-root --path=/var/www/html
./wp-cli.phar config create --dbname=$DB_NAME --dbuser=$DB_USERNAME --dbpass=$DB_USERPASS --dbhost=mariadb --allow-root
./wp-cli.phar core install --url=localhost --title=inception --admin_user=admin --admin_password=admin --admin_email=admin@admin.com --allow-root
./wp-cli.phar core install --url=dliuzzo.42.fr --title=$TITLE --admin_user=$WP_ADMIN --admin_password=$WP_ADMINPASS --admin_email=$WP_ADMINMAIL --allow-root
./wp-cli.phar user create $WP_USER $WP_USERMAIL --user_pass=$WP_USERPASS --role=author --allow-root --path='/var/www/html'

exec "$@"