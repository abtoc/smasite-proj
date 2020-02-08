#!/bin/bash

temp_db_start(){
    echo "Starting database"
    mysql_install_db
    mysqld --skip-networking &
    local i
    for i in {30..0}; do
        mysqladmin ping
        if [ $? -eq 0 ]; then
            break;
        fi
        sleep 1
    done
    if [ $i -eq 0 ]; then
        echo "Unable to start server."
        exit 1
    fi
}

temp_db_stop(){
    echo "Stopping database"
    mysqladmin shutdown -u root -p${MYSQL_ROOT_PASSWORD}
    if [ $? -ne 0 ]; then
        echo 'Unable to shut down server.'
        exit 1
    fi
}

secure_init(){
    echo "Security Initalize"
    mysql -u root <<< "
         UPDATE mysql.user SET Password=PASSWORD('${MYSQL_ROOT_PASSWORD}') WHERE User='root';
         DELETE FROM mysql.user WHERE User='';
         DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
         DROP DATABASE IF EXISTS test;
         DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
         FLUSH PRIVILEGES;"
}

init_files(){
    echo "File Initalize"
    files=$(find /init.db -maxdepth 1 -type f)
    for f in $files; do
        case "$f" in
            *.sh)  . "$f";;
            *.sql) mysql -u root -p${MYSQL_ROOT_PASSWORD} <"$f";;
        esac
    done
}

_main(){
    if [ -z "$(ls /var/lib/mysql)" ]; then
        echo "Initailize database."
        temp_db_start
        secure_init
        init_files
        temp_db_stop
    fi
    exec mysqld
}

_main
