FROM alpine

RUN apk add --update mysql mysql-client

COPY start.sh ./start.sh
RUN chmod +x /start.sh

EXPOSE 3306

ENTRYPOINT sh start.sh