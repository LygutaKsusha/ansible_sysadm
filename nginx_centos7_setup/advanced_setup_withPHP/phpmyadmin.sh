#!/bin/bash

cd /tmp
wget https://files.phpmyadmin.net/phpMyAdmin/4.6.5.2/phpMyAdmin-4.6.5.2-all-languages.tar.gz
tar xvzf phpMyAdmin-4.6.5.2-all-languages.tar.gz
mv phpMyAdmin-4.6.5.2-all-languages phpmyadmin
mv phpmyadmin /usr/share
