<?php
// Author: Razikh. Date: 15th April 2010. 
// For: Tiffin Portal system, Bubble. 
// Subscription script
include("db_config.php");
session_start( );
//Connect to mysql
mysql_connect($db_host,$db_user,$db_pass) or die("Connection failed. No connection to database");

//Selecting the database
mysql_select_db($db_name) or die ("database doesnt exist. Create is first");

// echo $_SESSION["uid"]; 
//echo $_POST['userid'];
//echo $_POST['ctype'];
//echo $_POST['nort'];
//echo $_POST['sout'];

$q1 = "select id from users where userid='".$_SESSION["uid"]."'";

$queryU = mysql_query($q1);

$faU = mysql_fetch_array($queryU) or die("cannot fetch data");

//echo $faU['id'];

$q2 = "select menuid,subcost from cuisine";
$queryM = mysql_query($q2) or die("cannot fetch data");

$faM = mysql_fetch_array($queryM);

//echo $faM['menuid'];
//echo $faM['subcost'];

$qcheck = mysql_query("select * from subscription where userid='".$_SESSION["uid"]."'");

$num_rows = mysql_num_rows($qcheck);
if($num_rows!=0){
   
  
   echo "You already have an existing active subscription. <br />";
   echo "Go back to <a href=members.php>Dashboard</a>";
   
   exit;
   }

                                              
$q3 = mysql_query("insert into subscription(id,userid,menuid,type,acbal,acstatus,sdate) values('".$faU['id']."','".$_SESSION["uid"]."','".$faM['menuid']."','".$_POST['ctype']."','".$faM['subcost']."','D','2010-4-18')") or die("query failed");
//$q3 = mysql_query("insert into subscription(id,userid,menuid,type,acbal,acstatus,sdate) values('".$faU['id']."','".$_POST['userid']."','".$faM['menuid']."','".$_POST['ctype']."','".$faM['subcost']."',"D",'2010-4-18')") or die("query failed");
//q3run = mysql_query($q3) or die("Query failed");
//$query = "insert into subscription"

//echo $_SESSION["uid"]; 
echo "Subscription successful! <br />";
echo "Go back to <a href=members.php>Dashboard</a>";
echo"<br /><a href=logout.php>Logout</a>now";
?>
