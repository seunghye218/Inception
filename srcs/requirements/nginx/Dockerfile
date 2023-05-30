FROM alpine:3.17

RUN apk update && apk add --no-cache nginx && \
    rm -rf /etc/nginx/conf.d/default.conf
    
RUN apk update && apk add --no-cache openssl && \
    mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/seunghye.42.fr.key -out /etc/nginx/ssl/seunghye.42.fr.crt -subj "/C=KR/ST=Seoul/O=42/OU=42Seoul/CN=localhost"

COPY conf/nginx.conf /etc/nginx/http.d/

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]
