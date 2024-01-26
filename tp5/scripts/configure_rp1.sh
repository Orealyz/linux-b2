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
firewall-cmd --runtime-to-permanent
firewall-cmd --reload

#nginx
dnf install -y nginx
systemctl enable --now nginx

#rp
cd /etc/nginx/conf.d/
tee "app_nulle.conf" > /dev/null <<EOF
upstream app_nulle_servers {
    server web1.tp5.b2:80;
    server web2.tp5.b2:80;
    server web3.tp5.b2:80;
}

server {
    listen 80;
    server_name app_nulle.tp5.b2;

    location / {
	proxy_pass http://app_nulle_servers;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF
setenforce 0
systemctl restart nginx

#keepalived
dnf install -y keepalived
systemctl enable --now keepalived

echo "" > /etc/keepalived/keepalived.conf

tee -a /etc/keepalived/keepalived.conf > /dev/null <<EOF
vrrp_instance VI_1 {
    state MASTER
    interface eth2
    virtual_router_id 51
    priority 100
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass 1111
    }
    virtual_ipaddress {
        10.5.1.110
    }
}
EOF
systemctl restart keepalived
