<?php

$var = 'I am global now';
callFunction();
print $var;
function callFunction() {
    global $var;
    if ($var == 'I am global now') {
        $var = 'Something different';
    }
}

 require_once 'facebook.php';
 $facebook = new Facebook(array(
        'appapikey' => '1633cdce96369a7657e63056a7d76278',
        'secret' => '35b16e2b6e14eef0b13b1e0d1c842d3f',
        'cookie' => true,
    ));

  mysql_connect("localhost", "insha_in", "EternalSQL") or die(mysql_error());
  echo "Connected to MySQL<br />";
  mysql_select_db("insha_in") or die(mysql_error());
  echo "Connected to Database";
/* $query = "SELECT uid FROM wordoracledata";
	   $result = mysql_query($query) or die(mysql_error());
     while($row = mysql_fetch_array($result)){
      echo $row['uid'];
	echo "<br />";
  */
    // }
   //   $row = mysql_fetch_array($result);

 /*  $uid="1111444555558223";
   $n = "Razikh";
   $access_token="1asdsgfd32142354353";


     $query = "SELECT uid FROM wordoracledata";
	   $result = mysql_query($query) or die(mysql_error());
 //     mysql_query("INSERT INTO wordoracledata(uid,name,atoken) VALUES('$uid','$n','$access_token')") or die(mysql_error());
   $set=0;

    while($row = mysql_fetch_array($result)){
          echo "inside while";
         if($row['uid'] == $uid){
         echo "uid exists";
         $set=0;
         echo $set;
          return;
         }
      else {

         $set=1;

          // Insert a row of information into the table "example"

             echo "planning to insert";
            }

	       echo $set;
         }

   echo "set value $set";

    if($set==1){
    mysql_query("INSERT INTO wordoracledata(uid,name,atoken) VALUES('$uid','$n','$access_token')") or die(mysql_error());
   }

	   echo "am here";
     while($row = mysql_fetch_array($result)){
      echo $row['uid'];
	echo "<br />";

     }
     echo $row;
   */

    $query = "SELECT * FROM wordoracledata";
 $result = mysql_query($query) or die(mysql_error());
/*
 while($row = mysql_fetch_array($result)){


$attachment = array(
'access_token' => $row['atoken'],
'message' => 'Learn Word by sentence',
'name' => "Learn Word by sentence",
'link' => $appurl,
'description' => "Deluge - Flood.",
'picture'=>"http://insha.in/fb/wordoracle/bfly1.jpg",

);
$facebook->api('/me/feed', 'POST', $attachment);
 } */

 require_once 'facebook.php';
 $facebook = new Facebook(array(
        'appapikey' => '1633cdce96369a7657e63056a7d76278',
        'secret' => '35b16e2b6e14eef0b13b1e0d1c842d3f',
        'cookie' => true,
    ));


       $session = $facebook->getSession();

    $me = null;

    if ($session) {
        try {
            $uid = $facebook->getUser();
            $me = $facebook->api('/me');
        } catch (FacebookApiException $e) {
            error_log($e);
        }
    }

  mysql_connect("localhost", "insha_in", "EternalSQL") or die(mysql_error());
  echo "Connected to MySQL<br />";
  mysql_select_db("insha_in") or die(mysql_error());
  echo "Connected to Database";

  $query = "SELECT * FROM wordoracledata";
 $result = mysql_query($query) or die(mysql_error());

       $appurl = 'http://apps.facebook.com/wordoracle/';

 while($row = mysql_fetch_array($result)){

   echo $row['atoken'];

$attachment = array(
'access_token' => $row['atoken'],
'message' => 'Learn Word by sentence',
'name' => "Learn Word by sentence",
'link' => $appurl,
'description' => "Deluge - Flood.",
'picture'=>"http://insha.in/fb/wordoracle/bfly1.jpg",

);
 $facebook->api('/me/feed', 'POST', $attachment);
 }

 echo "printed successfully";

?>
