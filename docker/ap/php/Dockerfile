FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive
RUN set -x \
 && apt update \
 && apt upgrade -y \
 && apt install -y tzdata \
 && cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
 && apt purge -y tzdata \
 && apt autoremove -y
# PHP7.3 install
RUN set -x \
 && apt install -y software-properties-common \
 && apt-add-repository -y ppa:ondrej/php \
 && apt update
RUN set -x \
 && apt install -y zip unzip \
 && apt install -y php7.4 php7.4-fpm php7.4-mysql php7.4-sqlite3 php7.4-zip php7.4-gd \
 && apt install -y mcrypt libmcrypt-dev \
 && apt install -y php7.4-mbstring php7.4-xml \
 && apt install -y php7.4-curl php7.4-json \
 && apt install -y php7.4-dev pkg-config \
 && apt install -y build-essential \
 && echo | pecl install mcrypt \
 && echo 'extension=mcrypt.so' > /etc/php/7.4/mods-available/mcrypt.ini \
 && ln -s /etc/php/7.4/mods-available/mcrypt.ini /etc/php/7.4/cli/conf.d/50-mcrypt.ini \
 && ln -s /etc/php/7.4/mods-available/mcrypt.ini /etc/php/7.4/fpm/conf.d/50-mcrypt.ini
# imagick
RUN set -x \
 && apt install -y libmagickwand-dev imagemagick \
 && echo | pecl install imagick \
 && echo 'extension=imagick.so' > /etc/php/7.4/mods-available/imagick.ini \
 && ln -s /etc/php/7.4/mods-available/imagick.ini /etc/php/7.4/cli/conf.d/50-imagick.ini \
 && ln -s /etc/php/7.4/mods-available/imagick.ini /etc/php/7.4/fpm/conf.d/50-imagick.ini
# redis
RUN set -x \
 && echo | pecl install redis \
 && echo 'extension=redis.so' > /etc/php/7.4/mods-available/redis.ini \
 && ln -s /etc/php/7.4/mods-available/redis.ini /etc/php/7.4/cli/conf.d/50-redis.ini \
 && ln -s /etc/php/7.4/mods-available/redis.ini /etc/php/7.4/fpm/conf.d/50-redis.ini
# apt clean
RUN set -x \
 && apt clean
# Composer install
RUN set -x \
 && cd /usr/local/bin \
 && curl -sS https://getcomposer.org/installer | php \
 && mv composer.phar composer  \
 && chmod +x composer
# node.js install
RUN set -x \
 && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
 && apt install -y nodejs \
 && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
 && apt update && apt install -y yarn
# Development Environment
RUN set -x \
 && groupadd -g 10000 abtc \
 && useradd -u 10000 -g abtc -m abtc \
 && mkdir -p /var/www/html && chmod 777 /var/www/html && chown abtc:abtc /var/www/html \
 && apt install -y less && mkdir /run/php && chmod 777 /run/php
USER abtc:abtc
WORKDIR /var/www/html
CMD ["/usr/sbin/php-fpm7.4", "--nodaemonize"]
