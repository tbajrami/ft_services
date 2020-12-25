FROM alpine

RUN apk update && apk upgrade && apk add bash \
&& apk add curl php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session

RUN wget http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.2-all-languages.tar.gz
RUN tar -xzf phpMyAdmin-5.0.2-all-languages.tar.gz
RUN mv phpMyAdmin-5.0.2-all-languages phpmyadmin
RUN rm -rf /var/cache/apk/*

COPY config.inc.php /phpmyadmin/config.inc.php
RUN sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php7/php.ini

COPY start.sh .
RUN chmod +x start.sh

EXPOSE 5000

ENTRYPOINT sh start.sh