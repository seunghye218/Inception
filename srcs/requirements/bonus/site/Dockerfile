FROM alpine:3.17

RUN apk update && apk add --no-cache nginx && \
    rm -rf /etc/nginx/conf.d/default.conf

RUN apk update && apk add --no-cache git && \
    mkdir -p /var/www && \
    git clone https://github.com/web-n/web2css.git /var/www/site && \
    rm -rf /var/www/site/.git /etc/nginx/http.d/default.conf

COPY conf/nginx.conf /etc/nginx/http.d/

EXPOSE 4242

ENTRYPOINT ["nginx", "-g", "daemon off;"]
