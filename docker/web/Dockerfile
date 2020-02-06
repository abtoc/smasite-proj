FROM ubuntu:18.04
RUN set -x \
 && apt update \
 && apt upgrade -y \
 && apt install -y tzdata \
 && cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
 && apt purge -y tzdata \
 && apt autoremove -y
# nginx install
RUN set -x \
 && apt install -y nginx
# Development Environment
RUN set -x \
 && rm -rf /var/log/nginx/access.log && ln -s /dev/stdout /var/log/nginx/access.log \
 && rm -rf /var/log/nginx/error.log  && ln -s /dev/stderr /var/log/nginx/error.log
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]

