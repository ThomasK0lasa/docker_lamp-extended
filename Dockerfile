FROM ubuntu:18.04
MAINTAINER Thomas K <kolasa.at.work@gmail.com>
LABEL Description="Cutting-edge LAMP stack, based on Ubuntu 18.04.03 LTS. Includes PHP version selection, .htaccess support and popular PHP features, including composer, IonCube, PhpMyAdmin and mail() function." \
	License="Apache License 2.0" \
	Usage="docker run -d -p [HOST WWW PORT NUMBER]:80 -p [HOST DB PORT NUMBER]:3306 -v [HOST WWW DOCUMENT ROOT]:/var/www/html -v [HOST DB DOCUMENT ROOT]:/var/lib/mysql thk1/lamp-extended" \
	Version="1.0"

RUN apt-get update
RUN apt-get upgrade -y

COPY debconf.selections /tmp/
RUN debconf-set-selections /tmp/debconf.selections

ENV TIMEZONE UTC
ENV PHP_MODULES "bz2 cgi cli common curl dev enchant fpm gd gmp imap interbase intl json ldap mbstring mcrypt mysql mysqli odbc opcache pdo pgsql phpdbg pspell readline recode snmp sqlite3 sybase tidy xmlrpc xsl zip"

RUN apt-get install -y zip unzip wget
RUN apt install software-properties-common -y
RUN add-apt-repository ppa:ondrej/php -y && apt update -y
RUN export DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y tzdata
RUN apt-get install iputils-ping inetutils-traceroute telnet tcpdump -y
RUN dpkg-reconfigure --frontend noninteractive tzdata
RUN apt-get install apache2 libapache2-mod-php${PHP_VER} -y
COPY php-install.sh /usr/sbin/
RUN chmod +x /usr/sbin/php-install.sh
RUN /usr/sbin/php-install.sh 5.6
RUN /usr/sbin/php-install.sh 7.0
RUN /usr/sbin/php-install.sh 7.2
RUN /usr/sbin/php-install.sh 7.3
RUN apt-get install mariadb-common mariadb-server mariadb-client -y
RUN apt-get install postfix -y
RUN apt-get install git nodejs npm composer nano tree vim curl ftp -y
RUN npm install -g webpack grunt-cli gulp
# composer
RUN curl -S https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && composer self-update;

# Add phpmyadmin
ENV PHPMYADMIN_VERSION 4.9.1
RUN wget -O /tmp/phpmyadmin.tar.gz https://files.phpmyadmin.net/phpMyAdmin/${PHPMYADMIN_VERSION}/phpMyAdmin-${PHPMYADMIN_VERSION}-all-languages.tar.gz
RUN tar xfvz /tmp/phpmyadmin.tar.gz -C /var/www
RUN ln -s /var/www/phpMyAdmin-${PHPMYADMIN_VERSION}-all-languages /var/www/phpmyadmin
RUN mv /var/www/phpmyadmin/config.sample.inc.php /var/www/phpmyadmin/config.inc.php
RUN sed -i "17s/.*/\$cfg[\'blowfish_secret\'] = \'0KHv0V-uaNxlYQLrkt7uNWjyw,ejXRVX\';/" /var/www/phpmyadmin/config.inc.php
RUN mkdir /var/www/phpmyadmin/tmp
RUN chmod 777 /var/www/phpmyadmin/tmp

ADD apache_default /etc/apache2/sites-available/000-default.conf
COPY php-ioncube.sh /usr/sbin/
RUN chmod +x /usr/sbin/php-ioncube.sh
RUN /usr/sbin/php-ioncube.sh 5.6
RUN /usr/sbin/php-ioncube.sh 7.0
RUN /usr/sbin/php-ioncube.sh 7.2
RUN /usr/sbin/php-ioncube.sh 7.3
RUN cp -a /etc/apache2/. /tmp/apache2
RUN mkdir /tmp/php/
RUN cp -a /etc/php/5.6/apache2/. /tmp/php/5.6
RUN cp -a /etc/php/7.0/apache2/. /tmp/php/7.0
RUN cp -a /etc/php/7.2/apache2/. /tmp/php/7.2
RUN cp -a /etc/php/7.3/apache2/. /tmp/php/7.3

# colors for terminal
ENV TERM xterm-256color
ENV POSTFIX_START FALSE

# apache settings
ENV LOG_STDOUT **Boolean**
ENV LOG_STDERR **Boolean**
ENV LOG_LEVEL warn
ENV WWW_INDEXING FALSE
ENV ALLOW_OVERRIDE All
ENV X_FORWARDED_HEADER TRUE
# db settings
ENV ADD_USR TRUE
ENV DBLOGIN phpmyadmin
ENV DBPASS PassPlaceholder
ENV DBROOT_PASS PassPlaceholder
#php settings
ENV PHP_VER 7.3
ENV PHP_ENABLE_MODS "rewrite headers expires"
ENV IONCUBE FALSE
ENV DATE_TIMEZONE UTC
ENV DEFAULT_PHPINI FALSE
ENV PHP_OPTIONS_OVERRIDE TRUE
ENV SHORT_TAGS FALSE
ENV UPLOAD_MAX_FILESIZE 34M
ENV POST_MAX_SIZE 48M
ENV MEMORY_LIMIT 128M
ENV MAX_EXECUTION_TIME 600
ENV MAX_INPUT_VARS 10000
ENV MAX_INPUT_TIME 400
ENV WWWDATA_USR_ID 33
ENV WWWDATA_GRP_ID 33

COPY run-lamp.sh /usr/sbin/
RUN chmod +x /usr/sbin/run-lamp.sh

VOLUME /var/www/html
VOLUME /var/log/apache2
VOLUME /var/lib/mysql
VOLUME /var/log/mysql
VOLUME /var/log/php_bkp
VOLUME /etc/apache2
VOLUME /etc/php/5.6/apache2/
VOLUME /etc/php/7.0/apache2/
VOLUME /etc/php/7.2/apache2/
VOLUME /etc/php/7.3/apache2/

EXPOSE 80
EXPOSE 443
EXPOSE 3306

CMD ["/usr/sbin/run-lamp.sh"]
