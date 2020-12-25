FROM alpine

RUN apk update && \
	apk add nginx && \
	mkdir -p /var/run/nginx && \
	apk add openssl && \
    rm -rf /var/cache/apk/*

RUN mkdir /www
COPY ./index.html /www

RUN yes "" | openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.crt

RUN rm /etc/nginx/conf.d/default.conf
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

COPY ./start.sh .
RUN chmod +x ./start.sh

EXPOSE 80 443
CMD ./start.sh