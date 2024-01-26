#!/bin/bash

if [[ $(id -u) -ne 0 ]] ; then
  echo "nop"
  exit 1
fi

# fw handling
systemctl enable firewalld
systemctl start firewalld
firewall-cmd --zone=public --remove-service=dhcpv6-client
firewall-cmd --zone=public --remove-service=cockpit
firewall-cmd --zone=public --remove-service=ssh
firewall-cmd --zone=public --add-service=ssh
firewall-cmd --zone=public --add-service=http
firewall-cmd --zone=public --add-port=3306/tcp
firewall-cmd --runtime-to-permanent
firewall-cmd --reload

#mariaDB
dnf install -y mariadb-server
systemctl enable --now mariadb

echo -e "\n[mysqld]" >> /etc/my.cnf.d/mariadb-server.cnf
echo "server-id=1" >> /etc/my.cnf.d/mariadb-server.cnf
echo "log-bin=mysql-bin" >> /etc/my.cnf.d/mariadb-server.cnf

mysql -u root <<EOF
CREATE DATABASE app_nulle;
CREATE USER 'db1'@'10.5.1.11' IDENTIFIED BY 'db1';
GRANT ALL PRIVILEGES ON app_nulle.* TO 'db1'@'10.5.1.11';
FLUSH PRIVILEGES;
CREATE USER 'db1'@'10.5.1.12' IDENTIFIED BY 'db1';
GRANT ALL PRIVILEGES ON app_nulle.* TO 'db1'@'10.5.1.12';
FLUSH PRIVILEGES;
CREATE USER 'db1'@'10.5.1.13' IDENTIFIED BY 'db1';
GRANT ALL PRIVILEGES ON app_nulle.* TO 'db1'@'10.5.1.13';
FLUSH PRIVILEGES;

USE app_nulle;

CREATE TABLE meo
  (
     id    INT NOT NULL AUTO_INCREMENT,
     name  VARCHAR(255) NOT NULL,
     email VARCHAR(255) NOT NULL,
     PRIMARY KEY (id)
  );
CREATE USER 'db2'@'10.5.1.212' IDENTIFIED BY 'db2';
GRANT REPLICATION SLAVE ON *.* TO 'db2'@'10.5.1.212';
FLUSH PRIVILEGES;
FLUSH TABLES WITH READ LOCK;
EOF

systemctl restart mariadb
