FROM debian:bullseye

RUN apt-get update && \
	apt-get purge -y apache2 && \
	apt-get autoremove -y && \
	apt-get install -y \
	php7.4-fpm \
	php7.4-mysqli \
	curl \
	&& mkdir -p /run/php \
	&& chown -R www-data:www-data /run/php \
	&& rm -rf /var/lib/apt/lists/*

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/.

COPY tools/script.sh /usr/local/bin/script.sh

RUN chmod +x /usr/local/bin/script.sh

RUN	mkdir -p /var/www/html && \
	chmod -R 777 /var/www/html && \
	chown -R www-data:www-data /var/www/html

WORKDIR	/var/www/html/

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/script.sh"]

CMD	["php-fpm7.4", "-F"]