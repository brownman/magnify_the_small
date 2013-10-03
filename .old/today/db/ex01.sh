#!/bin/sh
# This is a comment


step0(){
word="dog"
cmd0="SELECT * FROM shop"

#cmd1="SELECT MAX(article) AS article FROM shop;"
cmd2="INSERT INTO shop ( dealer, price) 
VALUES (\"$word\",'3.46');
"

#article	dealer	price
#0001	A	3.45

#echo "update persons set x=1 where a=2;"

echo "$cmd2" | mysql db01 --user=root --password=`cat /etc/security/mysqlpassword`
echo "$cmd0" | mysql db01 --user=root --password=`cat /etc/security/mysqlpassword`
#ref: http://dev.mysql.com/doc/refman/5.6/en/example-maximum-column.html
}

step1(){
#mysql -u root -p
mysql  --user=root --password=`cat /etc/security/mysqlpassword`

mysql -t <<STOP
-- This is a comment inside an sql-command-stream.
use db01 
select * from shop ; 
\q
STOP
test $? = 0 && echo "Your batch job terminated gracefully"


}



step2(){
#mysql> CREATE TABLE Persons ( PersonID int, LastName varchar(255), FirstName varchar(255), Address varchar(255), City varchar(255) );
echo ''
}
history(){
    echo ''
#mysql> status
#--------------
#mysql  Ver 14.14 Distrib 5.5.32, for debian-linux-gnu (i686) using readline 6.2
#
#Connection id:		76
#Current database:	
#Current user:		root@localhost
#SSL:			Not in use
#Current pager:		stdout
#Using outfile:		''
#Using delimiter:	;
#Server version:		5.5.32-0ubuntu0.12.10.1 (Ubuntu)
#Protocol version:	10
#Connection:		Localhost via UNIX socket
#Server characterset:	latin1
#Db     characterset:	latin1
#Client characterset:	utf8
#Conn.  characterset:	utf8
#UNIX socket:		/var/run/mysqld/mysqld.sock
#Uptime:			4 days 3 hours 57 min 4 sec
}

step0
