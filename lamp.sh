#!/bin/bash
### Script is based off of:
### https://www.howtoforge.com/apache_php_mysql_on_centos_7_lamp

# Set up EPEL Repo for phpMyAdmin
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY*
yum -y install epel-release

# Install MariaDB
yum -y install mariadb-server mariadb
systemctl start mariadb.service
systemctl enable mariadb.service

#Set Mysql root password
mysqladmin -u root password NewPassword123
#Delete anonymous MySQL users
mysql -u root -p'NewPassword123' -e "delete from mysql.user where User='';"
#Disable remote MySQL access for root MySQL user
mysql -u root -p'NewPassword123' -e "delete from mysql.user where User='root' and host not in ('localhost', '127.0.0.1', '::1');"
#Remove the test database
mysql -u root -p'NewPassword123' -e "drop database test;"
mysql -u root -p'NewPassword123' -e "delete from mysql.db where Db='test' or Db='test\_%';"
mysql -u root -p'NewPassword123' -e "flush privileges;"

# Install Apache
yum -y install httpd
systemctl start httpd.service
systemctl enable httpd.service

firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload

# Install PHP
yum -y install php

systemctl restart httpd.service

touch /var/www/html/info.php
echo "<?php phpinfo(); ?>" > /var/www/html/info.php
chown apache:apache /var/www/html/info.php

# Install phpMyAdmin
yum -y install phpmyadmin

cat << EOF > /etc/httpd/conf.d/phpMyAdmin.conf
Alias /phpMyAdmin /usr/share/phpMyAdmin
Alias /phpmyadmin /usr/share/phpMyAdmin

<Directory /usr/share/phpMyAdmin/>
        Options none
        AllowOverride Limit
        Require all granted
</Directory>
EOF

cat << EOF > /etc/phpMyAdmin/config.inc.php
$cfg['Servers'][$i]['auth_type']     = 'http';    // Authentication method (config, http or cookie based)?
EOF

systemctl restart httpd.service

# Install OwnCloud
yum -y install unzip
#yum -y install wget
# Prepare PHP
sed -i -e "s/upload_max_filesize = 2M/upload_max_filesize = 20M/g" /etc/php.ini

systemctl restart httpd.service

# Create the database
mysql -u root -p'NewPassword123' -e "create database ocdatabase;"
mysql -u root -p'NewPassword123' -e "create user 'ocuser'@'localhost' identified by 'ocuserNewPassword123';"
mysql -u root -p'NewPassword123' -e "grant all privileges on ocdatabase.* to 'ocuser'@'localhost';"
mysql -u root -p'NewPassword123' -e "flush privileges;"

rpm --import https://download.owncloud.org/download/repositories/stable/CentOS_7/repodata/repomd.xml.key
curl -L https://download.owncloud.org/download/repositories/stable/CentOS_7/ce:stable.repo -o /etc/yum.repos.d/ownCloud.repo
yum clean expire-cache
yum -y install owncloud

#wget https://download.owncloud.org/community/owncloud-9.1.3.zip
#unzip owncloud-9.1.3.zip
#sleep 1
mv /var/www/html/owncloud/* /var/www/html/owncloud/.* /var/www/html/
#mv owncloud /var/www
#sed -i -e 's#DocumentRoot "/var/www/html"#DocumentRoot "/var/www/owncloud"#g' /etc/httpd/conf/httpd.conf
chown -R apache:apache /var/www/html

systemctl restart httpd.service
