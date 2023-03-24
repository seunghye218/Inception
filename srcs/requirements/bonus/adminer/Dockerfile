FROM alpine:3.16

ARG PHP_VERSION=8

RUN apk update && \
    apk add --no-cache \
    curl \
    php${PHP_VERSION} \
    php${PHP_VERSION}-session \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-mysqli &&\
    sed -i "s|.*listen = 127.0.0.1.*|listen = 8000|g" \
    /etc/php${PHP_VERSION}/php-fpm.d/www.conf

COPY tools/adminer_script.sh .

ENTRYPOINT ["sh", "adminer_script.sh"]
