FROM alpine


RUN apk update && apk add wget && mkdir /www \
&& apk add php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session


COPY start.sh .
COPY wordpress.tar.gz .
RUN chmod +x /start.sh
COPY config.php /www/config.php

ENTRYPOINT sh start.sh