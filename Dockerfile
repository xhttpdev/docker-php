FROM php:apache

RUN apt-get -yqq update
RUN DEBIAN_FRONTEND=noninteractive apt-get -yqq install apache2 libapache2-mod-php5 libapache2-mod-auth-mysql php5-mysql php5-sqlite curl php5-curl php5-dev php5-intl git vim postfix
RUN apt-get autoclean

ADD postfix/main.cf /etc/postfix/main.cf
ADD postfix/master.cf /etc/postfix/master.cf

RUN docker-php-ext-install mbstring
RUN docker-php-ext-install zip

# Enable apache mods.
RUN a2enmod rewrite

ADD app.conf /etc/apache2/sites-available/000-default.conf
RUN a2ensite 000-default

ADD ServerName.conf /etc/apache2/conf-available/ServerName.conf
RUN a2enconf ServerName

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2

RUN mkdir -p $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_LOG_DIR

# Install PEAR und PECL
RUN curl -O http://pear.php.net/go-pear.phar
RUN php -d detect_unicode=0 go-pear.phar
# Install mongo extension
RUN pecl install mongo

WORKDIR /var/www/html

ADD launch.sh /launch

EXPOSE 80

CMD [ "/launch" ]
