#!/bin/bash

mv /tmp/index.html /var/www/html/

httpd -D FOREGROUND
