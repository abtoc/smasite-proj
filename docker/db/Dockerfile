FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive
RUN set -x \
 && apt update \
 && apt upgrade -y \
 && apt-get install -y locales \
 && locale-gen ja_JP.UTF-8 \
 && apt install -y tzdata \
 && cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
 && apt purge -y tzdata \
 && apt autoremove -y
ENV TZ=Asia/Tokyo
# mariadb install
RUN set -x \
 && apt-get install -y software-properties-common \
 && apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8 \
 && add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://ftp.yz.yamagata-u.ac.jp/pub/dbms/mariadb/repo/10.2/ubuntu xenial main' \
 && apt update \
 && echo "mariadb-server-10.2 mysql-server/root_password password 'unused'" | debconf-set-selections \
 && echo "mariadb-server-10.2 mysql-server/root_password_again password 'unused'" | debconf-set-selections \
 && apt install -y mariadb-server-10.2
RUN mkdir /var/run/mysqld && chown mysql:mysql /var/run/mysqld \
 && mkdir /initdb.d \
 && rm -rf /var/lib/mysql/*
# phpmyadmin
# node.js install
RUN set -x \
 && apt install -y curl \
 && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
 && apt install -y nodejs \
 && npm install -g yarn
RUN set -x\
 && apt install -y apache2 curl \
 && apt install -y php-mbstring php-gettext libapache2-mod-php php-mysql php-curl php-zip \
 && phpenmod mbstring \
 && a2enmod rewrite \
 && curl -kLRs https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && chmod +x /usr/local/bin/composer \
 && rm -rf /var/www/html \
 && cd /var/www \
 && composer create-project phpmyadmin/phpmyadmin html \
 && cd /var/www/html \
 && composer update --no-dev \
 && yarn install \
 && chown -R www-data:www-data /var/www/html
# supervisor
RUN apt install -y supervisor
# Development Evironment
COPY mariadb_start.sh /mariadb_start.sh
COPY phpmyadmin_start.sh /phpmyadmin_start.sh
RUN chmod +x /mariadb_start.sh \
 && chmod +x /phpmyadmin_start.sh
COPY supervisor.d/10-mariadb.conf /etc/supervisor/conf.d/
COPY supervisor.d/20-phpmyadmin.conf /etc/supervisor/conf.d/
#COPY phpmyadmin/sql.lib.php /usr/share/phpmyadmin/libraries/sql.lib.php
CMD ["/usr/bin/supervisord", "-n"]
