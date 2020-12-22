FROM alpine


RUN apk update && apk add wget && mkdir /www \
&& apk add curl php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session

RUN wget https://wordpress.org/latest.tar.gz \
&& tar -xvf latest.tar.gz \
&& mv wordpress/* /www \
&& rm -rf /var/cache/apk/

COPY start.sh .
RUN chmod +x /start.sh
COPY config.php /www/config.php

EXPOSE 5050

ENTRYPOINT sh start.sh