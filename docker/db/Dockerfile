FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive
RUN set -x \
 && apt update \
 && apt upgrade -y \
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
RUN mkdir /var/run/mysqld && chown mysql:mysql /var/run/mysqld 
# && sed -i -e 's/127\.0\.0\.1/0\.0\.0\.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf
RUN mkdir /initdb.d
RUN rm -rf /var/lib/mysql/*
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"]

