#!/bin/sh

# Ensure the MySQL data directory exists
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null

    echo "Starting temporary MariaDB server..."
    mysqld --user=mysql --skip-networking --datadir=/var/lib/mysql &
    pid="$!"

    echo "Applying initialization script..."
    mysql -uroot < /docker-entrypoint-initdb.d/init.sql

    echo "Shutting down temporary MariaDB server..."
    kill -s TERM "$pid"
    wait "$pid"
fi

echo "Starting MariaDB server..."
exec mysqld --user=mysql --datadir=/var/lib/mysql
