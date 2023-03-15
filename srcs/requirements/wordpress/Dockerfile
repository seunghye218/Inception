FROM alpine:3.16
ARG PHP_VERSION=8 \
    DB_NAME \
    DB_USER \
    DB_PASS
RUN apk update && apk upgrade && apk add --no-cache \
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
    php${PHP_VERSION}-phar \
    unzip && \
    sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" \
      /etc/php8/php-fpm.d/www.conf && \
    sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" \
      /etc/php8/php-fpm.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = nobody|g" \
      /etc/php8/php-fpm.d/www.conf && \
    rm -f /var/cache/apk/* && \
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/bin/wp && \
    wp core download --locale=ko_KR --path=/var/www/

COPY tools/wp-config-create.sh .
COPY tools/wordpress_healthcheck.sh .

ENTRYPOINT [ "sh", "wp-config-create.sh" ]

HEALTHCHECK --interval=10s --timeout=3s \
CMD ["sh", "wordpress_healthcheck.sh"]




#FROM alpine:3.16
#ARG PHP_VERSION=8 \
#    DB_NAME \
#    DB_USER \
#    DB_PASS
#RUN apk update && apk upgrade && apk add --no-cache \
#    php${PHP_VERSION} \
#    php${PHP_VERSION}-fpm \
#    php${PHP_VERSION}-mysqli \
#    php${PHP_VERSION}-json \
#    php${PHP_VERSION}-curl \
#    php${PHP_VERSION}-dom \
#    php${PHP_VERSION}-exif \
#    php${PHP_VERSION}-fileinfo \
#    php${PHP_VERSION}-mbstring \
#    php${PHP_VERSION}-openssl \
#    php${PHP_VERSION}-xml \
#    php${PHP_VERSION}-zip \
#    php${PHP_VERSION}-redis \
#    #wget \
#curl \
##sudo \
#    unzip && \
#    #sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" \
#    #  /etc/php8/php-fpm.d/www.conf && \
#    #sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" \
#    #  /etc/php8/php-fpm.d/www.conf && \
#    #sed -i "s|;listen.group = nobody|listen.group = nobody|g" \
#    #  /etc/php8/php-fpm.d/www.conf && \
#mkdir -p /var/www/wordpress && \
##curl -s -L https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar --output /usr/bin/wp && \
##chmod +x /usr/bin/wp && \
#    rm -f /var/cache/apk/* && \ 
#wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/bin/wp

##wp core download --version=5.8.1 --path=/var/www/wordpress && \
##WORKDIR /var/www
##RUN wget https://wordpress.org/latest.zip && \
##    unzip latest.zip && \
##    cp -rf wordpress/* . && \
##    rm -rf wordpress latest.zip

#COPY ./requirements/wordpress/tools/wp-config-create.sh .
##COPY tools/wp-config-create.sh .
##RUN sh wp-config-create.sh && rm wp-config-create.sh && \
#    #chmod -R 0777 wp-content/
##CMD ["/usr/sbin/php-fpm8", "-F"]
##HEALTHCHECK \
#CMD [ "sh", "wp-config-create.sh"]