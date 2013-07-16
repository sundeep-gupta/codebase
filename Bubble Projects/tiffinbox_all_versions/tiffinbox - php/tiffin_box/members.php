<?php 
// Author: Razikh. Date: 15th April 2010. 
// For: Tiffin Portal system, Bubble. 
// Member Dashboard Script
session_start( );
include("db_config.php");

if (!isset($_COOKIE['loggedin'])) die("You are not logged in!
<a href=logn.php>log in</a>");
$mysite_username = $HTTP_COOKIE_VARS["mysite_username"]; 
echo "you are logged in as $mysite_username"; 

$_SESSION["uid"] = $mysite_username;

//echo"<br />";
//echo "<a href=login.php>Login</a>";
//echo "Continue to the <a href=members.php>members</a> section.";

echo "<br />This shud be displayed only to the signed in members";


//Connect to mysql
mysql_connect($db_host,$db_user,$db_pass) or die("Connection failed. No connection to database");

//Selecting the database
mysql_select_db($db_name) or die ("database doesnt exist. Create is first");


//$query = "select users.name, subscription.type, subscription.acbal, subscription.acstatus from users, subscription where (users.id = subscription.id) AND users.userid = '$mysite_username'";

$query = "select subid, type, acbal, acstatus from subscription where userid='$mysite_username'";
$queryU = "select name from users where userid='$mysite_username'";

$accnt2 = mysql_query($queryU) or die("failed to get user subscriptions <br />");

$row2 = mysql_fetch_array($accnt2);

$accnt = mysql_query($query) or die("failed to get user subscriptions <br />");

$num_rows = mysql_num_rows($accnt);

if ($num_rows <= 0) { 
echo "<br /> Sorry, no subscriptions for $mysite_username <br />";
//echo "<a href=logn.php>Try again</a>";
//exit; 
}

while($row = mysql_fetch_array($accnt)) {


   echo "<table><tr><td>";
   echo "Name";
   echo "</td><td>";
   echo "Subscribed cuisine";
   echo "</td><td>";
   echo "Account Balance";
   echo "</td></tr>";
   echo "<tr><td>";
   echo $row2['name'];
   echo "</td><td>";
   echo $row['type'];
   echo "</td><td>";
   echo $row['acbal'];
   echo "</td></tr></table>";
   
//   echo $row['name'];
  
  
  
  
   if($row['status'] == "D") {
   
      echo "<br />Your account is not yet activated.<br />";
   
   
   }

if($row['status'] == "A") {
   
      echo "<br />Your account is Active<br />";
   
   
   }


}

 echo"<a href=logout.php>Logout</a>";
 
 echo "<br /><br />";
 echo "<br />Subscribe to a cuisine..";
 
 echo "<form method=\"POST\", action=\"subscribe.php\">"; 
// echo "<input type=\"hidden\" name=\"userid\" value=\"$mysite_username\">";
// echo "<input type=\"hidden\" id=\"uid\" name=\"userid\" vaue=\"Razikh\">";
 echo "<input type=\"radio\", name=\"ctype\", value=\"Maharashtrian\">Maharashtrian<br />";
 echo "<input type=\"radio\", name=\"ctype\", value=\"North Indian\">North Indian<br />";
 echo "<input type=\"radio\", name=\"ctype\", value=\"South Indian\">South Indian<br />";
 
 echo "<br /><input type=\"submit\", value=\"Subscribe\">";


?>
