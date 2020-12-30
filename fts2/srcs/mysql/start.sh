#!/bin/sh

mkdir -p /run/mysqld

mariadb-install-db -u root

telegraf &
mysqld -u root & sleep 5

mysql -u root --execute="CREATE DATABASE IF NOT EXISTS wordpress;"
mysql -u root --execute="CREATE USER 'wordpress'@'%';"
mysql -u root --execute="SET password FOR 'wordpress'@'%' = password('password');"
mysql -u root --execute="GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'%' IDENTIFIED BY 'password';"
mysql -u root --execute="FLUSH PRIVILEGES;"


if [[ ! -f /var/lib/mysql/ex_db ]]
then
	touch /var/lib/mysql/ex_db
	echo lol >> /var/lib/mysql/huhu.txt
	mysql -u root wordpress < wordpress.sql
fi

tail -f /dev/null