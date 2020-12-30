mkdir -p /var/ftp

mkdir -p srcs/ftp/user
echo -e "password\npassword" | adduser -h /srcs/ftp/user user
chown user:user /srcs/ftp/user
mkdir /srcs/ftp/user/folder_text
chown user:user /srcs/ftp/user/folder_text
touch /srcs/ftp/user/folder_text/text.txt

telegraf &
vsftpd /etc/vsftpd/vsftpd.conf