FROM openshift/rhel7


#RUN echo "yum-master.example.com" > /etc/yum/vars/build_server && \
#    echo "rhel7-latest" > /etc/yum/vars/buildtag && \
#    echo "prod" > /etc/yum/vars/environment && \
#    echo "latest" > /etc/yum/vars/patchlevel

#ADD container.repo /etc/yum.repos.d/

RUN yum --disablerepo='*' --enablerepo=rhel-7-server-rpms --enablerepo=rhel-7-server-extras-rpms update -y && \
    yum --disablerepo='*' --enablerepo=rhel-7-server-rpms --enablerepo=rhel-7-server-extras-rpms install -y httpd mod_rewrite php php-bcmath php-cli php-common php-devel php-mysql php-odbc php-pdo  php-pspell php-pgsqlphp-ldap php-mbstring php-gd mod_ssl && yum clean all

RUN useradd 1001

COPY run.sh /tmp/
COPY index.html /tmp/

RUN chown -R 1001:1001 /var/log/httpd && chown -R 1001:1001 /etc/httpd && chown -R 1001:1001 /var/www/html && \
    chmod -R 777 /var/run/httpd && chmod -R 777 /var/log/httpd && chmod -R 777 /etc && \
    chown -R 1001:1001 /tmp/html && chmod 777 /tmp/run.sh && chmod -R 777 /var/www/html && \
    chmod -R 777 /tmp/htmlRUN sed -i 's/User apache/User 1001/g' /etc/httpd/conf/httpd.conf && \
    sed -i 's/Group apache/Group 1001/g' /etc/httpd/conf/httpd.conf && \
    sed -i 's/Listen 80/Listen 8080/g' /etc/httpd/conf/httpd.conf && \
    sed -i 's/Listen 443/Listen 8443/g' /etc/httpd/conf.d/ssl.conf && \
    sed -i 's/VirtualHost _default_:443/VirtualHost _default_:8443/g' /etc/httpd/conf.d/ssl.conf

USER 1001

EXPOSE 8080
