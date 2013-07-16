<?php
session_start();
$ebits = ini_get('error_reporting');
error_reporting($ebits ^ E_NOTICE);
include('dbconfig.php');




	// Retrieve data from Query String
$taskname = $_GET['taskname'];
$priority = $_GET['priority'];
$email = $_SESSION["email"];
//$wpm = $_GET['wpm'];
	// Escape User Input to help prevent SQL Injection
$taskname = mysql_real_escape_string($taskname);
$priority = mysql_real_escape_string($priority);
$email = mysql_real_escape_string($email);
//$wpm = mysql_real_escape_string($wpm);

//mysql_query("INSERT INTO ajax_example2 (age, sex, wpm) VALUES('$age', '$sex', '$wpm') ") or die(mysql_error());  
mysql_query("INSERT INTO task (email, taskname, type) VALUES('$email', '$taskname', '$priority' ) ") or die(mysql_error()); 
//mysql_query("update task set state=1 where id='$taskid'") or die(mysql_error());  


//$result = mysql_query("SELECT id,taskname FROM task where type='UrgentImportant' AND state=0") or die(mysql_error());  



//Start 

     $display_string .= "<div class=\"row\">";
	 $display_string .= "<div class=\"fourl1 columns\">";

$display_string .= "<b>High Impact - High Risk</b>";


// Get all the data from the "example" table
$result1 = mysql_query("SELECT id,taskname FROM task where type='UrgentImportant' AND email='$email' AND state=0") 
or die(mysql_error());  

//echo "<table border='1'>";
//echo "<tr> <th>Name</th> <th>Age</th> </tr>";
// keeps getting the next row until there are no more to get
while($row = mysql_fetch_array( $result1 )) {
	// Print out the contents of each row into a table
	$display_string .= "<li>"; 
	$display_string .= "<form action=\"del.php\" method=\"post\">";
	$display_string .= "<input type=\"hidden\" id=\"tid\" value=" . $row['id'] . ">";
	$display_string .= "<input type=\"hidden\" id=\"priority\" value=\"NUrgentNImportant\">";
	
	$rowid = $row['id'];

	$display_string .= $row['taskname'];
	//$display_string .= "<input type=\"submit\" value=\"Done\">";
        $display_string .= "<input type=\"button\" class=\"button_add\" onclick=\"ajaxFunctionDel('$rowid')\"  >";
        $display_string .= "</form>";
	$display_string .= "</li>";
	
} 


$display_string .= "</div>";
 $display_string .= "<div class=\"fourr1 columns\">";
$display_string .= "<b>High Impact</b> - Low Risk";


// Get all the data from the "example" table
$result2 = mysql_query("SELECT id,taskname FROM task where type='NUrgentImportant' AND email='$email' AND state=0") 
or die(mysql_error());  

//echo "<table border='1'>";
//echo "<tr> <th>Name</th> <th>Age</th> </tr>";
// keeps getting the next row until there are no more to get
while($row = mysql_fetch_array( $result2 )) {
	// Print out the contents of each row into a table
	$display_string .= "<li>"; 
	$display_string .= "<form action=\"del.php\" method=\"post\">";
	$display_string .= "<input type=\"hidden\" id=\"tid\" value=" . $row['id'] . ">";
	$display_string .= "<input type=\"hidden\" id=\"priority\" value=\"NUrgentNImportant\">";
	
	$rowid = $row['id'];

	$display_string .= $row['taskname'];
	//$display_string .= "<input type=\"submit\" value=\"Done\">";
        $display_string .= "<input type=\"button\" class=\"button_add\" onclick=\"ajaxFunctionDel('$rowid')\"  >";
	$display_string .= "</form>";
	$display_string .= "</li>";
	
} 


$display_string .= "</div>";
$display_string .= "<div class=\"two columns\">";
$display_string .= "</div>";
$display_string .= "</div>";

$display_string .= "<div class=\"row\">";
	 $display_string .= "<div class=\"fourl2 columns\">";

$display_string .= "<b>High Risk</b> - Low Impact";


// Get all the data from the "example" table
$result3 = mysql_query("SELECT id,taskname FROM task where type='UrgentNImportant' AND email='$email' AND state=0") 
or die(mysql_error());  

//echo "<table border='1'>";
//echo "<tr> <th>Name</th> <th>Age</th> </tr>";
// keeps getting the next row until there are no more to get
while($row = mysql_fetch_array( $result3 )) {
	// Print out the contents of each row into a table
	$display_string .= "<li>"; 
	$display_string .= "<form action=\"del.php\" method=\"post\">";
	$display_string .= "<input type=\"hidden\" id=\"tid\" value=" . $row['id'] . ">";
	$display_string .= "<input type=\"hidden\" id=\"priority\" value=\"NUrgentNImportant\">";
	
	$rowid = $row['id'];

	$display_string .= $row['taskname'];
	//$display_string .= "<input type=\"submit\" value=\"Done\">";
        $display_string .= "<input type=\"button\" class=\"button_add\" onclick=\"ajaxFunctionDel('$rowid')\"  >";
    //	$display_string .= "<input type=\"button\" onclick=\"ajaxFunctionDel('$rowid')\" value=\"Add\">";
	$display_string .= "</form>";
	$display_string .= "</li>";
	
} 

$display_string .= "</div>";
 $display_string .= "<div class=\"fourr2 columns\">";
$display_string .= "Low Impact - Low Risk";


// Get all the data from the "example" table
$result4 = mysql_query("SELECT id,taskname FROM task where type='NUrgentNImportant' AND email='$email' AND state=0") 
or die(mysql_error());  

//echo "<table border='1'>";
//echo "<tr> <th>Name</th> <th>Age</th> </tr>";
// keeps getting the next row until there are no more to get
while($row = mysql_fetch_array( $result4 )) {
	// Print out the contents of each row into a table
	$display_string .= "<li>"; 
	$display_string .= "<form action=\"del.php\" method=\"post\">";
	$display_string .= "<input type=\"hidden\" id=\"tid\" value=" . $row['id'] . ">";
	$display_string .= "<input type=\"hidden\" id=\"priority\" value=\"NUrgentNImportant\">";
	
	$rowid = $row['id'];

	$display_string .= $row['taskname'];
	//$display_string .= "<input type=\"submit\" value=\"Done\">";
	//$display_string .= "<input type=\"button\" onclick=\"ajaxFunctionDel('$rowid')\" value=\"Add\">";
        $display_string .= "<input type=\"button\" class=\"button_add\" onclick=\"ajaxFunctionDel('$rowid')\"  >";
	$display_string .= "</form>";
	$display_string .= "</li>";
	
} 


$display_string .= "</div>";
$display_string .= "<div class=\"two columns\">";
$display_string .= "</div>";
$display_string .= "</div>";

//End





echo $display_string;

?>
