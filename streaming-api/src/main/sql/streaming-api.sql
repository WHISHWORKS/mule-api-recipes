CREATE USER 'bc_user'@'%' IDENTIFIED BY 'password';
CREATE DATABASE salesforce_contacts CHARACTER SET utf8;
GRANT ALL PRIVILEGES ON salesforce_contacts.* TO 'bc_user'@'%' IDENTIFIED BY 'password';
USE salesforce_contacts;
CREATE TABLE sfdcevent  (Id varchar (255), FirstName varchar (255), LastName varchar (255), Email varchar (255));
select * from sfdcevent;