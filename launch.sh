#!/bin/bash -e

chown -R www-data:www-data .

/usr/sbin/apache2 -D FOREGROUND