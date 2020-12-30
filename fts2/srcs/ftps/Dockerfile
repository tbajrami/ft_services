FROM alpine

RUN apk upgrade && apk add vsftpd openssl openrc curl

COPY vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY start.sh ./start.sh
RUN chmod +x ./start.sh

RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.15.2_linux_amd64.tar.gz \
&& tar -zxf telegraf-1.15.2_linux_amd64.tar.gz \
&& mv telegraf-1.15.2 telegraf \
&& rm telegraf-1.15.2_linux_amd64.tar.gz
RUN cp -rf telegraf/etc/* /etc/
RUN cp -rf telegraf/usr/* /usr/
COPY ./telegraf.conf /etc/telegraf/telegraf.conf
RUN apk add openrc
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

RUN yes "" | openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/certs/vsftpd.key -out /etc/ssl/certs/vsftpd.crt

EXPOSE 20 21 21000

ENTRYPOINT sh start.sh