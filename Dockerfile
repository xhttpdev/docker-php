FROM php:5.6-apache

RUN apt-get -yqq update
RUN DEBIAN_FRONTEND=noninteractive apt-get -yqq install curl git vim libsasl2-dev libxml2-dev zlib1g-dev php5-xdebug libssl-dev php5-redis php5-memcache

# ruby
RUN DEBIAN_FRONTEND=noninteractive apt-get -yqq install ruby-full build-essential

RUN apt-get autoclean

# compass
RUN gem install compass

# npm
RUN mkdir /nodejs
RUN curl -Lks https://nodejs.org/dist/v4.2.4/node-v4.2.4-linux-x64.tar.gz -o /nodejs.tar.gz
RUN tar zxf /nodejs.tar.gz --strip=1 -C /nodejs
RUN ln -s /nodejs/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm
RUN ln -s /nodejs/bin/node /usr/local/bin/

# bower
RUN npm install -g bower

# grunt
RUN npm install -g grunt-cli

# composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

# php extensions
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install zip
RUN docker-php-ext-install soap
RUN docker-php-ext-install ftp

ADD app.conf /etc/apache2/sites-available/000-default.conf
RUN a2ensite 000-default

# Enable apache mods.
RUN a2enmod rewrite

# mongo db extension
RUN pecl install mongodb

# ini files
ADD php.ini /usr/local/etc/php/

ADD ServerName.conf /etc/apache2/conf-available/ServerName.conf
RUN a2enconf ServerName
RUN a2disconf javascript-common

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2

RUN mkdir -p $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_LOG_DIR

RUN touch /var/log/apache2/php.log
RUN chown www-data:www-data /var/log/apache2/php.log

WORKDIR /var/www/html

EXPOSE 80
