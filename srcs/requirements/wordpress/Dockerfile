FROM debian:bullseye

RUN apt-get update && apt-get install -y \
	php7.4-fpm \
	php7.4-mysqli \
	curl \
	&& mkdir -p /run/php \
	&& chown -R www-data:www-data /run/php

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/.

COPY tools/script.sh .

RUN chmod +x script.sh

EXPOSE 9000

ENTRYPOINT ["./script.sh"]

CMD	["php-fpm7.4", "-F"]