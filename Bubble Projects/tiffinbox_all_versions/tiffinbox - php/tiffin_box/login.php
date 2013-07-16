<?php

include("db_config.php"); 
start_session();
// connect to the mysql server
$link = mysql_connect($db_host, $db_user, $db_pass)
or die ("Could not connect to mysql because ".mysql_error());

// select the database
mysql_select_db($db_name)
or die ("Could not select database because ".mysql_error());


if ($_POST['userid'] == '') {

    echo "User ID or Password missing. try again<br />";
    echo "<a href=logn.php>Try again</a>";
    exit;
  

}


$match = "select id from users where userid = '".$_POST['userid']."'
and password = '".$_POST['pass']."';"; 

$qry = mysql_query($match)
or die ("Could not match data because ".mysql_error());
$num_rows = mysql_num_rows($qry); 

if ($num_rows <= 0) { 
echo "Sorry, there is no userid $userid with the specified password.<br>";
echo "<a href=logn.php>Try again</a>";
exit; 
} else {
 $userid = $_POST['userid'];
 $_SESSION['userid'] = $_POST['userid'];
 $_SESSION['adminid'] = $_POST['userid'];
setcookie("loggedin", "TRUE", time()+(3600 * 24));
setcookie("mysite_username", $userid);
echo "You are now logged in!<br>"; 
echo "Continue to the <a href=members.php>members</a> section.";
}
?>
