FROM alpine:3.16

ARG DB_NAME
ARG DB_USER
ARG DB_PASS
ARG DB_ROOT

RUN apk update && apk add --no-cache mariadb mariadb-client && \
    mkdir -p /var/run/mysqld && \
    { echo '[mysqld]'; \
      echo 'skip-host-cache'; \
      echo 'skip-name-resolve'; \
      echo 'bind-address=0.0.0.0'; \
    } | tee  /etc/my.cnf.d/docker.cnf && \
    sed -i "s|skip-networking|skip-networking=0|g" /etc/my.cnf.d/mariadb-server.cnf && \
    mysql_install_db --user=mysql --datadir=/var/lib/mysql --auth-root-authentication-method=normal && \
    chown -R mysql:mysql /var/lib/mysql /run/mysqld

EXPOSE 3306

COPY tools/create_db.sh .
COPY tools/mariadb_healthcheck.sh .
USER mysql

ENTRYPOINT [ "sh", "mariadb_script.sh"]

HEALTHCHECK --interval=5s --timeout=3s --start-period=1s --retries=5 \
CMD ["sh", "mariadb_healthcheck.sh"]
