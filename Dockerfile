FROM ubuntu:14.04

RUN apt-get -yqq update
RUN DEBIAN_FRONTEND=noninteractive apt-get -yqq install apache2 libapache2-mod-php5 libapache2-mod-auth-mysql php5-mysql php5-sqlite curl php5-curl git vim postfix
RUN apt-get autoclean

ADD postfix/main.cf /etc/postfix/main.cf
ADD postfix/master.cf /etc/postfix/master.cf

# Enable apache mods.
RUN a2enmod php5
RUN a2enmod rewrite

RUN sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php5/apache2/php.ini
RUN sed -i "s/error_reporting = .*$/error_reporting = E_ALL/" /etc/php5/apache2/php.ini

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

WORKDIR /var/www/html

VOLUME ["/var/www/html"]

ADD launch.sh /launch

EXPOSE 80

CMD [ "/launch" ]
