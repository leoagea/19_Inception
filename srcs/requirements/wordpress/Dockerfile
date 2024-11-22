# WordPress Dockerfile
FROM alpine:3.16

# Install dependencies
RUN apk add --no-cache php php-fpm php-mysqli curl wget tar

# Create WordPress directory
RUN mkdir -p /var/www/html

# Download and unpack WordPress
RUN wget https://wordpress.org/latest.tar.gz -O /tmp/wordpress.tar.gz && \
    tar -xzvf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1 && \
    rm /tmp/wordpress.tar.gz

# Copy the WordPress configuration template
COPY conf/wp-config.php /var/www/html/wp-config.php

# Copy setup script
COPY tools/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

# Expose php-fpm port
EXPOSE 9000

# Entrypoint for setup and php-fpm
CMD ["setup.sh"]
