# docker-php
Docker Image with Apache + PHP + Composer + Postfix

Includes:
- MongoDb extension
- MySql extension
- npm
- bower
- grunt
- ruby
- compass

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

### OnBuild ###

copies current directory to `/var/www/html` and owner is changed to `www-data`

    app:
        image: xhttpdev/docker-php:onbuild
        ports:
            - "80:80"
        environment:
            docker_mail_domain: "mydomain.com"
