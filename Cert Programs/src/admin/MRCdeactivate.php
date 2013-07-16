<?php
	include_once("session.php");
	include_once("cert_functions.php");

  if (isset($_GET["m"])) { // Update
    if ($_GET["a"]=="0"){
      $active="1";
    } else {
      $active="0";
    }
  		$sql = "UPDATE bucket SET active='$active' WHERE  id = " .$_GET["m"];
		$update = DoSQL($sql, SQL_UPDATE, 1, false);
		
		header("location: MRCmaint.php?m=".$_GET["m"]."&c=".$_GET["c"]."&st=".$_GET["st"]."&ed=".$_GET["ed"]);
		exit;
	}		

?>
