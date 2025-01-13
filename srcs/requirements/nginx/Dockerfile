FROM debian:bullseye

# Set environment variable to avoid interactive prompts during package installs
# ENV DEBIAN_FRONTEND=noninteractive


# Install necessary packages
RUN apt-get update \
    && apt-get install -y nginx openssl \
    && apt-get clean

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

# Ensure nginx is run in the foreground
CMD [ "nginx", "-g", "daemon off;" ]
