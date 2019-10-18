#!/bin/bash

VER=$1

mkdir /usr/lib/php/ioncube
# ioncube loader
curl -fSL 'http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz' -o ioncube.tar.gz \
        && mkdir -p ioncube \
        && tar -xf ioncube.tar.gz -C ioncube --strip-components=1 \
        && rm ioncube.tar.gz \
        && mv ioncube/ioncube_loader_lin_${VER}.so /usr/lib/php/ioncube/ioncube_loader_lin_${VER}.so \
        && rm -r ioncube

echo 'zend_extension = "/usr/lib/php/ioncube/ioncube_loader_lin_'${VER}'.so"' >> /etc/php/${VER}/apache2/conf.d/00-ioncube.ini