#!/bin/sh

if [ ! -d "/var/run/vsftpd/empty" ]; then
     touch /etc/vsftpd.chroot_list;
     echo rajae | tee -a /etc/vsftpd.chroot_list
     useradd rajae;
     echo "rajae:rajae" | chpasswd
     usermod -d /wordPress_db rajae
     usermod -aG www-data rajae
     mkdir -p /var/run/vsftpd
     mkdir -p /var/run/vsftpd/empty
     # chmod 755 /var
     # chmod 755 /var/run
     # chmod 755 /var/run/vsftpd
     # chmod 755 /var/run/vsftpd/empty
     mkdir -p /wordPress_db
     chmod 755 /wordPress_db
     echo "Creat Dir successfuly"
fi

echo "finish script";

exec "$@"