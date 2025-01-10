FROM debian:buster

RUN apt update && apt upgrade && apt install -y nginx

RUN apt install -y openssl

RUN mkdir -p /etc/nginx/ssl

RUN chmod 777 /etc/nginx/ssl

RUN openssl req -x509 -nodes \
 -keyout /etc/ssl/private/nginx-selfsigned.key \
 -out $CERTS_ \
 -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=42/CN=yu-chen.42.fr\UID=yu-chen"

COPY default /etc/nginx/sites-available/.

COPY ./conf/nginx.conf /etc/nginx/.

CMD [ "nginx", "-g", "daemon off;" ]
