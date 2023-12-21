# III. Docker compose

🌞 **Créez un fichier `docker-compose.yml`**

🌞 **Lancez les deux conteneurs** avec `docker compose`

```
[root@docker orealyz]# docker compose up -d
[+] Running 3/3
 ✔ conteneur_nul Pulled                                                                                                                                           4.3s 
 ✔ conteneur_flopesque 1 layers [⣿]      0B/0B      Pulled                                                                                                        3.9s 
   ✔ bc0734b949dc Already exists                                                                                                                                  0.0s 
[+] Running 3/3
 ✔ Network orealyz_default                  Created                                                                                                               0.9s 
 ✔ Container orealyz-conteneur_nul-1        Started                                                                                                               0.3s 
 ✔ Container orealyz-conteneur_flopesque-1  Started                                                                                                               0.3s 
[root@docker orealyz]# cat docker-compose.yml 
version: "3"

services:
  conteneur_nul:
    image: debian
    entrypoint: sleep 9999
  conteneur_flopesque:
    image: debian
    entrypoint: sleep 9999
```

🌞 **Vérifier que les deux conteneurs tournent**

```
[root@docker orealyz]# docker compose ps
NAME                            IMAGE     COMMAND        SERVICE               CREATED          STATUS          PORTS
orealyz-conteneur_flopesque-1   debian    "sleep 9999"   conteneur_flopesque   35 seconds ago   Up 33 seconds   
orealyz-conteneur_nul-1         debian    "sleep 9999"   conteneur_nul         35 seconds ago   Up 33 seconds   

[root@docker orealyz]# docker compose top
orealyz-conteneur_flopesque-1
UID    PID     PPID    C    STIME   TTY   TIME       CMD
root   20917   20872   0    15:41   ?     00:00:00   sleep 9999   

orealyz-conteneur_nul-1
UID    PID     PPID    C    STIME   TTY   TIME       CMD
root   20911   20873   0    15:41   ?     00:00:00   sleep 9999 
```

🌞 **Pop un shell dans le conteneur `conteneur_nul`**

```
[root@docker orealyz]# docker exec -it orealyz-conteneur_nul-1 bash
root@62679d5ad67b:/# apt update && apt install -y iputils-ping
Get:1 http://deb.debian.org/debian bookworm InRelease [151 kB]
Get:2 http://deb.debian.org/debian bookworm-updates InRelease [52.1 kB]
Get:3 http://deb.debian.org/debian-security bookworm-security InRelease [48.0 kB]
Get:4 http://deb.debian.org/debian bookworm/main amd64 Packages [8787 kB]
Get:5 http://deb.debian.org/debian bookworm-updates/main amd64 Packages [11.3 kB]
Get:6 http://deb.debian.org/debian-security bookworm-security/main amd64 Packages [128 kB]
Fetched 9177 kB in 4s (2157 kB/s)                         
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
All packages are up to date.
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  libcap2-bin libpam-cap
The following NEW packages will be installed:
  iputils-ping libcap2-bin libpam-cap
0 upgraded, 3 newly installed, 0 to remove and 0 not upgraded.
Need to get 96.2 kB of archives.
After this operation, 311 kB of additional disk space will be used.
Get:1 http://deb.debian.org/debian bookworm/main amd64 libcap2-bin amd64 1:2.66-4 [34.7 kB]
Get:2 http://deb.debian.org/debian bookworm/main amd64 iputils-ping amd64 3:20221126-1 [47.1 kB]
Get:3 http://deb.debian.org/debian bookworm/main amd64 libpam-cap amd64 1:2.66-4 [14.5 kB]
Fetched 96.2 kB in 0s (459 kB/s) 
debconf: delaying package configuration, since apt-utils is not installed
Selecting previously unselected package libcap2-bin.
(Reading database ... 6098 files and directories currently installed.)
Preparing to unpack .../libcap2-bin_1%3a2.66-4_amd64.deb ...
Unpacking libcap2-bin (1:2.66-4) ...
Selecting previously unselected package iputils-ping.
Preparing to unpack .../iputils-ping_3%3a20221126-1_amd64.deb ...
Unpacking iputils-ping (3:20221126-1) ...
Selecting previously unselected package libpam-cap:amd64.
Preparing to unpack .../libpam-cap_1%3a2.66-4_amd64.deb ...
Unpacking libpam-cap:amd64 (1:2.66-4) ...
Setting up libcap2-bin (1:2.66-4) ...
Setting up libpam-cap:amd64 (1:2.66-4) ...
debconf: unable to initialize frontend: Dialog
debconf: (No usable dialog-like program is installed, so the dialog based frontend cannot be used. at /usr/share/perl5/Debconf/FrontEnd/Dialog.pm line 78.)
debconf: falling back to frontend: Readline
debconf: unable to initialize frontend: Readline
debconf: (Can't locate Term/ReadLine.pm in @INC (you may need to install the Term::ReadLine module) (@INC contains: /etc/perl /usr/local/lib/x86_64-linux-gnu/perl/5.36.0 /usr/local/share/perl/5.36.0 /usr/lib/x86_64-linux-gnu/perl5/5.36 /usr/share/perl5 /usr/lib/x86_64-linux-gnu/perl-base /usr/lib/x86_64-linux-gnu/perl/5.36 /usr/share/perl/5.36 /usr/local/lib/site_perl) at /usr/share/perl5/Debconf/FrontEnd/Readline.pm line 7.)
debconf: falling back to frontend: Teletype
Setting up iputils-ping (3:20221126-1) ...
root@62679d5ad67b:/# ping conteneur_flopesque
PING conteneur_flopesque (172.18.0.3) 56(84) bytes of data.
64 bytes from orealyz-conteneur_flopesque-1.orealyz_default (172.18.0.3): icmp_seq=1 ttl=64 time=0.122 ms
64 bytes from orealyz-conteneur_flopesque-1.orealyz_default (172.18.0.3): icmp_seq=2 ttl=64 time=0.139 ms
^C
--- conteneur_flopesque ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1003ms
rtt min/avg/max/mdev = 0.122/0.130/0.139/0.008 ms

```