<?php

  mysql_connect("localhost", "insha_in", "EternalSQL") or die(mysql_error());
  echo "Connected to MySQL<br />";
  mysql_select_db("insha_in") or die(mysql_error());
  echo "Connected to Database";
  
  //Create a table with columns for ID, UID, NAME & ACCESS TOKEN
  
  mysql_query("CREATE TABLE wordoracledata(id INT NOT NULL AUTO_INCREMENT,PRIMARY KEY(id), uid INT NOT NULL, name VARCHAR(50), atoken VARCHAR(120))") or die(mysql_error());
  echo "Table Created!";


?>