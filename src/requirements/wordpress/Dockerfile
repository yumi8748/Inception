FROM alpine:3.18

RUN apk add --no-cache php php-fpm php-mysqli

COPY conf/wp-config.php /var/www/wordpress/

CMD ["php-fpm", "--nodaemonize"]