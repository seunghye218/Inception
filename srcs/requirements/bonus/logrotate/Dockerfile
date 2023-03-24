FROM    alpine:3.16

RUN apk update && apk add --no-cache logrotate shadow && \
    mkdir -p /var/log/mysql/ && \
    echo "" | useradd mysql && \
    chown mysql:mysql /var/log/mysql/ /var/lib/ && \
    chmod 0775 /var/log/mysql/ /var/lib/
    
COPY    conf/mariadb /etc/logrotate.d/mariadb
COPY    tools/logrotate_script.sh .

ENTRYPOINT  ["sh", "logrotate_script.sh"]
