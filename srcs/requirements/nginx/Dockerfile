FROM debian:bullseye

# Set environment variable to avoid interactive prompts during package installs
# ENV DEBIAN_FRONTEND=noninteractive


# Install necessary packages
RUN apt-get update \
    && apt-get install -y nginx openssl \
    && apt-get clean

# create working directory and set access and ownership to user
RUN	mkdir -p /var/www/html && \
	chmod -R 777 /var/www/html
#	chown -R www-data:www-data /var/www/html

# Create SSL directory and set permissions
RUN mkdir -p /etc/nginx/ssl && \
    chmod 777 /etc/nginx/ssl

RUN openssl req -x509 -nodes \
    -keyout /etc/nginx/ssl/nginx-selfsigned.key \
    -out /etc/nginx/ssl/nginx-selfsigned.crt \
    -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=42/CN=yu-chen.42.fr\UID=yu-chen"

# Copy configuration files
COPY conf/default /etc/nginx/sites-available/.
COPY conf/nginx.conf /etc/nginx/.

# Add the entrypoint script
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR	/var/www/html/

EXPOSE 443

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Ensure nginx is run in the foreground
CMD [ "nginx", "-g", "daemon off;" ]
