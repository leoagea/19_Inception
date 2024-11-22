#!/bin/sh

# Wait for MariaDB
echo "Waiting for MariaDB..."
while ! nc -z ${MYSQL_HOST} 3306; do
    sleep 1
done
echo "MariaDB is up!"

# Set permissions for WordPress files
chown -R www-data:www-data /var/www/html

# Start php-fpm
echo "Starting php-fpm..."
php-fpm --nodaemonize
