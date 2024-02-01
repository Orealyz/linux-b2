#!/bin/bash

if [[ $(id -u) -ne 0 ]]; then
  echo "nop"
  exit 1
fi

dnf update -y
dnf install -y ansible python

useradd -m -s /bin/bash ansible_user
usermod -aG wheel ansible_user
echo "ansible_user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ansible_user

if [ ! -f id_rsa.pub ]; then
  ssh-keygen -t rsa -b 2048 -f id_rsa -N ""
fi

mkdir -p /home/ansible_user/.ssh
cp id_rsa.pub /home/ansible_user/.ssh/authorized_keys
chown -R ansible_user:ansible_user /home/ansible_user/.ssh
chmod 700 /home/ansible_user/.ssh
chmod 600 /home/ansible_user/.ssh/authorized_keys
