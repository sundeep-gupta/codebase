#!/usr/bin/perl
use DBD::mysql;
use perlchartdir;
use CGI;
$q = new CGI;

print "Content-type:text/html\n\n";

###
$dsn = "DBI:mysql:database=inventory;host=localhost";
$dbh = DBI->connect($dsn,"root",tst123);
###

# $loc = $q->param('loc');
# $make = $q->param('make');
# $model = $q->param('model');


$sql = qq{ select SLNO,LOCATION,TEAM,MAKE,MODEL,MONITOR,KEYBOARD,MOUSE,CD_ROM,PHONE,IP_PHONE,EMP_ID,MACHINE_PURPOSE,HOST_NAME from INVENTORY order by LOCATION };

$sql1 = qq{ select count(*) from INVENTORY where LOCATION like '10A%' };
$sql3 = qq{ select count(*) from INVENTORY where LOCATION like '10C%' };
$sql4 = qq{ select count(*) from INVENTORY where LOCATION like '10D%' };
$sql5 = qq{ select count(*) from INVENTORY where LOCATION like '11C%' };

$sth = $dbh->prepare( $sql );
$sth->execute();
$sth->bind_columns( undef, \$slno, \$location, \$team, \$make, \$model, \$monitor, \$keyboard, \$mouse, \$cdrom, \$phone, \$ipphone, \$empid, \$mcneed, \$host );

$sth1 = $dbh->prepare( $sql1 );
$sth1->execute();
$sth1->bind_columns( undef, \$counta );

$sth2 = $dbh->prepare( $sql3 );
$sth2->execute();
$sth2->bind_columns( undef, \$countc );

$sth3 = $dbh->prepare( $sql4 );
$sth3->execute();
$sth3->bind_columns( undef, \$countd );

$sth4 = $dbh->prepare( $sql5 );
$sth4->execute();
$sth4->bind_columns( undef, \$count );

printf << "EOF";
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>New Page 1</title>
</head>

<body bgcolor="#E0F3FE">
EOF

$sth1->fetch();
printf "<b> Total Number of Entries in 10A : $counta </b><br>";
$sth1->finish();

$sth2->fetch();
printf "<b> Total Number of Entries in 10C : $countc </b><br>";
$sth2->finish();

$sth3->fetch();
printf "<b> Total Number of Entries in 10D : $countd </b><br>";
$sth3->finish();

$sth4->fetch();
printf "<b> Total Number of Entries in 11C : $count </b><br>";
$sth4->finish();

$count_all = $counta+$countc+$countd+$count;
printf "<b> Total Number of Entries in iNautix : $count_all </b><br>";
printf << "EOF";
<table border=3>
  <tr>
	<th bgcolor=gray><font color=white>SLNO</font></th>
	<th bgcolor=gray><font color=white>LOCATION</font></th>
	<th bgcolor=gray><font color=white>TEAM</font></th>
	<th bgcolor=gray><font color=white>MAKE</font></th>
	<th bgcolor=gray><font color=white>MODEL</font></th>
	<th bgcolor=gray><font color=white>MONITOR</font></th>
	<th bgcolor=gray><font color=white>KEYBOARD</font></th>
	<th bgcolor=gray><font color=white>MOUSE</font></th>
	<th bgcolor=gray><font color=white>CD ROM</font></th>
	<th bgcolor=gray><font color=white>PHONE</font></th>
	<th bgcolor=gray><font color=white>IP PHONE</font></th>
	<th bgcolor=gray><font color=white>EMP ID</font></th>
	<th bgcolor=gray><font color=white>MACHINE PURPOSE</font></th>
	<th bgcolor=gray><font color=white>HOST NAME</font></th>
  </tr>

EOF
while( $sth->fetch() ) {
	printf "\n<tr bgcolor=\#efefef><td width=\"10\%\">$slno</td><td width=\"10\%\">$location</td><td width=\"20\%\">$team</td><td width=\"10\%\">$make</td>";
	printf "\n<td width=\"13\%\">$model</td><td width=\"20\%\">$monitor</td><td width=\"07\%\">$keyboard</td><td width=\"10\%\">$mouse</td>";
	printf "\n<td width=\"13\%\">$cdrom</td><td width=\"13\%\">$phone</td><td width=\"13\%\">$ipphone</td><td width=\"13\%\">$empid</td><td width=\"13\%\">$mcneed</td><td width=\"13\%\">$host</td></tr>";

}
$sth->finish();
$dbh->disconnect();

printf << "END";
</table>
</body>
</html>
END



