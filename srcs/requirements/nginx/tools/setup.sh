#!/bin/sh

# Path to SSL certificates
SSL_KEY="/etc/nginx/ssl/nginx.key"
SSL_CERT="/etc/nginx/ssl/nginx.crt"

# Generate SSL certificates if they don't exist
if [ ! -f "$SSL_KEY" ] || [ ! -f "$SSL_CERT" ]; then
    echo "Generating self-signed SSL certificate..."
    mkdir -p /etc/nginx/ssl
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout "$SSL_KEY" \
        -out "$SSL_CERT" \
        -subj "/C=US/ST=State/L=City/O=Organization/OU=Unit/CN=${DOMAIN_NAME}"
fi

# Test NGINX configuration
nginx -t || exit 1

# Start NGINX
echo "Starting NGINX..."
nginx -g "daemon off;"
