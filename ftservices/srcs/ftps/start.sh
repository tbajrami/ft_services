mkdir -p /var/ftp

adduser -D -h /var/ftp user42
telegraf &
vsftpd /etc/vsftpd/vsftpd.conf