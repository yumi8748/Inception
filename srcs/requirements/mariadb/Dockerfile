FROM debian:buster

RUN apt-get update && apt-get install -y mariadb-server

RUN echo 'root:vagrant' | chpasswd

COPY ./tools/50-server.cnf /etc/mysql/mariadb.conf.d/.

COPY ./tools/script.sh /

CMD ["/script.sh"]