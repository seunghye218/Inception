#!/bin/sh

#이 스크립트는 /var/lib/mysql/mysql 디렉터리가 존재하는지 확인합니다. 존재하지 않으면 MySQL 데이터베이스가 초기화되지 않은 것으로 가정하고 초기화를 진행합니다.
#데이터베이스 초기화에는 mysql_install_db 명령이 사용됩니다. --basedir 옵션은 MySQL 설치 디렉터리를 지정하고, --datadir 옵션은 데이터베이스 파일이 저장될 디렉터리를 지정합니다. user 옵션은 MySQL 서버를 실행할 사용자를 지정하고, --rpm 옵션은 RPM 패키지에서 설치 중임을 나타냅니다.
#데이터베이스를 초기화한 후 스크립트는 mktemp 명령을 사용하여 임시 파일을 생성합니다. 파일을 만들 수 없는 경우 스크립트는 종료 코드 1과 함께 오류를 반환합니다.
#이 스크립트는 MySQL 서버에 대한 대규모 설치 또는 구성 프로세스의 일부일 가능성이 높습니다.

if [ ! -d "/var/lib/mysql/mysql" ]; then
        # init database
        mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm

        tfile=`mktemp`
        if [ ! -f "$tfile" ]; then
                return 1
        fi
fi

if [ ! -d "/var/lib/mysql/wordpress" ]; then

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
echo hello
        # run init.sql
        /usr/bin/mysqld --user=mysql --bootstrap < /tmp/create_db.sql
        rm -f /tmp/create_db.sql
        pkill mariadb
echo hi
#else
fi
        #/usr/bin/mysqld --skip-log-error
        #/usr/bin/mysqld
        /usr/bin/mysqld_safe
