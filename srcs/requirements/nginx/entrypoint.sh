#!/bin/bash

# Ensure the default server configuration is in place
if [ ! -f /etc/nginx/sites-available/default ]; then
    cp /tmp/default /etc/nginx/sites-available/default
fi

# Ensure the nginx.conf is in place
if [ ! -f /etc/nginx/nginx.conf ]; then
    cp /tmp/nginx.conf /etc/nginx/nginx.conf
fi

# Create a symlink to enable the default site
if [ ! -f /etc/nginx/sites-enabled/default ]; then
    ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
fi

# Execute the CMD passed to the container
exec "$@"
