FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server && \
    apt-get clean

EXPOSE 3306

RUN chown -R mysql:mysql /var/lib/mysql && \
    mkdir -p /run/mysql && \
    chown -R mysql:mysql /run/mysql && \
    chmod 755 /run/mysql

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/.

COPY ./tools/script.sh /

RUN chmod +x /script.sh

CMD [ "./script.sh" ]

#CMD ["mysqld_safe", "--bind-address=0.0.0.0"]