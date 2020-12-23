mysql_install_db --user=root

mysql -u root <<SQL_CMDS
        CREATE DATABASE wordpress;
        CREATE USER 'wordpress'@'localhost';
        SET password FOR 'wordpress'@'localhost' = password('password');
        GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost' IDENTIFIED BY 'password';
        FLUSH PRIVILEGES;
SQL_CMDS

tail -f /dev/null