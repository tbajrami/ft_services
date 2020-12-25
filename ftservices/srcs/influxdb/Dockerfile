FROM alpine

RUN apk update && apk add influxdb

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8086

ENTRYPOINT ./start.sh