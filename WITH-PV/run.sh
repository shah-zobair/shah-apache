#!/bin/bash

mv /tmp/html/* /var/www/html/

httpd -D FOREGROUND
