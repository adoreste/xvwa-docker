FROM tutum/lamp:latest

ENV DEBIAN_FRONTEND noninteractive

# Preparation
RUN rm -fr /app/*
RUN apt-get update
RUN apt-get install -yqq supervisor git apache2 libapache2-mod-php5 mysql-server php5-mysql pwgen php-apc php5-mcrypt
RUN rm -rf /var/lib/apt/lists/*

# Deploy xVWA
RUN git clone https://github.com/s4n7h0/xvwa /app/xvwa 
ENV PHP_UPLOAD_MAX_FILESIZE 10M
ENV PHP_POST_MAX_SIZE 10M
ENV MYSQLU admin
ENV MYSQLP password
ENV WEBROOT /app/xvwa
RUN chown www-data:www-data -R $WEBROOT
RUN chmod -R 777 $WEBROOT
RUN sed -i '2 c $XVWA_WEBROOT = "";' /app/xvwa/config.php
RUN sed -i '5 c $user = "'$MYSQLU'";' /app/xvwa/config.php
RUN sed -i '6 c $pass = "'$MYSQLP'";' /app/xvwa/config.php
RUN sed -ie 's/allow_url_include = Off/allow_url_include = On/g' /etc/php5/apache2/php.ini
RUN a2enmod include
RUN a2enmod actions
RUN a2enmod cgi
RUN a2enmod cgid
RUN a2enmod dav 
RUN a2enmod dav_fs
COPY ./configs/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY ./configs/apache2.conf /etc/apache2/apache2.conf
COPY ./configs/create_mysql_admin_user.sh /create_mysql_admin_user.sh
RUN chmod +x /create_mysql_admin_user.sh

EXPOSE 80 3306
CMD ["/run.sh"]
