# Partie 2 : HA

![THE server](./img/the_server.jpg)

## Sommaire

- [Partie 2 : HA](#partie-2--ha)
  - [Sommaire](#sommaire)
- [I. Scaling serveur web](#i-scaling-serveur-web)
  - [1. Serveurs Web additionnels](#1-serveurs-web-additionnels)
  - [2. Loadbalancing vers les serveurs Web](#2-loadbalancing-vers-les-serveurs-web)
- [II. Scaling reverse proxy](#ii-scaling-reverse-proxy)
  - [0. Intro](#0-intro)
  - [1. Reverse proxy additionnel](#1-reverse-proxy-additionnel)
  - [2. Keepalived](#2-keepalived)
- [III. Scaling DB](#iii-scaling-db)
  - [0. Intro blablaaaa](#0-intro-blablaaaa)
  - [1. DB additionnelle](#1-db-additionnelle)
  - [2. Conf master slave](#2-conf-master-slave)

# I. Scaling serveur web

## 2. Loadbalancing vers les serveurs Web

🌞 **Modifier le fichier de conf dédié au reverse-proxy**



```nginx
# on crée un groupe de serveurs avec la clause 'upstream'
upstream app_nulle_servers {
    server web1.tp5.b2:80;
    server web2.tp5.b2:80;
    server web3.tp5.b2:80;
}

server {
    [...]
    # on proxy_pass vers ce groupe de serveurs
    proxy_pass http://app_nulle_servers;
    [...]
}
```


🌞 **Vous pouvez reload NGINX pour que votre conf prenne effet**

🌞 **Visitez l'app web depuis votre navigateur** (toujours avec `http://app_nulle.tp5.b2`)



```
 ~/D/2/l/tp5   main ±  curl http://app_nulle.tp5.b2

<html>
<body>

  <h2>Insert user</h2>
  <form action="submit.php" method="post">
    Name: <input type="text" name="name"><br>
    E-mail: <input type="text" name="email"><br>
    <input type="submit">
  </form>
  
  <h2>Get user</h2>
    <form action="get.php" method="post">
    Name: <input type="text" name="name"><br>
    <input type="submit">
  </form>

</body>
</html>


```


➜ **Pour suivre l'arrivée des logs en temps réel**

```

[vagrant@web3 ~]$ sudo docker logs 00 -f

10.5.1.111 - - [25/Jan/2024:15:10:33 +0000] "GET / HTTP/1.0" 200 419 "-" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"

```

```
[vagrant@web2 php]$ sudo docker logs 14

10.5.1.111 - - [25/Jan/2024:15:10:22 +0000] "GET / HTTP/1.0" 200 419 "-" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"

```

```
[vagrant@web1 vagrant]$ sudo docker logs 13

10.5.1.111 - - [25/Jan/2024:15:14:17 +0000] "GET / HTTP/1.0" 200 419 "-" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"

```

# II. Scaling reverse proxy

## 0. Intro

## 1. Reverse proxy additionnel

## 2. Keepalived

🌞 **Installez Keepalived sur les deux serveurs reverse proxy**

🌞 **J'ai dit de tester que ça marchait**

Les deux serveurs sont actifs, rp1 est bien "MASTER"
```
[vagrant@rp1 ~]$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:cb:b3:b6 brd ff:ff:ff:ff:ff:ff
    altname enp0s3
    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic noprefixroute eth0
       valid_lft 86172sec preferred_lft 
[vagrant@web1 vagrant]$ sudo docker compose up 
86172sec
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:41:0c:9a brd ff:ff:ff:ff:ff:ff
    altname enp0s8
    inet 192.168.56.34/24 brd 192.168.56.255 scope global dynamic noprefixroute eth1
       valid_lft 372sec preferred_lft 372sec
    inet6 fe80::a00:27ff:fe41:c9a/64 scope link 
       valid_lft forever preferred_lft forever
4: eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:d1:ae:9c brd ff:ff:ff:ff:ff:ff
    altname enp0s9
    inet 10.5.1.111/24 brd 10.5.1.255 scope global noprefixroute eth2
       valid_lft forever preferred_lft forever
    inet 10.5.1.110/32 scope global eth2
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fed1:ae9c/64 scope link 
       valid_lft forever preferred_lft forever
```

```
[vagrant@rp2 ~]$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:cb:b3:b6 brd ff:ff:ff:ff:ff:ff
    altname enp0s3
    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic noprefixroute eth0
       valid_lft 86135sec preferred_lft 86135sec
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:6e:b8:7e brd ff:ff:ff:ff:ff:ff
    altname enp0s8
    inet 192.168.56.35/24 brd 192.168.56.255 scope global dynamic noprefixroute eth1
       valid_lft 335sec preferred_lft 335sec
    inet6 fe80::a00:27ff:fe6e:b87e/64 scope link 
       valid_lft forever preferred_lft forever
4: eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:3c:dc:69 brd ff:ff:ff:ff:ff:ff
    altname enp0s9
    inet 10.5.1.112/24 brd 10.5.1.255 scope global noprefixroute eth2
       valid_lft forever preferred_lft forever
    inet 10.5.1.110/32 scope global eth2
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe3c:dc69/64 scope link 
       valid_lft forever preferred_lft forever

```
curl -w "%{remote_ip}\n" -s http://app_nulle.tp5.b2/

<html>
<body>

  <h2>Insert user</h2>
  <form action="submit.php" method="post">
    Name: <input type="text" name="name"><br>
    E-mail: <input type="text" name="email"><br>
    <input type="submit">
  </form>
  
  <h2>Get user</h2>
    <form action="get.php" method="post">
    Name: <input type="text" name="name"><br>
    <input type="submit">
  </form>

</body>
</html>

10.5.1.110

j'ai crasher rp1 et rp2 a porte bien la VIP maintenant 

```
[vagrant@rp2 ~]$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:cb:b3:b6 brd ff:ff:ff:ff:ff:ff
    altname enp0s3
    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic noprefixroute eth0
       valid_lft 85867sec preferred_lft 85867sec
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:6e:b8:7e brd ff:ff:ff:ff:ff:ff
    altname enp0s8
    inet 192.168.56.35/24 brd 192.168.56.255 scope global dynamic noprefixroute eth1
       valid_lft 367sec preferred_lft 367sec
    inet6 fe80::a00:27ff:fe6e:b87e/64 scope link 
       valid_lft forever preferred_lft forever
4: eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:3c:dc:69 brd ff:ff:ff:ff:ff:ff
    altname enp0s9
    inet 10.5.1.112/24 brd 10.5.1.255 scope global noprefixroute eth2
       valid_lft forever preferred_lft forever
    inet 10.5.1.110/32 scope global eth2
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe3c:dc69/64 scope link 
       valid_lft forever preferred_lft forever

```

# III. Scaling DB

## 0. Intro blablaaaa


## 1. DB additionnelle

➜ **Vous connaissez la chanson : créez une nouvelle VM `db2.tp5.b2`**

## 2. Conf master slave


```
CREATE USER 'db2'@'10.5.1.212' IDENTIFIED BY 'db2';
                          GRANT REPLICATION SLAVE ON *.* TO 'db2'@'10.5.1.212';
                          FLUSH PRIVILEGES;
                          FLUSH TABLES WITH READ LOCK;
                          SHOW MASTER STATUS;
```

```
CHANGE MASTER TO
                            MASTER_HOST='10.5.1.211',
                            MASTER_USER='db2',
                            MASTER_PASSWORD='db2',
                            MASTER_LOG_FILE='mysql-bin.000001',
                            MASTER_LOG_POS=328;

                          START SLAVE;


```

```
[vagrant@db1 ~]$ sudo cat /etc/my.cnf.d/mariadb-server.cnf
#
# These groups are read by MariaDB server.
# Use it for options that only the server (but not clients) should see
#
# See the examples of server my.cnf files in /usr/share/mysql/
#

# this is read by the standalone daemon and embedded servers
[server]

# this is only for the mysqld standalone daemon
# Settings user and group are ignored when systemd is used.
# If you need to run mysqld under a different user or group,
# customize your systemd unit file for mysqld/mariadb according to the
# instructions in http://fedoraproject.org/wiki/Systemd
[mysqld]
datadir=/var/lib/mysql
socket=/var/lib/mysql/mysql.sock
log-error=/var/log/mariadb/mariadb.log
pid-file=/run/mariadb/mariadb.pid
server-id=1
log-bin=mysql-bin


#
# * Galera-related settings
#
[galera]
# Mandatory settings
#wsrep_on=ON
#wsrep_provider=
#wsrep_cluster_address=
#binlog_format=row
#default_storage_engine=InnoDB
#innodb_autoinc_lock_mode=2
#
# Allow server to accept connections on all interfaces.
#
#bind-address=0.0.0.0
#
# Optional setting
#wsrep_slave_threads=1
#innodb_flush_log_at_trx_commit=0

# this is only for embedded server
[embedded]

# This group is only read by MariaDB servers, not by MySQL.
# If you use the same .cnf file for MySQL and MariaDB,
# you can put MariaDB-only options here
[mariadb]

# This group is only read by MariaDB-10.5 servers.
# If you use the same .cnf file for MariaDB of different versions,
# use this group for options that older servers don't understand
[mariadb-10.5]


```

```
[vagrant@db2 my.cnf.d]$ sudo cat /etc/my.cnf.d/mariadb-server.cnf
#
# These groups are read by MariaDB server.
# Use it for options that only the server (but not clients) should see
#
# See the examples of server my.cnf files in /usr/share/mysql/
#

# this is read by the standalone daemon and embedded servers
[server]

# this is only for the mysqld standalone daemon
# Settings user and group are ignored when systemd is used.
# If you need to run mysqld under a different user or group,
# customize your systemd unit file for mysqld/mariadb according to the
# instructions in http://fedoraproject.org/wiki/Systemd
[mysqld]
datadir=/var/lib/mysql
socket=/var/lib/mysql/mysql.sock
log-error=/var/log/mariadb/mariadb.log
pid-file=/run/mariadb/mariadb.pid
server-id=2


# * Galera-related settings
#
[galera]
# Mandatory settings
#wsrep_on=ON
#wsrep_provider=
#wsrep_cluster_address=
#binlog_format=row
#default_storage_engine=InnoDB
#innodb_autoinc_lock_mode=2
#
# Allow server to accept connections on all interfaces.
#
#bind-address=0.0.0.0
#
# Optional setting
#wsrep_slave_threads=1
#innodb_flush_log_at_trx_commit=0

# this is only for embedded server
[embedded]

# This group is only read by MariaDB servers, not by MySQL.
# If you use the same .cnf file for MySQL and MariaDB,
# you can put MariaDB-only options here
[mariadb]

# This group is only read by MariaDB-10.5 servers.
# If you use the same .cnf file for MariaDB of different versions,
# use this group for options that older servers don't understand
[mariadb-10.5]


```

db1:

```
MariaDB [app_nulle]> select * from meo;

|  6 | zdz    | dzd             |
+----+--------+-----------------+
```

db2:
```
MariaDB [app_nulle]> select * from meo;
+----+------+-------+
| id | name | email |
+----+------+-------+
|  6 | zdz  | dzd   |
+----+------+-------+
1 row in set (0.002 sec)

```