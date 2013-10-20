<?php
$ebits = ini_get('error_reporting');
error_reporting($ebits ^ E_NOTICE);
  // Replace the variable values below
  // with your specific database information.
  $host = "localhost";
  $user = "root";
  $pass = "tomcat";
  $db = "itrack";

  // This part sets up the connection to the
  // database (so you don't need to reopen the connection
  // again on the same page).
  $ms = mysql_pconnect($host, $user, $pass);
  if ( !$ms )
  {
    echo "Error connecting to database.\n";
  }

  // Then you need to make sure the database you want
  // is selected.
  mysql_select_db($db);
?>
