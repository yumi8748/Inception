FROM debian:buster

RUN apt update && apt upgrade && apt install -y mariadb-server

RUN echo 'root:vagrant' | chpasswd

COPY ./tools/50-server.cnf /etc/mysql/mariadb.conf.d/.

COPY ./tools/script.sh /

RUN mkdir /run/mysqld

CMD ["mysqld"]