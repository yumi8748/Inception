#!/bin/bash

/etc/init.d/mariadb start

sleep 5

#mysql_secure_installation << EOF
#$DB_ROOTPASS
#Y
#n
#Y
#n
#Y
#Y
#EOF


# echo "CREATING DATABASE"
mysql -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;"
# echo "CREATING USER"
mysql -e "CREATE USER IF NOT EXISTS \`${DB_USER}\`@'localhost' IDENTIFIED BY '${DB_PWD}';"
# echo "GRANTING PRIVILEGES"
mysql -e "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO \`${DB_USER}\`@'%' IDENTIFIED BY '${DB_PWD}';"
# echo "FLUSHING"
mysql -e "FLUSH PRIVILEGES;"
# echo "ALTERING USER"
# mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_USERPASS}';"

/etc/init.d/mariadb stop

exec mysqld_safe --bind-address=0.0.0.0