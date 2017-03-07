CREATE USER 'bc_user'@'%' IDENTIFIED BY 'password';
CREATE DATABASE business_events CHARACTER SET utf8;
GRANT ALL PRIVILEGES ON business_events.* TO 'bc_user'@'%' IDENTIFIED BY 'password';
USE book_catalogue;
CREATE TABLE orders (id int, order_status varchar(255), operator varchar(255), price varchar(255));
