<?php
// Author: Razikh. Date: 10th April 2010. 
// For: Tiffin Portal system, Bubble. 
// Registration Script
include("db_config.php");

//Connect to mysql
mysql_connect($db_host,$db_user,$db_pass) or die("Connection failed. No connection to database");

//Selecting the database
mysql_select_db($db_name) or die ("database doesnt exist. Create is first");

//check if user id already taken
                                
$check = "select id from users where userid='".$_POST['userid']."';";

$query=mysql_query($check) or die ("Could not fetch data");
$num_rows = mysql_num_rows($query);
if($num_rows!=0){
   
   echo "The user id $userid is already taken. Try again with other id <br />";
   echo "<a href=register.php>Try again</a>";
   exit;
   }
   else {
   
   $insert = mysql_query("insert into users(userid, password, name, email, phone, a_no, a_society, a_area, a_city, a_country) values('".$_POST['userid']."', '".$_POST['pass']."', '".$_POST['name']."','".$_POST['email']."', '".$_POST['phone']."', '".$_POST['a_no']."','".$_POST['a_society']."', '".$_POST['a_area']."', '".$_POST['a_city']."', '".$_POST['a_country']."')") or die ("Cannot populate data");
   
   print "Your account has been created\n";
   echo "you can now <a href=logn.php>login</a>";
   
   
   }                                
                         
?>


