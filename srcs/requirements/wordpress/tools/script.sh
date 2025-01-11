#!/bin/sh
cd /var/www/html

sleep 10

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar

# 检查WordPress是否已经安装
if [ ! -f /var/www/html/wp-config.php ]; then
    ./wp-cli.phar core download --allow-root --path=/var/www/html
    ./wp-cli.phar config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PWD --dbhost=mariadb --allow-root
    ./wp-cli.phar core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_LOGIN --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --allow-root
    ./wp-cli.phar user create $WP_USER_LOGIN $WP_USER_EMAIL --user_pass=$WP_USER_PWD --role=author --allow-root --path='/var/www/html'
else
    echo "WordPress already installed, skipping setup."
fi

exec "$@"