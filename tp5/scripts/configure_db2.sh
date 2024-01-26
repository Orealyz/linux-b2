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
echo "server-id=2" >> /etc/my.cnf.d/mariadb-server.cnf

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
CHANGE MASTER TO
MASTER_HOST='10.5.1.211',
MASTER_USER='db2',
MASTER_PASSWORD='db2',
MASTER_LOG_FILE='mysql-bin.000001',
MASTER_LOG_POS=328;
START SLAVE;
EOF

systemctl restart mariadb
