FROM alpine:3.17

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
  { echo '[mariadb]'; \
  echo 'log_error=/var/log/mysql/mariadb.err'; \
  echo 'general_log'; \
  echo 'general_log_file=/var/log/mysql/mariadb.log'; \
  echo 'slow_query_log'; \
  echo 'slow_query_log_file=/var/log/mysql/mariadb-slow.log'; \
  echo 'long_query_time=5'; \
  } | tee  /etc/my.cnf && \
  mkdir /var/log/mysql/ && \
  chown -R mysql:mysql /var/lib/mysql /run/mysqld /var/log/mysql/ && \
  chmod 0775 /var/log/mysql/

EXPOSE 3306

COPY tools/mariadb_script.sh .
COPY tools/mariadb_healthcheck.sh .
USER mysql

ENTRYPOINT [ "sh", "mariadb_script.sh"]

HEALTHCHECK --interval=6s --timeout=5s --start-period=1s --retries=5 \
  CMD ["sh", "mariadb_healthcheck.sh"]
