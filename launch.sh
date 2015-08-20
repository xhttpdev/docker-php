#!/bin/bash -e

sed -i -r 's/DOCKER_MAIL_DOMAIN/'"$docker_mail_domain"'/g' /etc/postfix/main.cf

/etc/init.d/postfix start
/usr/sbin/apache2 -D FOREGROUND
