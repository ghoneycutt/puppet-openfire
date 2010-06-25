create database if not exists openfire;
create user 'openfire'@'localhost' identified by 'badpassword';
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE on openfire.* to 'openfire'@'localhost';

