# Fluentd-MySQL

## Overview

This Fluentd Configuration file allows a local machine to send Syslog to a Remote MYSQL Server

## Requirements

| fluent-plugin-sql | fluentd    | ruby   |
|-------------------|------------|--------|
| >= 1.0.0          | >= v0.14.4 | >= 2.1 |
| <  1.0.0          | <  v0.14.0 | >= 1.9 |

# Operating System (tested)
Debian

## Fluentd Installation (on the local machine)
    $ gem install fluentd
    $ fluentd -s conf
    $ fluentd -c conf/fluent.conf &
    $ echo '{"json":"message"}' | fluent-cat debug.test
    $ pkill -f fluentd

## Plugin Installation
[fluent-plugin-sql](https://github.com/fluent/fluent-plugin-sql#readme)
    $ fluent-gem install fluent-plugin-sql --no-document
    $ fluent-gem install pg --no-document # for postgresql

# Instruction
## 1. Enable rsyslog
    $ vi /etc/rsyslog.conf
    
    To send log messages to Fluentd (tcp) add this line `*.* @@127.0.0.1:5140` 
### Restart    
    $ systemctl restart rsyslog

## 2. Install mysql2 adapter

    $ sudo apt-get install default-libmysqlclient-dev
    $ sudo gem install mysql2  

### start mysql on the client side (enable on startup)
    $ sudo systemctl start mysql
    $ sudo systemctl enable mysql

## 3. Edit Fluentd Config file

    $ vi /etc/fluent~/fluent.conf

## 4. Set up MySQL server (on the remote machine)

### Install Docker
 
    $ docker pull mysql
    $ docker run --name project-test -p 3306:3306 -e MYSQL_ROOT_PASSWORD=mypassword -d mysql
    $ mysql -u root -p

## 5. Make Databse and Table

	CREATE DATABSE logs;
	USE logs
	CREATE TABLE rsyslog (
		id int NOT NULL AUTO_INCREMENT,
		host varchar(255),
		ident varchar(255),
		pid int,
		message varchar(255),
		timestamp varchar(255),
		PRIMARY KEY (id)
		);
Note: varchar limit needs to be figured out and set environment variables for password
