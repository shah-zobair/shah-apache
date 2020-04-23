#FROM rhel7
FROM registry.access.redhat.com/ubi8:8.1
#FROM openshift/rhel7

#RUN echo "yum-master.example.com" > /etc/yum/vars/build_server && \
#    echo "rhel7-latest" > /etc/yum/vars/buildtag && \
#    echo "prod" > /etc/yum/vars/environment && \
#    echo "latest" > /etc/yum/vars/patchlevel

#ADD container.repo /etc/yum.repos.d/


RUN yum --disablerepo='*' --enablerepo=rhel-7-server-rpms --enablerepo=rhel-7-server-extras-rpms update -y && \
    yum --disablerepo='*' --enablerepo=rhel-7-server-rpms --enablerepo=rhel-7-server-extras-rpms install -y httpd mod_rewrite php php-bcmath php-cli php-common php-devel php-mysql php-odbc php-pdo  php-pspell php-pgsqlphp-ldap php-mbstring php-gd mod_ssl && yum clean all

#RUN usermod apache -u 1001
RUN cat /etc/passwd

RUN groupadd cloud -g 1001 \
 && useradd cloud -u 1001 -g 1001 \
 && chown -R cloud:cloud /var/log/httpd \
 && chown -R cloud:cloud /etc/httpd \
 && chmod -R 777 /var/run/httpd \
 && chmod -R 777 /var/log/httpd \
 && chmod -R 777 /etc/httpd \
 && chmod -R 777 /etc/pki \
&& chown -R cloud.cloud /var/www/html 

RUN sed -i 's/User apache/User cloud/g' /etc/httpd/conf/httpd.conf \
 && sed -i 's/Group apache/Group cloud/g' /etc/httpd/conf/httpd.conf \
 && sed -i 's/Listen 80/Listen 8080/g' /etc/httpd/conf/httpd.conf \
 && sed -i 's/Listen 443/Listen 8443/g' /etc/httpd/conf.d/ssl.conf \
 && sed -i 's/VirtualHost _default_:443/VirtualHost _default_:8443/g' /etc/httpd/conf.d/ssl.conf

RUN ln -sf /dev/stdout /etc/httpd/logs/access_log \
 && ln -sf /dev/stderr /etc/httpd/logs/error_log

USER 1001
EXPOSE 8080

COPY index.html /var/www/html/
COPY bee.gif /var/www/html/

CMD ["httpd", "-D", "FOREGROUND"]
