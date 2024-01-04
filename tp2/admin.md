# TP2 admins : PHP stack

## Sommaire

- [TP2 admins : PHP stack](#tp2-admins--php-stack)
  - [Sommaire](#sommaire)
- [I. Good practices](#i-good-practices)
- [II. Reverse proxy buddy](#ii-reverse-proxy-buddy)
  - [A. Simple HTTP setup](#a-simple-http-setup)
  - [B. HTTPS auto-signé](#b-https-auto-signé)
  - [C. HTTPS avec une CA maison](#c-https-avec-une-ca-maison)

# I. Good practices

🌞 **Limiter l'accès aux ressources**


🌞 **No `root`**


dans le compose
```
user: toto 
```
 sur un docker run
```
  -u toto
```



# II. Reverse proxy buddy

## A. Simple HTTP setup

🌞 **Adaptez le `docker-compose.yml`** de [la partie précédente](./php.md)

```nginx
server {
    listen       80;
    server_name  www.supersite.com;

    location / {
        proxy_pass   http://nom_du_conteneur_PHP;
    }
}

server {
    listen       80;
    server_name  pma.supersite.com;

    location / {
        proxy_pass   http://nom_du_conteneur_PMA;
    }
}
```

## B. HTTPS auto-signé

🌞 **HTTPS** auto-signé


```
openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -keyout www.supersite.com.key -out www.supersite.com.crt

```

```
openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -keyout www.supersite.com.key -out pma.supersite.com.crt

```


```
cat nginx/nginx.conf
events {

}

http {
    server {
        listen 80;
        server_name www.supersite.com;

        location / {
            return 301 https://$host$request_uri;
        }
    }

    server {
        listen 443 ssl;
        server_name www.supersite.com;

        ssl_certificate /etc/nginx/certs/www.supersite.com.crt;
        ssl_certificate_key /etc/nginx/certs/www.supersite.com.key;

        location / {
            proxy_pass http://php-apache;
        }
    }

    server {
        listen 8080;
        server_name pma.supersite.com;

        return 301 https://$host$request_uri;
    }

    server {
        listen 443 ssl;
        server_name pma.supersite.com;

        ssl_certificate /etc/nginx/certs/pma.supersite.com.crt;
        ssl_certificate_key /etc/nginx/certs/pma.supersite.com.key;

        location / {
            proxy_pass http://phpmyadmin;
        }
    }
}
 ~/D/2/l/t/php   main ±  cat docker-compose.yml 
version: '3'

services:
  php-apache:
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - "80:80"
    command: ["bash", "-c", "echo 'App is ready on http://localhost:80' && exec apache2-foreground"]

  mysql:
    image: mysql:8.0
    environment:
      MYSQL_USER: oui
      MYSQL_PASSWORD: oui
      MYSQL_ROOT_PASSWORD: oui
      MYSQL_DATABASE: database
    volumes:
      - ./php/sql/seed.sql:/docker-entrypoint-initdb.d/seed.sql
    ports:
      - "3306:3306"

  phpmyadmin:
    image: phpmyadmin
    restart: always
    ports:
      - "8080:80"
    environment:
      PMA_HOST: mysql
      PMA_PORT: 3306
      MYSQL_USER: oui
      MYSQL_PASSWORD: oui

  nginx:
    image: nginx
    volumes:
      - ./nginx/nginx.conf:/etc/nginx/nginx.conf
      - ./certs:/etc/nginx/certs:ro
    ports:
      - "8081:80"
      - "443:443"
    deploy:
      resources:
        limits:
          cpus: '1'
          memory: 1G

```
## C. HTTPS avec une CA maison

🌞 **Ajustez la configuration NGINX**

```nginx
server {
    [...]
    # faut changer le listen
    listen 10.7.1.103:443 ssl;

    # et ajouter ces deux lignes
    ssl_certificate /chemin/vers/le/cert/www.supersite.com.crt;
    ssl_certificate_key /chemin/vers/la/clé/www.supersite.com.key;
    [...]
}
```

```
ls certs/
CA.key  CA.srl                 pma.supersite.com.csr  v3.ext                 www.supersite.com.csr
CA.pem  pma.supersite.com.crt  pma.supersite.com.key  www.supersite.com.crt  www.supersite.com.key

```

🌞 **Prouvez avec un `curl` que vous accédez au site web**


```
 ~/D/2/l/t/php_admin   main ±   curl -k https://www.supersite.com/
meo⏎         
```

🌞 **Ajouter le certificat de la CA dans votre navigateur**


j'ai ajouté le certificat dans google chrome et je peux maintenant accéder à mon site avec le cadenas.
