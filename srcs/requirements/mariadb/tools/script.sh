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

# Set root password for MariaDB (ensure it's consistent)
#echo "=> Setting root password..."
#mysql -u root --execute="SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$DB1_PWD');"

# Configure database and user
echo "=> Setting up database and user..."
cat <<EOF > /tmp/init.sql
CREATE DATABASE IF NOT EXISTS $DB1_NAME;
CREATE USER IF NOT EXISTS '$DB1_USER'@'%' IDENTIFIED BY '$DB1_PWD';
GRANT ALL PRIVILEGES ON $DB1_NAME.* TO '$DB1_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB1_PWD';
FLUSH PRIVILEGES;
EOF

# Execute the initialization SQL script(using root password)
echo "=> Executing SQL script..."
mysql -u root -p$DB1_PWD < /tmp/init.sql
rm /tmp/init.sql

echo "=> MariaDB initialization completed!"

# Keep the container running in the foreground
wait
