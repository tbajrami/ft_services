FROM alpine

RUN apk add --update mysql mysql-client && rm -f /var/cache/apk/*

COPY start.sh /start.sh
COPY wordpress.sql /wordpress.sql
RUN chmod +x /start.sh
COPY my.cnf /etc/

EXPOSE 3306

ENTRYPOINT sh start.sh