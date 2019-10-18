![docker_logo](https://raw.githubusercontent.com/ThomasK0lasa/docker_lamp-extended/master/img/docker_139x115.png) ![lamp_logo](https://raw.githubusercontent.com/ThomasK0lasa/docker_lamp-extended/master/img/lamp-stack_400x100.png) ![thk_logo](https://raw.githubusercontent.com/ThomasK0lasa/docker_lamp-extended/master/img/thk-logo-white_100x100.png)

This Docker container implements LAMP stack with a set of popular PHP modules, IonCube and PhpMyAdmin. The docker image was designed with persistent data volume in mind and if You don't have any data the default data will be copied to Your volumes (such as DB, Apache settings, php settings).

To select different version of PHP then default 7.3 use variable PHP_VER. To turn on IonCube use IONCUBE var. You can set different TimeZone for Ubuntu and PHP. This image was tested and used sucesfully on Synology DMS6.2 for hosting purposes (without mail part). All sugestions and comments are welcomed.

Includes the following components:
docke
 * Ubuntu 18.04 LTS Bionic Beaver base image.
 * Apache HTTP Server 2.4.29
 * MariaDB 10.1.41
 * Postfix 3.3
 * PHP 7.3 (or 5.6, 7.0, 7.2)
 * PHP modules:
 	bz2, calendar, Core, ctype, curl, date, dom, enchant, exif, fileinfo, filter, ftp, gd, gettext, gmp, hash, iconv, imap, interbase, intl, json, ldap, libxml, mbstring, mcrypt, mysqli, mysqlnd, odbc, openssl, pcntl, pcre, PDO, pdo_dblib, PDO_Firebird, pdo_mysql, PDO_ODBC, pdo_pgsql, pdo_sqlite, pgsql, Phar, posix, pspell, readline, recode, Reflection, session, shmop, SimpleXML, snmp, sockets, SPL, sqlite3, standard, sysvmsg, sysvsem, sysvshm, tidy, tokenizer, wddx, xml, xmlreader, xmlrpc, xmlwriter, xsl, Zend OPcache, zip, zlib, IonCube
 * Development tools:
	* git
	* composer
	* npm / nodejs
	* bower
	* vim
	* tree
	* nano
	* ftp
	* curl
* phpmyadmin 4.9.1

Installation from [Docker registry hub](https://hub.docker.com/r/thk1/lamp-extended).
----

You can download the image using the following command:

```bash
docker pull thk1/lamp-extended
```

Environment variables
----

This image uses environment variables to allow the configuration of some parameteres at run time:

* Variable name: **TIMEZONE**
* Default value: **UTC**
* Accepted values: Any of Ubuntu supported time zones - [ubuntu timezones](http://manpages.ubuntu.com/manpages/trusty/man3/DateTime::TimeZone::Catalog.3pm.html).
* Description: Sets the Ubuntu system timezone
* Concerns: Docker \ Ubuntu

----

* Variable name: **PHP_VER**
* Default value: **7.3**
* Accepted values: 5.6, 7.0, 7.2, 7.3
* Description: Selected version will be started on container run.
* Concerns: PHP

----

* Variable name: **LOG_STDOUT**
* Default value: **Empty string.**
* Accepted values: Any string to enable, empty string or not defined to disable.
* Description: Output Apache access log through STDOUT, so that it can be accessed through the [container logs](https://docs.docker.com/reference/commandline/logs/).
* Concerns: Docker \ Ubuntu \ Apache

----

* Variable name: **LOG_STDERR**
* Default value: **Empty string.**
* Accepted values: Any string to enable, empty string or not defined to disable.
* Description: Output Apache error log through STDERR, so that it can be accessed through the [container logs](https://docs.docker.com/reference/commandline/logs/).
* Concerns: Docker \ Ubuntu \ Apache

----

* Variable name: **LOG_LEVEL**
* Default value: **warn**
* Accepted values: debug, info, notice, warn, error, crit, alert, emerg
* Description: Value for Apache's [LogLevel directive](http://httpd.apache.org/docs/2.4/en/mod/core.html#loglevel).
* Concerns: Apache

----

* Variable name: **WWW_INDEXING**
* Default value: **FALSE**
* Accepted values: TRUE, FALSE
* Description: Used to enable (`TRUE`) or disable (`FALSE`) the Apache indexing of files.
* Concerns: Apache

----

* Variable name: **ALLOW_OVERRIDE**
* Default value: **All**
* Accepted values: All, None - value for Apache's [AllowOverride directive](http://httpd.apache.org/docs/2.4/en/mod/core.html#allowoverride).
* Description: Used to enable (`All`) or disable (`None`) the usage of an `.htaccess` file.
* Concerns: Apache

----

* Variable name: **X_FORWARDED_HEADER**
* Default value: **TRUE**
* Accepted values: TRUE, FALSE
* Description: Enables logging of X-forwarded-header (instead of client address ip) in apache2 access.log.
* Concerns: Apache

----

* Variable name: **ADD_USR**
* Default value: **TRUE**
* Accepted values: TRUE, FALSE
* Description: User with root rights of selected name and password will be added to MariaDB.
* Concerns: MariaDB

----

* Variable name: **DBLOGIN**
* Default value: **phpmyadmin**
* Accepted values: Any (not recommended to use special characters, prohibited to use spaces)
* Description: The name of new user in DB.
* Concerns: MariaDB

----

* Variable name: **DBPASS**
* Default value: **PassPlaceholder**
* Accepted values: Any (not recommended to use special characters, prohibited to use spaces) or leave PassPlaceholder to get new automatically generated password.
* Description: Password for new user in DB.
* Concerns: MariaDB

----

* Variable name: **DBROOT_PASS**
* Default value: **PassPlaceholder**
* Accepted values: Any (not recommended to use special characters, prohibited to use spaces) or leave PassPlaceholder to get new automatically generated password.
* Description: Password for 'root' user in DB.
* Concerns: MariaDB

----

* Variable name: **IONCUBE**
* Default value: **FALSE**
* Accepted values: TRUE, FALSE
* Description: Set (`TRUE`) if You want support of IonCube in PHP or leave as it is (`FALSE`) to ignore
* Concerns: PHP

----

* Variable name: **DATE_TIMEZONE**
* Default value: **UTC**
* Accepted values: Any of PHP's [supported timezones](http://php.net/manual/en/timezones.php)
* Description: Set php.ini default date.timezone directive and sets MariaDB as well. This can be set different then TIMEZONE for system.
* Concerns: PHP

----

* Variable name: **DEFAULT_PHPINI**
* Default value: **FALSE**
* Accepted values: TRUE, FALSE
* Description: Will override (`TRUE`) any existing php.ini with default one
* Concerns: PHP

----

* Variable name: **PHP_OPTIONS_OVERRIDE**
* Default value: **TRUE**
* Accepted values: TRUE, FALSE
* Description: Will override (`TRUE`) specific php.ini settings depending on variables - SHORT_TAGS, UPLOAD_MAX_FILESIZE, POST_MAX_SIZE, MEMORY_LIMIT, MAX_EXECUTION_TIME, MAX_INPUT_VARS and MAX_INPUT_TIME
* Concerns: PHP

----

* Variable name: **SHORT_TAGS**
* Default value: **FALSE**
* Accepted values: TRUE, FALSE
* Description: Turn on or off php short tags handling. This option will be overrided in php.ini
* Concerns: PHP
* Condition: If PHP_OPTIONS_OVERRIDE won't be set to TRUE this variable will be ignored

----

* Variable name: **UPLOAD_MAX_FILESIZE**
* Default value: **34M**
* Accepted values: Shorthand byte value or IGNORE
* Description: [Shorthand byte value](https://www.php.net/manual/en/faq.using.php#faq.using.shorthandbytes). This option will be overrided in php.ini or won't (if set to `IGNORE`)
* Concerns: PHP
* Condition: If PHP_OPTIONS_OVERRIDE won't be set to TRUE this variable will be ignored

----

* Variable name: **POST_MAX_SIZE**
* Default value: **48M**
* Accepted values: Shorthand byte value or IGNORE
* Description: [Shorthand byte value](https://www.php.net/manual/en/faq.using.php#faq.using.shorthandbytes). This option will be overrided in php.ini or won't (if set to `IGNORE`)
* Concerns: PHP
* Condition: If PHP_OPTIONS_OVERRIDE won't be set to TRUE this variable will be ignored

----

* Variable name: **MEMORY_LIMIT**
* Default value: **128M**
* Accepted values: Shorthand byte value or IGNORE
* Description: [Shorthand byte value](https://www.php.net/manual/en/faq.using.php#faq.using.shorthandbytes). This option will be overrided in php.ini or won't (if set to `IGNORE`)
* Concerns: PHP
* Condition: If PHP_OPTIONS_OVERRIDE won't be set to TRUE this variable will be ignored

----

* Variable name: **MAX_EXECUTION_TIME**
* Default value: **600**
* Accepted values: Integer or IGNORE
* Description: Time in seconds. This option will be overrided in php.ini or won't (if set to `IGNORE`)
* Concerns: PHP
* Condition: If PHP_OPTIONS_OVERRIDE won't be set to TRUE this variable will be ignored

----

* Variable name: **MAX_INPUT_VARS**
* Default value: **10000**
* Accepted values: Integer or IGNORE
* Description: This option will be overrided in php.ini or won't (if set to `IGNORE`)
* Concerns: PHP
* Condition: If PHP_OPTIONS_OVERRIDE won't be set to TRUE this variable will be ignored

----

* Variable name: **MAX_INPUT_TIME**
* Default value: **400**
* Accepted values: Integer or IGNORE
* Description: This option will be overrided in php.ini or won't (if set to `IGNORE`)
* Concerns: PHP
* Condition: If PHP_OPTIONS_OVERRIDE won't be set to TRUE this variable will be ignored

----

* Variable name: **WWWDATA_USR_ID**
* Default value: **33**
* Concerns: Apache \ Ubuntu
* Accepted values: Integer
* Description: Sets id for Apache user in docker container

----

* Variable name: **WWWDATA_GRP_ID**
* Default value: **33**
* Concerns: Apache \ Ubuntu
* Accepted values: Integer
* Description: Sets id for Apache group in docker container

----

* Variable name: **TERM**
* Default value: **xterm-256color**
* Concerns: Docker \ Ubuntu
* Accepted values:
* Description: TERM variable stores the name of an entry in the terminfo database that helps the OS determine how to display information to your terminal

----

* Variable name: **POSTFIX_START**
* Default value: **FALSE**
* Concerns: Postfix
* Accepted values: TRUE, FALSE
* Description: Starts postfix service

----

* Variable name: **PHP_MODULES**
* Default value: **bz2 cgi cli common curl dev enchant fpm gd gmp imap interbase intl json ldap mbstring mysql mysqli odbc opcache pdo pgsql phpdbg pspell readline recode snmp sqlite3 sybase tidy xmlrpc xsl zip**
* Accepted values: Any of php modules separated by space. To get list of available modules use - apt-cache search php7.3
* Description: This variable allows for quick module selection. This only works for Docker image BUILD!
* Concerns: PHP

----

* Variable name: **PHPMYADMIN_VERSION**
* Default value: **4.9.1**
* Accepted values: Any of oficial PhpMyAdmin version
* Description: This variable allows for quick PhpMyAdmin selection. This only works for Docker image BUILD!
* Concerns: PhpMyAdmin


Exposed port and volumes
----

The image exposes ports `80` and `3306`, and exports such volumes:

* `/var/log/apache2`, containing Apache log files.
* `/var/log/mysql` containing MariaDB log files.
* `/var/log/php_bkp` php settings are copied here (ICE) before being overrided.
* `/var/www/html`, used as Apache's [DocumentRoot directory](http://httpd.apache.org/docs/2.4/en/mod/core.html#documentroot).
* `/var/lib/mysql`, where MariaDB data files are stored.
* `/etc/apache2`, where Apache configuration files are stored.
For php.ini read notice below!
* `/etc/php/5.6/apache2`, where PHP5.6 initialization files are stored.
* `/etc/php/7.0/apache2`, where PHP7.0 initialization files are stored.
* `/etc/php/7.2/apache2`, where PHP7.2 initialization files are stored.
* `/etc/php/7.3/apache2`, where PHP7.3 initialization files are stored.

Notice: The default ini files are different depending on PHP version. You don't need to map all of them. Only map the one for Your selected version of PHP. // *TO-DO: This could be simplified more*

Please, refer to https://docs.docker.com/storage/volumes for more information on using host volumes.

The user and group owner id for the DocumentRoot directory `/var/www/html` are both by default 33 (use WWWDATA_USR_ID and WWWDATA_GRP_ID variables to change them) (`uid=33(www-data) gid=33(www-data) groups=33(www-data)`).

The user and group owner id for the MariaDB directory `/var/log/mysql` are 105 and 108 repectively (`uid=105(mysql) gid=108(mysql) groups=108(mysql)`).

Use cases
----

#### Create a temporary container for testing purposes:

```
	docker run -i -t --rm thk1/lamp-extended /usr/sbin/run-lamp.sh &
```

#### Create a temporary container to debug a web app:

```
	docker run --rm -p 8080:80 -e LOG_STDOUT=true -e LOG_STDERR=true -e LOG_LEVEL=debug -v /my/data/directory:/var/www/html thk1/lamp-extended
```

#### Create a temporary container with different PHP version and access to php.ini:

```
	docker run -i -t -p 8080:80 -e PHP_VER=7.0 -v /my/data/directory:/var/www/html -v /my/php/ini:/etc/php/7.0/apache2 thk1/lamp-extended
```

#### Create a container linking to another [MySQL container](https://registry.hub.docker.com/_/mysql/):

```
	docker run -d --link my-mysql-container:mysql -p 8080:80 -v /my/data/directory:/var/www/html -v /my/logs/directory:/var/log/apache2 --name my-lamp-container thk1/lamp-extended
```

#### Get inside a running container and open a MariaDB console:

```
	docker exec -i -t my-lamp-container bash
	mysql -u root
```

Credits
----
This image was originally branched from:
* Fer Uría LAMP container: https://hub.docker.com/r/fauria/lamp
* Matt Rayner LAMP container: https://github.com/mattrayner/docker-lamp
