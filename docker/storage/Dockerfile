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
# minio install
RUN set -x \
 && apt install -y curl \
 && curl https://dl.minio.io/server/minio/release/linux-amd64/minio -o /usr/local/bin/minio && chmod +x /usr/local/bin/minio \
 && curl https://dl.minio.io/client/mc/release/linux-amd64/mc -o /usr/local/bin/mc && chmod +x /usr/local/bin/mc \
 && mkdir /var/lib/minio \
 && mkdir /etc/minio
COPY minio_start.sh /minio_start.sh
RUN set -x \
 && chmod +x /minio_start.sh
CMD ["/minio_start.sh"]


