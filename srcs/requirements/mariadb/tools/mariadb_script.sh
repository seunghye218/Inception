#!/bin/sh

#if [ ! -d "/var/lib/mysql/mysql" ];
#then
#    mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm

#    tfile=`mktemp`
#    if [ ! -f "$tfile" ]; then
#            return 1
#    fi
#fi

if [ ! -d "/var/log/mysql/archive" ];
then
    mkdir /var/log/mysql/archive/ 
    chown mysql:mysql /var/log/mysql/archive/ 
    chmod 0775 /var/log/mysql/archive/
fi

if [ ! -d "/var/lib/mysql/wordpress" ];
then
        cat << EOF > /tmp/create_db.sql
USE mysql;
FLUSH PRIVILEGES;
-- DROP DATABASE test;
-- DELETE FROM mysql.db WHERE Db='test';
DELETE FROM     mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT}';
CREATE DATABASE ${DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '${DB_USER}'@'%' IDENTIFIED by '${DB_PASS}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF
    /usr/bin/mysqld --user=mysql --bootstrap < /tmp/create_db.sql
    rm -f /tmp/create_db.sql
    pkill mariadb
fi

exec    /usr/bin/mysqld_safe

