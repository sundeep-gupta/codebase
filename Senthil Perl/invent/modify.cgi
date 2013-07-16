#!/usr/bin/perl
# use DBD::mysql;
use DBI;
use perlchartdir;
use CGI;
$q = new CGI;

print "Content-type:text/html\n\n";

###
$dsn = "DBI:mysql:database=inventory;host=localhost";
$dbh = DBI->connect($dsn,"root",tst123);
###

$loc = $q->param('loc');chomp($loc);
$slno = $q->param('slno');chomp($slno);

$sid = $q->param('id');chomp($sid);
$update = $q->param('update');chomp($update);


$sql = qq{ select * from INVENTORY where LOCATION like '$loc%' or SLNO = '$slno'};
$sth = $dbh->prepare($sql);
$sth->execute();
$sth->bind_columns( undef, \$id, \$slno, \$location, \$team, \$make, \$model, \$monitor, \$keyboard, \$mouse, \$cdrom, \$phone, \$ipphone, \$empid, \$mcneed, \$host );
$sth->fetch();


if ($update eq "inatinv" and $sid ne "") {
	update_values();
}
else
{
HTML_HEADER();
}


sub HTML_HEADER()
{
printf <<"END";
<html>

<head>
<title>Inventory Management Report</title>
</head>

<body bgcolor="#E0F3FE">

<form name="sample" method="GET" action="http://172.25.10.121/cgi-bin/invent/modify.cgi" ><b>    
Serial No&nbsp;&nbsp;&nbsp;&nbsp; : <input type="text" name="sn" size="20" value="$slno">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Location&nbsp;&nbsp;&nbsp;&nbsp; : <input type="text" name="loc" size="20" value="$location">
<p>Phone&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : <input type="text" name="phone" size="20" value="$phone">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
IP Phone&nbsp;&nbsp;&nbsp;&nbsp; : <input type="text" name="ip" size="20" value="$ipphone">
<p>Emp ID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : <input type="text" name="eid" size="20" value="$empid">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Model&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :  <select size="1" name="model" >
	<option>D530</option>
    <option>GX150</option>
    <option>GX250</option>
    <option>D500</option>
    <option>D510</option>
</select>
<p>Team&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : <select size="1" name="team" value="$team">
	<option >Select Team</option>
    <option >ADMINISTRATION</option>
	<option>BNY</option>
    <option>COO\'S OFFICE</option>
    <option>DEVELOPMENT DELIVERY</option>
    <option>DEVELOPMENT PROCESSING</option>
	<option>FINANCE</option>
	<option>HR</option>
	<option>INFRASTRUCTURE</option>
	<option>PROCESS ASSURANCE</option>
	<option>PROGRAM MANAGEMENT</option>
	<option>QUALITY ASSURANCE</option>
	<option>SERVICE IT</option>
	<option>TRAINING</option>
</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<p>M/C Need&nbsp; : <select size="1" name="mn" value="$mcneed">
	<option selected>PRIMARY</option>
    <option>SECONDARY</option>
    </select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;
Make&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <select size="1" name="make" value="$make">
	<option selected>COMPAQ</option>
    <option>DELL</option>
    <option>HP</option>
</select>
<p>Monitor&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : <select size="1" name="monitor" value="$monitor">
        <option selected>COMPAQ</option>
    <option>DELL</option>
    <option>HP</option>
</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Keyboard&nbsp;&nbsp;: <select size="1" name="key" value="$keyboard">
        <option selected>COMPAQ</option>
    <option>DELL</option>
    <option>HP</option>
</select>
<p>Mouse&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : <select size="1" name="mouse" value="$mouse">
        <option selected>COMPAQ</option>
    <option>DELL</option>
    <option>HP</option>
</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
CD ROM&nbsp;&nbsp; : <select size="1" name="cd" value="$cdrom">
	<option selected>YES</option>
    <option>NO</option>
</select>
<p>&nbsp;

<p align="center">
<b>Please Enter Password to Update </b><input type="password" name="update" size="20"></p>
<input type="hidden" value="$id" name="id"> 
<p align="center"><input type="submit" value="Modify" name="update"></p>
</b></form>

</body>

</html>
  
END

}


sub update_values()
{


printf <<"END";
<html>

<head>
<title>Inventory Management Report</title>
</head>

<body bgcolor="#E0F3FE">
END



$slno = $q->param("sn");chomp($slno);
$location = $q->param("loc");chomp($location);
$team = $q->param("team");chomp($team);
$make = $q->param("make");chomp($make);
$model = $q->param("model");chomp($model);
$monitor = $q->param("monitor");chomp($monitor);
$keyboard = $q->param("key");chomp($keyboard);
$mouse = $q->param("mouse");chomp($mouse);
$cdrom = $q->param("cd");chomp($cdrom);
$phone = $q->param("phone");chomp($phone);
$ipphone = $q->param("ip");chomp($ipphone);
$empid = $q->param("eid");chomp($empid);
$mcneed = $q->param("mn");chomp($mcneed);

$slno =~ tr/a-z/A-Z/;
$location =~ tr/a-z/A-Z/;
$model =~ tr/a-z/A-Z/;
$team =~ tr/a-z/A-Z/;
$make =~ tr/a-z/A-Z/;
$host = "MAA"."$slno";

if ($team eq "SELECT TEAM") {
	$team = " ";
}

$sql = qq{update INVENTORY set  SLNO='$slno',LOCATION='$location',TEAM='$team',MAKE='$make',MODEL='$model',MONITOR='$monitor',KEYBOARD='$keyboard',MOUSE='$mouse',CD_ROM='$cdrom',PHONE='$phone',IP_PHONE='$ipphone',EMP_ID='$empid',MACHINE_PURPOSE='$mcneed',HOST_NAME='$host' where id = '$sid' };
$sth = $dbh->prepare($sql);
$ret = $sth->execute();
$sql1 = qq{commit};
$sth = $dbh->prepare($sql1);
$sth->execute();
if ($ret eq 1){ print "\n<B>Modified Successfully.........</B> ";}else { print "<B>Some Problem with the Input ... Please verify ...</B>\n";}


printf << "END";
</body>
</html>
END

}
