#!/bin/sh

mkdir -p /run/mysqld

mariadb-install-db -u root

# Invoking "mysqld" will start the MySQL server. Terminating "mysqld" will shutdown the MySQL server.
mysqld -u root & sleep 5



# Create Wordpress database.
mysql -u root --execute="CREATE DATABASE wordpress;"
mysql -u root wordpress < wordpress.sql
mysql -u root --execute="CREATE USER 'wordpress'@'%';"
mysql -u root --execute="SET password FOR 'wordpress'@'%' = password('password');"
mysql -u root --execute="GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'%' IDENTIFIED BY 'password';"
mysql -u root --execute="FLUSH PRIVILEGES;"

# Start Telegraf and sleep infinity for avoid container to stop.
sleep infinite