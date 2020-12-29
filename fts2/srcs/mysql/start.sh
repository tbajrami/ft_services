#!/bin/sh

mkdir -p /run/mysqld

mariadb-install-db -u root

mysqld -u root & sleep 5

mysql -u root --execute="CREATE DATABASE wordpress;"
mysql -u root wordpress < wordpress.sql
mysql -u root --execute="CREATE USER 'wordpress'@'%';"
mysql -u root --execute="SET password FOR 'wordpress'@'%' = password('password');"
mysql -u root --execute="GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'%' IDENTIFIED BY 'password';"
mysql -u root --execute="FLUSH PRIVILEGES;"

telegraf