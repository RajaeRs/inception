#!/bin/sh

FTP_USER_PASS=$(cat $FILE_PATH_FTP_PASS)

if [ ! -d "/var/run/vsftpd/empty" ]; then
     touch /etc/vsftpd.chroot_list;
     echo ${FTP_USER_NAME} | tee -a /etc/vsftpd.chroot_list
     useradd ${FTP_USER_NAME};
     echo "${FTP_USER_NAME}:${FTP_USER_PASS}" | chpasswd
     usermod -d /wordPress_db ${FTP_USER_NAME}
     usermod -aG www-data ${FTP_USER_NAME}
     mkdir -p /var/run/vsftpd
     mkdir -p /var/run/vsftpd/empty
     mkdir -p /wordPress_db
     chmod 755 /wordPress_db
     echo "Set up User Access successfuly"
fi

echo "finish script";

exec "$@"