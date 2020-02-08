CREATE DATABASE IF NOT EXISTS smasite CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS 'smasite'@'%' IDENTIFIED BY 'smasite';
GRANT ALL ON smasite.* TO 'smasite'@'%';
