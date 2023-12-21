# I. Init

- [I. Init](#i-init)
  - [1. Installation de Docker](#1-installation-de-docker)
  - [4. Un premier conteneur en vif](#4-un-premier-conteneur-en-vif)
  - [5. Un deuxième conteneur en vif](#5-un-deuxième-conteneur-en-vif)

## 1. Installation de Docker

🌞 **Ajouter votre utilisateur au groupe `docker`**

```
[root@docker network-scripts]# sudo usermod -aG docker root

```
## 4. Un premier conteneur en vif


🌞 **Lancer un conteneur NGINX**

```
[root@docker ~]# docker run -d -p 9999:80 nginx
Unable to find image 'nginx:latest' locally
latest: Pulling from library/nginx
af107e978371: Pull complete 
336ba1f05c3e: Pull complete 
8c37d2ff6efa: Pull complete 
51d6357098de: Pull complete 
782f1ecce57d: Pull complete 
5e99d351b073: Pull complete 
7b73345df136: Pull complete 
Digest: sha256:bd30b8d47b230de52431cc71c5cce149b8d5d4c87c204902acf2504435d4b4c9
Status: Downloaded newer image for nginx:latest
713f9e4c81040c2e1851665b02f9ffee9582916d834706916c01e574c2541c8b
```
🌞 **Visitons**

```
[root@docker ~]# docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS                                   NAMES
713f9e4c8104   nginx     "/docker-entrypoint.…"   5 minutes ago   Up 5 minutes   0.0.0.0:9999->80/tcp, :::9999->80/tcp   elastic_maxwell
[root@docker ~]# docker logs 713f9e4c8104
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Sourcing /docker-entrypoint.d/15-local-resolvers.envsh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2023/12/21 12:38:00 [notice] 1#1: using the "epoll" event method
2023/12/21 12:38:00 [notice] 1#1: nginx/1.25.3
2023/12/21 12:38:00 [notice] 1#1: built by gcc 12.2.0 (Debian 12.2.0-14) 
2023/12/21 12:38:00 [notice] 1#1: OS: Linux 5.14.0-284.30.1.el9_2.x86_64
2023/12/21 12:38:00 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1073741816:1073741816
2023/12/21 12:38:00 [notice] 1#1: start worker processes
2023/12/21 12:38:00 [notice] 1#1: start worker process 28
192.168.56.1 - - [21/Dec/2023:12:42:51 +0000] "GET / HTTP/1.1" 200 615 "-" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" "-"
192.168.56.1 - - [21/Dec/2023:12:42:51 +0000] "GET /favicon.ico HTTP/1.1" 404 555 "http://192.168.56.69:9999/" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" "-"
2023/12/21 12:42:51 [error] 28#28: *1 open() "/usr/share/nginx/html/favicon.ico" failed (2: No such file or directory), client: 192.168.56.1, server: localhost, request: "GET /favicon.ico HTTP/1.1", host: "192.168.56.69:9999", referrer: "http://192.168.56.69:9999/"

```
```
[root@docker ~]# docker inspect 713f9e4c8104
[
    {
        "Id": "713f9e4c81040c2e1851665b02f9ffee9582916d834706916c01e574c2541c8b",
        "Created": "2023-12-21T12:37:59.773073323Z",
        "Path": "/docker-entrypoint.sh",
        "Args": [
            "nginx",
            "-g",
            "daemon off;"
        ],
        "State": {
            "Status": "running",
            "Running": true,
            "Paused": false,
            "Restarting": false,
            "OOMKilled": false,
            "Dead": false,
            "Pid": 1584,
            "ExitCode": 0,
            "Error": "",
            "StartedAt": "2023-12-21T12:38:00.836520015Z",
            "FinishedAt": "0001-01-01T00:00:00Z"
        },
        "Image": "sha256:d453dd892d9357f3559b967478ae9cbc417b52de66b53142f6c16c8a275486b9",
        "ResolvConfPath": "/var/lib/docker/containers/713f9e4c81040c2e1851665b02f9ffee9582916d834706916c01e574c2541c8b/resolv.conf",
        "HostnamePath": "/var/lib/docker/containers/713f9e4c81040c2e1851665b02f9ffee9582916d834706916c01e574c2541c8b/hostname",
        "HostsPath": "/var/lib/docker/containers/713f9e4c81040c2e1851665b02f9ffee9582916d834706916c01e574c2541c8b/hosts",
        "LogPath": "/var/lib/docker/containers/713f9e4c81040c2e1851665b02f9ffee9582916d834706916c01e574c2541c8b/713f9e4c81040c2e1851665b02f9ffee9582916d834706916c01e574c2541c8b-json.log",
        "Name": "/elastic_maxwell",
        "RestartCount": 0,
        "Driver": "overlay2",
        "Platform": "linux",
        "MountLabel": "",
        "ProcessLabel": "",
        "AppArmorProfile": "",
        "ExecIDs": null,
        "HostConfig": {
            "Binds": null,
            "ContainerIDFile": "",
            "LogConfig": {
                "Type": "json-file",
                "Config": {}
            },
            "NetworkMode": "default",
            "PortBindings": {
                "80/tcp": [
                    {
                        "HostIp": "",
                        "HostPort": "9999"
                    }
                ]
            },
            "RestartPolicy": {
                "Name": "no",
                "MaximumRetryCount": 0
            },
            "AutoRemove": false,
            "VolumeDriver": "",
            "VolumesFrom": null,
            "ConsoleSize": [
                30,
                152
            ],
            "CapAdd": null,
            "CapDrop": null,
            "CgroupnsMode": "private",
            "Dns": [],
            "DnsOptions": [],
            "DnsSearch": [],
            "ExtraHosts": null,
            "GroupAdd": null,
            "IpcMode": "private",
            "Cgroup": "",
            "Links": null,
            "OomScoreAdj": 0,
            "PidMode": "",
            "Privileged": false,
            "PublishAllPorts": false,
            "ReadonlyRootfs": false,
            "SecurityOpt": null,
            "UTSMode": "",
            "UsernsMode": "",
            "ShmSize": 67108864,
            "Runtime": "runc",
            "Isolation": "",
            "CpuShares": 0,
            "Memory": 0,
            "NanoCpus": 0,
            "CgroupParent": "",
            "BlkioWeight": 0,
            "BlkioWeightDevice": [],
            "BlkioDeviceReadBps": [],
            "BlkioDeviceWriteBps": [],
            "BlkioDeviceReadIOps": [],
            "BlkioDeviceWriteIOps": [],
            "CpuPeriod": 0,
            "CpuQuota": 0,
            "CpuRealtimePeriod": 0,
            "CpuRealtimeRuntime": 0,
            "CpusetCpus": "",
            "CpusetMems": "",
            "Devices": [],
            "DeviceCgroupRules": null,
            "DeviceRequests": null,
            "MemoryReservation": 0,
            "MemorySwap": 0,
            "MemorySwappiness": null,
            "OomKillDisable": null,
            "PidsLimit": null,
            "Ulimits": null,
            "CpuCount": 0,
            "CpuPercent": 0,
            "IOMaximumIOps": 0,
            "IOMaximumBandwidth": 0,
            "MaskedPaths": [
                "/proc/asound",
                "/proc/acpi",
                "/proc/kcore",
                "/proc/keys",
                "/proc/latency_stats",
                "/proc/timer_list",
                "/proc/timer_stats",
                "/proc/sched_debug",
                "/proc/scsi",
                "/sys/firmware",
                "/sys/devices/virtual/powercap"
            ],
            "ReadonlyPaths": [
                "/proc/bus",
                "/proc/fs",
                "/proc/irq",
                "/proc/sys",
                "/proc/sysrq-trigger"
            ]
        },
        "GraphDriver": {
            "Data": {
                "LowerDir": "/var/lib/docker/overlay2/b8d748c296979b1c7115366d7b5ddae52b7990fe812e5c41b62c3d695a35f4af-init/diff:/var/lib/docker/overlay2/d3eaac4837420768b8c818edb1536b1be3f463cfefd625838d2351c423028c33/diff:/var/lib/docker/overlay2/3f42b645705ca0a2aaa6848db98a9d9e9aba3033faa719aaa62c672ce5f20243/diff:/var/lib/docker/overlay2/b8ad1c6d3f2e6f622a604d1f5a2dbd5338cb64755de3b057c50ebcbbd09d61c4/diff:/var/lib/docker/overlay2/18563c1ccaed4d1090edfa40cf21f4c9d8c8d15834a6f3cd78b4a8e3fee57a98/diff:/var/lib/docker/overlay2/b9bcbd159b00ebe4679ed4dfecd0d9826d26fffb4722e5b9dd44f2670d32df73/diff:/var/lib/docker/overlay2/489213b9c07265d54c5921901d7037ae61cb4940646cf9a05c12c15775b55ea1/diff:/var/lib/docker/overlay2/5ea30b3488b18c037d5aab9e2aa34cb98ecf276832cad213d9e53c1d7e88a150/diff",
                "MergedDir": "/var/lib/docker/overlay2/b8d748c296979b1c7115366d7b5ddae52b7990fe812e5c41b62c3d695a35f4af/merged",
                "UpperDir": "/var/lib/docker/overlay2/b8d748c296979b1c7115366d7b5ddae52b7990fe812e5c41b62c3d695a35f4af/diff",
                "WorkDir": "/var/lib/docker/overlay2/b8d748c296979b1c7115366d7b5ddae52b7990fe812e5c41b62c3d695a35f4af/work"
            },
            "Name": "overlay2"
        },
        "Mounts": [],
        "Config": {
            "Hostname": "713f9e4c8104",
            "Domainname": "",
            "User": "",
            "AttachStdin": false,
            "AttachStdout": false,
            "AttachStderr": false,
            "ExposedPorts": {
                "80/tcp": {}
            },
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": [
                "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
                "NGINX_VERSION=1.25.3",
                "NJS_VERSION=0.8.2",
                "PKG_RELEASE=1~bookworm"
            ],
            "Cmd": [
                "nginx",
                "-g",
                "daemon off;"
            ],
            "Image": "nginx",
            "Volumes": null,
            "WorkingDir": "",
            "Entrypoint": [
                "/docker-entrypoint.sh"
            ],
            "OnBuild": null,
            "Labels": {
                "maintainer": "NGINX Docker Maintainers <docker-maint@nginx.com>"
            },
            "StopSignal": "SIGQUIT"
        },
        "NetworkSettings": {
            "Bridge": "",
            "SandboxID": "dc59e693d92ef78a0aed0ab3254950df979b25705b5353ed10dd4a50e6404b9c",
            "HairpinMode": false,
            "LinkLocalIPv6Address": "",
            "LinkLocalIPv6PrefixLen": 0,
            "Ports": {
                "80/tcp": [
                    {
                        "HostIp": "0.0.0.0",
                        "HostPort": "9999"
                    },
                    {
                        "HostIp": "::",
                        "HostPort": "9999"
                    }
                ]
            },
            "SandboxKey": "/var/run/docker/netns/dc59e693d92e",
            "SecondaryIPAddresses": null,
            "SecondaryIPv6Addresses": null,
            "EndpointID": "c12256d85b62b1f1ed53253cb6c3d6ea9ecfe1cecfb6c062669b2e0cb5d1376e",
            "Gateway": "172.17.0.1",
            "GlobalIPv6Address": "",
            "GlobalIPv6PrefixLen": 0,
            "IPAddress": "172.17.0.2",
            "IPPrefixLen": 16,
            "IPv6Gateway": "",
            "MacAddress": "02:42:ac:11:00:02",
            "Networks": {
                "bridge": {
                    "IPAMConfig": null,
                    "Links": null,
                    "Aliases": null,
                    "NetworkID": "cf4bb93d2e360e10435a5558c72ad852103da5b03cbdd831e59b84e8f4bf44d8",
                    "EndpointID": "c12256d85b62b1f1ed53253cb6c3d6ea9ecfe1cecfb6c062669b2e0cb5d1376e",
                    "Gateway": "172.17.0.1",
                    "IPAddress": "172.17.0.2",
                    "IPPrefixLen": 16,
                    "IPv6Gateway": "",
                    "GlobalIPv6Address": "",
                    "GlobalIPv6PrefixLen": 0,
                    "MacAddress": "02:42:ac:11:00:02",
                    "DriverOpts": null
                }
            }
        }
    }
]
```

```
[root@docker ~]# sudo ss -lnpt | grep 9999
LISTEN 0      4096         0.0.0.0:9999      0.0.0.0:*    users:(("docker-proxy",pid=1541,fd=4))
LISTEN 0      4096            [::]:9999         [::]:*    users:(("docker-proxy",pid=1546,fd=4))

```

```
[root@docker ~]# sudo firewall-cmd --add-port=9999/tcp --permanent
success
[root@docker ~]# sudo firewall-cmd --reload
success
[root@docker ~]# sudo firewall-cmd --list-all
public (active)
  target: default
  icmp-block-inversion: no
  interfaces: enp0s3 enp0s8
  sources: 
  services: cockpit dhcpv6-client ssh
  ports: 9999/tcp
  protocols: 
  forward: yes
  masquerade: no
  forward-ports: 
  source-ports: 
  icmp-blocks: 
  rich rules: 

```

🌞 **On va ajouter un site Web au conteneur NGINX**

```
[root@docker nginx]# docker run -d -p 9999:8080 -v /home/orealyz/nginx/index.html:/var/www/html/index.html -v /home/orealyz/nginx/site_nul.conf:/etc/nginx/conf.d/site_nul.conf nginx
00ea0b074351bf2718eea7333242ab72a7a676c1e166c3b5ed6e9e58fb1cee5d
```

🌞 **Visitons**


```
[root@docker nginx]# docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS         PORTS                                               NAMES
00ea0b074351   nginx     "/docker-entrypoint.…"   10 seconds ago   Up 9 seconds   80/tcp, 0.0.0.0:9999->8080/tcp, :::9999->8080/tcp   trusting_neumann

```
## 5. Un deuxième conteneur en vif

🌞 **Lance un conteneur Python, avec un shell**


```
[root@docker nginx]# docker run -it python bash
Unable to find image 'python:latest' locally
latest: Pulling from library/python
bc0734b949dc: Pull complete 
b5de22c0f5cd: Pull complete 
917ee5330e73: Pull complete 
b43bd898d5fb: Pull complete 
7fad4bffde24: Pull complete 
d685eb68699f: Pull complete 
107007f161d0: Pull complete 
02b85463d724: Pull complete 
Digest: sha256:3733015cdd1bd7d9a0b9fe21a925b608de82131aa4f3d397e465a1fcb545d36f
Status: Downloaded newer image for python:latest
root@cd2aa1f86b9f:/# pip install aiohttp aioconsole
Collecting aiohttp
[...]
```

🌞 **Installe des libs Python**


```
root@cd2aa1f86b9f:/# python
Python 3.12.1 (main, Dec 19 2023, 20:14:15) [GCC 12.2.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import aiohttp
>>> 

```

```
root@cd2aa1f86b9f:/# ls
bin  boot  dev  etc  home  lib  lib32  lib64  libx32  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
root@cd2aa1f86b9f:/# ip a
bash: ip: command not found

```