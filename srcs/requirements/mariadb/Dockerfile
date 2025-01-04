FROM alpine:3.18

RUN apk add --no-cache mariadb mariadb-client \
    && mkdir -p /run/mysqld \
    && chown -R mysql:mysql /run/mysqld /var/lib/mysql

COPY conf/my.cnf /etc/my.cnf.d/

CMD ["mysqld"]