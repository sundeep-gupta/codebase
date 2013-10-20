<?php
// Author: Razikh. Date: 10th April 2010. 
// For: Tiffin Portal system, Bubble. 
// Script to create table
include("db_config.php");

//Connect to mysql
mysql_connect($db_host,$db_user,$db_pass) or die("Connection failed. No connection to database");

//creating database
//mysql_query("create database $db_name") or die ("failed to create database <br />");

//Selecting the database
mysql_select_db($db_name) or die ("database doesnt exist. Create it first");

//Creating table
//mysql_query("create table users(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY(id), userid VARCHAR(20) NOT NULL, password varchar(20) NOT NULL, email VARCHAR(30) NOT NULL)") or die("Cannot create table. check permissions");

mysql_query (" create table users(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY(id), userid VARCHAR(20) NOT NULL, password VARCHAR(20) NOT NULL, name VARCHAR(30) NOT NULL, email VARCHAR(30) NOT NULL, phone VARCHAR(14) NOT NULL, a_no VARCHAR(8), a_society VARCHAR(15), a_area VARCHAR(15) NOT NULL, a_city VARCHAR(15) NOT NULL, a_country VARCHAR(20) NOT NULL)") or die ("cannot create table Users<br />");

mysql_query("create table cuisine(menuid INT NOT NULL AUTO_INCREMENT, PRIMARY KEY(menuid), type VARCHAR(20) NOT NULL, subcost INT NOT NULL)") or die("cannot create cuisine table <br />");

mysql_query("create table subscription(subid INT NOT NULL AUTO_INCREMENT, PRIMARY KEY(subid), id INT NOT NULL, userid VARCHAR(20) NOT NULL, menuid INT NOT NULL, type VARCHAR(20) NOT NULL, acbal INT NOT NULL, acstatus VARCHAR(3) NOT NULL, sdate date NOT NULL)") or die("cannot create Subscription table <br />");

mysql_query("create table delivery(id INT NOT NULL, dt date NOT NULL, cost INT NOT NULL)") or die("cannot create delivery table <br />");


echo "Complete. Proceed with deployment";


?>
