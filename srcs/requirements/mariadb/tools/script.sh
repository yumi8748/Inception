#!/bin/bash

# Check if MySQL data directory is already initialized
if [ ! -d /var/lib/mysql/mysql ]; then
    echo "=> Initializing database directory..."
    mysqld --initialize-insecure --user=mysql --datadir=/var/lib/mysql
fi

# Start MySQL service
echo "=> Starting MariaDB service..."
mysqld_safe --datadir=/var/lib/mysql &

# Wait for MySQL to start
echo "=> Waiting for MariaDB to start..."
while ! mysqladmin ping --silent; do
    sleep 1
done
sleep 5


# Set root password for MariaDB (ensure it's consistent)
#echo "=> Setting root password..."
#mysql -u root --execute="SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$DB_PWD');"

echo "=> Configuring root user..."
mysql -u root --skip-password <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PWD';
FLUSH PRIVILEGES;
EOF

# Configure database and user
echo "=> Setting up database and user..."
cat <<EOF > /tmp/init.sql
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PWD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
FLUSH PRIVILEGES;
EOF

# Execute the initialization SQL script(using root password)
echo "=> Executing SQL script..."
mysql -u root -p$DB_PWD < /tmp/init.sql
rm /tmp/init.sql

echo "=> MariaDB initialization completed!"

# Keep the container running in the foreground
wait
