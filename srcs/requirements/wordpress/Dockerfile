FROM alpine:3.16

ARG PHP_VERSION=8
ARG DB_NAME
ARG DB_USER
ARG DB_PASS
ARG REDIS_HOST
ARG REDIS_DATABASE
ARG REDIS_MAXTTL
ARG REDIS_TIMEOUT
ARG REDIS_READ_TIMEOUT

RUN apk update && apk add --no-cache \
    php${PHP_VERSION} \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-mysqli \
    php${PHP_VERSION}-json \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-dom \
    php${PHP_VERSION}-exif \
    php${PHP_VERSION}-fileinfo \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-openssl \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-zip \
    php${PHP_VERSION}-redis \
    php${PHP_VERSION}-phar && \
    sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" \
      /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
    sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" \
      /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = nobody|g" \
      /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/bin/wp

COPY tools/wp_script.sh .
COPY tools/wp_healthcheck.sh .

ENTRYPOINT [ "sh", "wp_script.sh" ]

HEALTHCHECK --interval=12s --timeout=3s --start-period=1s --retries=5 \
CMD ["sh", "wp_healthcheck.sh"]
