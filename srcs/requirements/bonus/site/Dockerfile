FROM alpine:3.17

RUN apk update && apk add --no-cache nginx && \
    rm -rf /etc/nginx/conf.d/default.conf

RUN mkdir -p /var/www 

COPY tools/site /var/www/site
COPY conf/nginx.conf /etc/nginx/http.d/

EXPOSE 4242

ENTRYPOINT ["nginx", "-g", "daemon off;"]
