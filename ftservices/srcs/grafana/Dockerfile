FROM alpine

RUN apk update && apk add --no-cache --upgrade bash \
&& apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main libc6-compat

RUN wget https://dl.grafana.com/oss/release/grafana-7.3.6.linux-amd64.tar.gz
RUN tar -xzvf grafana-7.3.6.linux-amd64.tar.gz

RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.15.2_linux_amd64.tar.gz \
&& tar -zxf telegraf-1.15.2_linux_amd64.tar.gz \
&& mv telegraf-1.15.2 telegraf \
&& rm telegraf-1.15.2_linux_amd64.tar.gz
RUN cp -rf telegraf/etc/* /etc/
RUN cp -rf telegraf/usr/* /usr/
COPY ./telegraf.conf /etc/telegraf/telegraf.conf
RUN apk add openrc

COPY grafana.db ./grafana-7.3.6/data/grafana.db
# COPY dashboard.yaml ./grafana-7.3.6/conf/provisioning/dashboards
# COPY datasources.yaml ./grafana-7.3.6/conf/provisioning/datasources
# COPY custom.ini ./grafana-7.3.6/conf
# COPY dashboards/ ./grafana-7.3.6/public/dashboards
COPY start.sh .
RUN chmod +x ./start.sh

EXPOSE 3000

ENTRYPOINT sh start.sh