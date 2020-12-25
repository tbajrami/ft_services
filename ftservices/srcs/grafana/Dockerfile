FROM alpine

RUN apk update && apk add --no-cache --upgrade bash \
&& apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main libc6-compat

RUN wget https://dl.grafana.com/oss/release/grafana-7.3.6.linux-amd64.tar.gz
RUN tar -xzvf grafana-7.3.6.linux-amd64.tar.gz

COPY start.sh .
RUN chmod +x ./start.sh

EXPOSE 3000

ENTRYPOINT sh start.sh