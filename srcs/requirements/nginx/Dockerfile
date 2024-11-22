# NGINX Dockerfile
FROM alpine:3.16

# Install NGINX and OpenSSL
RUN apk add --no-cache nginx openssl

# Create necessary directories
RUN mkdir -p /etc/nginx/conf.d /etc/nginx/ssl /var/www/html

# Copy configuration and certificates
COPY conf/default.conf /etc/nginx/conf.d/default.conf
COPY ssl/nginx.crt /etc/nginx/ssl/nginx.crt
COPY ssl/nginx.key /etc/nginx/ssl/nginx.key

# Expose port 443 for HTTPS
EXPOSE 443

# Copy setup script
COPY tools/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

# Start NGINX using the setup script
CMD ["setup.sh"]
