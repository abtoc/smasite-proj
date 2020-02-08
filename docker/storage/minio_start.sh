#!/bin/bash
if [ -z "$(ls /var/lib/minio)" ]; then
    mkdir /var/lib/minio/smasite
fi
/usr/local/bin/minio server -C /etc/minio --address 0.0.0.0:9000 /var/lib/minio
