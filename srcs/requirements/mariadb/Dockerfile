# MariaDB Dockerfile
FROM alpine:3.16

# Install MariaDB
RUN apk add --no-cache mariadb mariadb-client

# Create necessary directories
RUN mkdir -p /var/lib/mysql /run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql /run/mysqld

# Copy initialization script and setup script
COPY tools/init.sql /docker-entrypoint-initdb.d/
COPY tools/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

# Expose MariaDB default port
EXPOSE 3306

# Entrypoint to setup and run MariaDB
CMD ["setup.sh"]
