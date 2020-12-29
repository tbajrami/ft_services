FROM alpine

RUN apk add --update mysql mysql-client && rm -f /var/cache/apk/*

RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.15.2_linux_amd64.tar.gz \
&& tar -zxf telegraf-1.15.2_linux_amd64.tar.gz \
&& mv telegraf-1.15.2 telegraf \
&& rm telegraf-1.15.2_linux_amd64.tar.gz
RUN cp -rf telegraf/etc/* /etc/
RUN cp -rf telegraf/usr/* /usr/
COPY ./telegraf.conf /etc/telegraf/telegraf.conf
RUN apk add openrc
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

COPY start.sh /start.sh
COPY livenessprobe.sh /livenessprobe.sh
COPY wordpress.sql /wordpress.sql
RUN chmod +x /start.sh
RUN chmod +x /livenessprobe.sh
COPY my.cnf /etc/

EXPOSE 3306

ENTRYPOINT sh start.sh