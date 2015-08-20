# docker-php
Docker Image with Apache + PHP + Postfix

Includes:
- MongoDb extension

## Example configuration ##

`docker-compose.yml`

### Development ###

    app:
        image: xhttpdev/docker-php:dev
        ports:
            - "80:80"
        volumes:
            - /var/www/myapp:/var/www/html
        environment:
            docker_mail_domain: "mydomain.com"

### Production ###

No Volume available

    app:
        image: xhttpdev/docker-php:latest
        ports:
            - "80:80"
        environment:
            docker_mail_domain: "mydomain.com"
