# II. Images

- [II. Images](#ii-images)
  - [1. Images publiques](#1-images-publiques)
  - [2. Construire une image](#2-construire-une-image)

## 1. Images publiques

🌞 **Récupérez des images**


```
[root@docker nginx]# docker pull python:3.11
[root@docker nginx]# docker pull mysql:5.7
[root@docker nginx]# docker pull wordpress:latest
[root@docker nginx]# docker pull linuxserver/wikijs:latest

```

```
[root@docker nginx]# docker images
REPOSITORY           TAG       IMAGE ID       CREATED        SIZE
linuxserver/wikijs   latest    869729f6d3c5   6 days ago     441MB
mysql                5.7       5107333e08a8   8 days ago     501MB
wordpress            latest    fd2f5a0c6fba   2 weeks ago    739MB
python               3.11      22140cbb3b0c   2 weeks ago    1.01GB

```


🌞 **Lancez un conteneur à partir de l'image Python**


```
[root@docker nginx]# docker run -it python:3.11 bash
root@4bd2a57576df:/# python --version
Python 3.11.7

```


## 2. Construire une image


🌞 **Ecrire un Dockerfile pour une image qui héberge une application Python**

🌞 **Build l'image**


```
[root@docker python_app_build]# cat Dockerfile 
FROM debian

RUN apt update -y && apt install -y python3-pip

RUN python3 -m pip install emoji --break-system-packages 

RUN mkdir /app
WORKDIR /app
COPY app.py /app/app.py

ENTRYPOINT ["python3", "app.py"]

```

```
[root@docker python_app_build]# docker build . -t python_app:version_de_ouf
[+] Building 133.0s (11/11) FINISHED                                                                                        docker:default
 => [internal] load build definition from Dockerfile                                                                                  0.1s
 => => transferring dockerfile: 246B                                                                                                  0.0s
 => [internal] load .dockerignore                                                                                                     0.1s
 => => transferring context: 2B                                                                                                       0.0s
 => [internal] load metadata for docker.io/library/debian:latest                                                                      0.0s
 => CACHED [1/6] FROM docker.io/library/debian                                                                                        0.0s
 => [internal] load build context                                                                                                     0.1s
 => => transferring context: 27B                                                                                                      0.0s
 => [2/6] RUN apt update -y && apt install -y python3-pip                                                                           118.5s
 => [3/6] RUN python3 -m pip install emoji --break-system-packages                                                                    3.0s 
 => [4/6] RUN mkdir /app                                                                                                              0.6s 
 => [5/6] WORKDIR /app                                                                                                                0.3s 
 => [6/6] COPY app.py /app/app.py                                                                                                     0.3s 
 => exporting to image                                                                                                                9.6s 
 => => exporting layers                                                                                                               9.5s 
 => => writing image sha256:aeacb748563913fb18706b37a4abaec48c2e169202dcb09286855634e0d7b8e6                                          0.0s 
 => => naming to docker.io/library/python_app:version_de_ouf                                                                          0.0s


```

🌞 **Lancer l'image**

```
[root@docker python_app_build]# docker run python_app:version_de_ouf
Cet exemple d'application est vraiment naze 👎
```