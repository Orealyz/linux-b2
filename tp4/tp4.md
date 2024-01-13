# TP4 : Vers une maîtrise des OS Linux


## Sommaire

- [TP4 : Vers une maîtrise des OS Linux](#tp4--vers-une-maîtrise-des-os-linux)
  - [Sommaire](#sommaire)
- [I. Partitionnement](#i-partitionnement)
  - [1. LVM dès l'installation](#1-lvm-dès-linstallation)
  - [2. Scénario remplissage de partition](#2-scénario-remplissage-de-partition)
- [II. Gestion de users](#ii-gestion-de-users)
- [III. Gestion du temps](#iii-gestion-du-temps)

# I. Partitionnement


## 1. LVM dès l'installation

🌞 **Faites une install manuelle de Rocky Linux**

```bash
[root@localhost ~]# lsblk
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda           8:0    0   40G  0 disk 
├─sda1        8:1    0    2G  0 part /boot
└─sda2        8:2    0   21G  0 part 
  ├─rl-root 253:0    0   10G  0 lvm  /
  ├─rl-swap 253:1    0    1G  0 lvm  [SWAP]
  ├─rl-var  253:2    0    5G  0 lvm  /var
  └─rl-home 253:3    0    5G  0 lvm  /home
sr0          11:0    1 1024M  0 rom  
[root@localhost ~]# df -h
Filesystem           Size  Used Avail Use% Mounted on
devtmpfs             4.0M     0  4.0M   0% /dev
tmpfs                2.0G     0  2.0G   0% /dev/shm
tmpfs                782M  8.6M  774M   2% /run
/dev/mapper/rl-root  9.8G  959M  8.3G  11% /
/dev/mapper/rl-home  4.9G   24K  4.6G   1% /home
/dev/mapper/rl-var   4.9G   81M  4.5G   2% /var
/dev/sda1            2.0G  230M  1.8G  12% /boot
tmpfs                391M     0  391M   0% /run/user/0
[root@localhost ~]# pvs
  PV         VG Fmt  Attr PSize  PFree
  /dev/sda2  rl lvm2 a--  21.00g 4.00m
[root@localhost ~]# pvdisplay 
  --- Physical volume ---
  PV Name               /dev/sda2
  VG Name               rl
  PV Size               <21.01 GiB / not usable 4.00 MiB
  Allocatable           yes 
  PE Size               4.00 MiB
  Total PE              5377
  Free PE               1
  Allocated PE          5376
  PV UUID               J0OHKi-yzm1-FqmF-oiXX-mAjG-jUBm-LoJTmg
   
[root@localhost ~]# vgs
  VG #PV #LV #SN Attr   VSize  VFree
  rl   1   4   0 wz--n- 21.00g 4.00m
[root@localhost ~]# vgdisplay
  --- Volume group ---
  VG Name               rl
  System ID             
  Format                lvm2
  Metadata Areas        1
  Metadata Sequence No  5
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                4
  Open LV               4
  Max PV                0
  Cur PV                1
  Act PV                1
  VG Size               21.00 GiB
  PE Size               4.00 MiB
  Total PE              5377
  Alloc PE / Size       5376 / 21.00 GiB
  Free  PE / Size       1 / 4.00 MiB
  VG UUID               vDk7oy-qdaA-cFSZ-5kRU-1Y7f-xwTN-95E9Fi
   
[root@localhost ~]# lvs
  LV   VG Attr       LSize  Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  home rl -wi-ao----  5.00g                                                    
  root rl -wi-ao---- 10.00g                                                    
  swap rl -wi-ao----  1.00g                                                    
  var  rl -wi-ao----  5.00g                                                    
[root@localhost ~]# lvdisplay
  --- Logical volume ---
  LV Path                /dev/rl/swap
  LV Name                swap
  VG Name                rl
  LV UUID                inN2pN-zqE3-UJIe-57wL-UNxY-fx4T-2R38Z5
  LV Write Access        read/write
  LV Creation host, time localhost.localdomain, 2024-01-12 13:43:05 +0100
  LV Status              available
  # open                 2
  LV Size                1.00 GiB
  Current LE             256
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           253:1
   
  --- Logical volume ---
  LV Path                /dev/rl/var
  LV Name                var
  VG Name                rl
  LV UUID                vMlENa-XUMw-cQSb-u9Fb-Z1Bh-exrd-DJCjnh
  LV Write Access        read/write
  LV Creation host, time localhost.localdomain, 2024-01-12 13:43:05 +0100
  LV Status              available
  # open                 1
  LV Size                5.00 GiB
  Current LE             1280
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           253:2
   
  --- Logical volume ---
  LV Path                /dev/rl/root
  LV Name                root
  VG Name                rl
  LV UUID                1dsL2s-Z22j-BPxA-N5P3-HXf2-j2D1-fJlDhu
  LV Write Access        read/write
  LV Creation host, time localhost.localdomain, 2024-01-12 13:43:05 +0100
  LV Status              available
  # open                 1
  LV Size                10.00 GiB
  Current LE             2560
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           253:0
   
  --- Logical volume ---
  LV Path                /dev/rl/home
  LV Name                home
  VG Name                rl
  LV UUID                PJ57h4-njxW-UvBy-y4OV-qVLN-De0B-BUn9am
  LV Write Access        read/write
  LV Creation host, time localhost.localdomain, 2024-01-12 13:43:06 +0100
  LV Status              available
  # open                 1
  LV Size                5.00 GiB
  Current LE             1280
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           253:3

```

## 2. Scénario remplissage de partition

🌞 **Remplissez votre partition `/home`**


```
[martin@localhost ~]$ dd if=/dev/zero of=/home/martin/bigfile bs=4M count=5000
dd: error writing '/home/martin/bigfile': No space left on device
1171+0 records in
1170+0 records out
4911124480 bytes (4.9 GB, 4.6 GiB) copied, 6.0926 s, 806 MB/s

```


🌞 **Constater que la partition est pleine**

```
[martin@localhost ~]$ df -h
Filesystem           Size  Used Avail Use% Mounted on
devtmpfs             4.0M     0  4.0M   0% /dev
tmpfs                2.0G     0  2.0G   0% /dev/shm
tmpfs                782M  8.6M  774M   2% /run
/dev/mapper/rl-root  9.8G  959M  8.3G  11% /
/dev/mapper/rl-home  4.9G  4.6G     0 100% /home
/dev/mapper/rl-var   4.9G   81M  4.5G   2% /var
/dev/sda1            2.0G  230M  1.8G  12% /boot
tmpfs                391M     0  391M   0% /run/user/0
tmpfs                391M     0  391M   0% /run/user/2000
```

🌞 **Agrandir la partition**


```
[martin@localhost ~]$ sudo lvextend -l +100%FREE /dev/rl/home
[martin@localhost ~]$ sudo resize2fs /dev/mapper/rl-home

```
🌞 **Remplissez votre partition `/home`**

```
[martin@localhost ~]$ dd if=/dev/zero of=/home/martin/bigfile bs=4M count=5000
```

> 5000x4M ça fait toujours 40G. Et ça fait toujours trop.

➜ **Eteignez la VM et ajoutez lui un disque de 40G**

🌞 **Utiliser ce nouveau disque pour étendre la partition `/home` de 40G**

```
[martin@localhost ~]$ sudo pvcreate -ff /dev/sdb
Really INITIALIZE physical volume "/dev/sdb" of volume group "rl" [y/n]? y
  WARNING: Forcing physical volume creation on /dev/sdb of volume group "rl"
  Physical volume "/dev/sdb" successfully created.
[martin@localhost ~]$ sudo vgextend rl /dev/sdb

  Volume group "rl" successfully extended
  [martin@localhost ~]$ sudo lvextend -l +100%FREE /dev/rl/home
  Size of logical volume rl/home changed from 5.00 GiB (1280 extents) to 45.00 GiB (11520 extents).
  Logical volume rl/home successfully resized.
[martin@localhost ~]$ sudo resize2fs /dev/rl/home
resize2fs 1.46.5 (30-Dec-2021)
Filesystem at /dev/rl/home is mounted on /home; on-line resizing required
old_desc_blocks = 1, new_desc_blocks = 6
The filesystem on /dev/rl/home is now 11796480 (4k) blocks long.

[martin@localhost ~]$ df -h
Filesystem           Size  Used Avail Use% Mounted on
devtmpfs             4.0M     0  4.0M   0% /dev
tmpfs                2.0G     0  2.0G   0% /dev/shm
tmpfs                782M  8.6M  774M   2% /run
/dev/mapper/rl-root  9.8G  959M  8.3G  11% /
/dev/mapper/rl-home   45G  4.6G   38G  11% /home
/dev/mapper/rl-var   4.9G  103M  4.5G   3% /var
/dev/sda1            2.0G  230M  1.8G  12% /boot
tmpfs                391M     0  391M   0% /run/user/2000

```
# II. Gestion de users


🌞 **Gestion basique de users**


```
[martin@localhost bin]$ cat /etc/passwd
alice:x:2001:2001::/home/alice:/bin/bash
bob:x:2002:2002::/home/bob:/bin/bash
charlie:x:2003:2003::/home/charlie:/bin/bash
eve:x:2004:2004::/home/eve:/bin/bash
backup:x:2005:2005::/var/backup:/usr/sbin/nologin

```
🌞 **La conf `sudo` doit être la suivante**

```
[martin@localhost bin]$ sudo visudo

%admins ALL=(ALL) NOPASSWD: ALL

eve ALL=(backup) /bin/ls, PASSWD: /bin/ls
```

🌞 **Le dossier `/var/backup`**


```
[martin@localhost var]$ sudo chmod 700 /var/backup
[martin@localhost var]$ sudo chown backup:backup /var/backup
[martin@localhost var]$ sudo touch /var/backup/precious_backup
[martin@localhost var]$ sudo chmod 640 /var/backup/precious_backup
[martin@localhost var]$ sudo chown backup:backup /var/backup/precious_backup

```
🌞 **Mots de passe des users, prouvez que**


le ```$6$``` indique bien que c'est hashés en SHA512, pour alice par exemple le salt est ```f8oYKlrjeIyNPDc0 ```. Le salt c'est ce qui a entre le $ apres le $6$ et le $ qui suit.

```
[martin@localhost ~]$ sudo cat /etc/shadow

alice:$6$f8oYKlrjeIyNPDc0$xGKPGax8lo5w6dMdp9GQu805PGXMa2j6L.ePYMK/zmoJUIwavOT7JVM/Ucn.4sIja9Pr4GThp/PkSxqM0ZWyP1:19734:0:99999:7:::
bob:$6$xt9.Rs5LAjFqENKF$2aWRk/8HT6amDay/99yQBEeF5HySc3O7PlMxJZIjkX/wRxRd0xk7Funis2lpnPla50SxLhN0Hzl5IJpaRKobQ0:19734:0:99999:7:::
charlie:$6$M4pzXUG7lJABBa0J$0H2PTDrPXxIOKVRi2bII7W0L.OneL7JHWcwPbE5A4m/ACMPrgwUs1nyQmO54aTWCgUW39fjiITKkZ/V7oXUF//:19734:0:99999:7:::
eve:$6$JqW5OL6tR5C88VVc$w0qt0kqG1P9AnlEfFk9xqMdmyI2XagjF0h5SnVIaweusgDYnP0cD9hgUjQ5eoLqaEE75VEgsXDoBx0bRvW5Yz0:19734:0:99999:7:::
backup:$6$mKR.rKxvQvEqCzSW$/XMJIP6nFN5hcQJaTbr8l03dNx/pOBldV4eTr9/nufeHD5mJ5BjhpuQpP6zcKsD4QcbY5o87WqX/E1tI3BMYr.:19734:0:99999:7:::

```
🌞 **User eve**



```
[eve@localhost ~]$ sudo -l

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for eve: 
Matching Defaults entries for eve on localhost:
    !visiblepw, always_set_home, match_group_by_gid, always_query_group_plugin, env_reset, env_keep="COLORS DISPLAY HOSTNAME HISTSIZE KDEDIR LS_COLORS", env_keep+="MAIL PS1 PS2 QTDIR USERNAME LANG LC_ADDRESS
    LC_CTYPE", env_keep+="LC_COLLATE LC_IDENTIFICATION LC_MEASUREMENT LC_MESSAGES", env_keep+="LC_MONETARY LC_NAME LC_NUMERIC LC_PAPER LC_TELEPHONE", env_keep+="LC_TIME LC_ALL LANGUAGE LINGUAS _XKB_CHARSET
    XAUTHORITY", secure_path=/sbin\:/bin\:/usr/sbin\:/usr/bin

User eve may run the following commands on localhost:
    (backup) /bin/ls, PASSWD: /bin/ls

```

# III. Gestion du temps


🌞 **Je vous laisse gérer le bail vous-mêmes**


```
[martin@localhost ~]$ systemctl list-units -t service -a | grep ntp
  initrd-parse-etc.service                   loaded    inactive dead    Mountpoints Configured in the Real Root
● ntpd.service                               not-found inactive dead    ntpd.service
● ntpdate.service                            not-found inactive dead    ntpdate.service
● sntp.service                               not-found inactive dead    sntp.service

```

```
[martin@localhost etc]$ sudo cat /etc/chrony.conf
# Use public servers from the pool.ntp.org project.
# Please consider joining the pool (https://www.pool.ntp.org/join.html).
#pool 2.rocky.pool.ntp.org iburst
pool pool.ntp.org 

```
```
[martin@localhost etc]$ sudo systemctl restart chronyd
[martin@localhost etc]$ timedatectl 
               Local time: Fri 2024-01-12 16:09:50 CET
           Universal time: Fri 2024-01-12 15:09:50 UTC
                 RTC time: Fri 2024-01-12 15:09:50
                Time zone: Europe/Paris (CET, +0100)
System clock synchronized: no
              NTP service: active
          RTC in local TZ: no
[martin@localhost etc]$ 

```