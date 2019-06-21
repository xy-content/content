#!/bin/bash
file=/usr/local/nginx/conf/nginx.conf
yum -y install gcc openssl-devel pcre-devel
tar -xf lnmp_soft.tar.gz
cd lnmp_soft
tar -xf nginx-1.12.2.tar.gz
cd nginx-1.12.2
./configure  --with-http_stub_status_module   --with-http_ssl_module  --with-stream	 --with-http_stub_status_module	 --with-http_stub_status_module
make
make install
yum -y install mariadb mariadb-server mariadb-devel php php-fpm php-mysql
sed -i '65,71s/#//' $file
sed -i '/SCRIPT_FILENAME/d' $file
sed -i '/fastcgi_params/s/fastcgi_params/fastcgi.conf/' $file
/usr/local/nginx/sbin/nginx
systemctl restart mariadb.service
systemctl restart php-fpm.service
