CREATE USER 'bc_user'@'%' IDENTIFIED BY 'password';
CREATE DATABASE book_catalogue CHARACTER SET utf8;
GRANT ALL PRIVILEGES ON book_catalogue.* TO 'bc_user'@'%' IDENTIFIED BY 'password';
USE book_catalogue;
CREATE TABLE books (Id int, Title varchar (255), Author varchar (255), Price varchar (255));
