FROM alpine

RUN apk update
RUN apk add openrc --no-cache
RUN apk add nginx openssh openssl openssh-server

RUN adduser -D -g 'www' www

RUN mkdir /www
RUN chown -R www:www /var/lib/nginx
RUN chown -R www:www /www
RUN mkdir -p /run/nginx

COPY index.html /www/
COPY nginx.conf /etc/nginx/
RUN yes "" | openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.crt
COPY start.sh ./start.sh
RUN chmod +x /start.sh

EXPOSE 80 443

ENTRYPOINT sh start.sh