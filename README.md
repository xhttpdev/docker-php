# docker-php
Docker Image with Apache + PHP + Postfix

Includes:
- MongoDb extension

## Example configuration ##

`docker-compose.yml`

    app:
        image: xhttpdev/docker-php
        ports:
            - "80:80"
        volumes:
            - /var/www/myapp:/var/www/html
        environment:
            docker_mail_domain: "mydomain.com"
