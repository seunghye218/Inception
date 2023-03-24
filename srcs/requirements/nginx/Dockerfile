FROM alpine:3.16

RUN apk update && \
    apk add --no-cache nginx openssl && \
    mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/seunghye.42.fr.key -out /etc/nginx/ssl/seunghye.42.fr.crt -subj "/C=KR/ST=Seoul/O=42/OU=42Seoul/CN=localhost" && \
    rm -rf /etc/nginx/conf.d/default.conf

COPY conf/nginx.conf /etc/nginx/http.d/

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]
