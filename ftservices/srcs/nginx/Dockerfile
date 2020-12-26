FROM alpine

RUN apk update && \
	apk add nginx && \
	mkdir -p /var/run/nginx && \
	apk add openssl && \
    rm -rf /var/cache/apk/*

RUN mkdir /www
COPY ./index.html /www

RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.15.2_linux_amd64.tar.gz \
&& tar -zxf telegraf-1.15.2_linux_amd64.tar.gz \
&& mv telegraf-1.15.2 telegraf \
&& rm telegraf-1.15.2_linux_amd64.tar.gz
RUN cp -rf telegraf/etc/* /etc/
RUN cp -rf telegraf/usr/* /usr/
COPY ./telegraf.conf /etc/telegraf/telegraf.conf
RUN apk add openrc
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

RUN yes "" | openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.crt

RUN rm /etc/nginx/conf.d/default.conf
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

COPY ./start.sh .
RUN chmod +x ./start.sh

EXPOSE 80 443
CMD ./start.sh