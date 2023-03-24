FROM alpine:3.16

RUN apk update && \
    apk add --no-cache nginx git && \
    mkdir -p /var/www && \
    git clone https://github.com/web-n/web2css.git /var/www/site && \
    rm -rf /var/www/site/.git /etc/nginx/http.d/default.conf
    

COPY conf/nginx.conf /etc/nginx/http.d/

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]
