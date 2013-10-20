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

 $loc = $q->param('loc');chomp($loc);
 $lno = $q->param('lno');chomp($lno);
 $make = $q->param('make');chomp($make);
 $model = $q->param('model');chomp($model);
 $team = $q->param('team');chomp($team);
 $slno = $q->param('slno');chomp($slno);

$make =~ tr/a-z/A-Z/;
$loc =~ tr/a-z/A-Z/;
$model =~ tr/a-z/A-Z/;
$team =~ tr/a-z/A-Z/;
$slno =~ tr/a-z/A-Z/;

$locno = "$loc"."$lno";
chomp($locno);

# print "$loc \n";
# print "$make \n";
# print "$model \n";
# print "$team \n";
# print "$locno \n";
# print "$slno \n";

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

if ($make eq "SELECT MAKE" and $model eq "SELECT MODEL" and $loc eq "NONE" and $team eq "SELECT TEAM" and $slno eq "") {
	print "<B>Please fill the neccessary fields....</B>";
	exit(0);
}


if ($make ne "SELECT MAKE" and $model eq "SELECT MODEL" and $loc eq "NONE" and $team eq "SELECT TEAM" and $slno eq "") {
$sql = qq{ select * from INVENTORY where MAKE = '$make' };
$sql1 = qq{ select count(*) from INVENTORY where MAKE = '$make' };
}

if ($make eq "SELECT MAKE" and $model ne "SELECT MODEL" and $loc eq "NONE" and $team eq "SELECT TEAM" and $slno eq "") {
$sql = qq{ select * from INVENTORY where MODEL = '$model' };
$sql1 = qq{ select count(*) from INVENTORY where MODEL = '$model' };
}

if ($make eq "SELECT MAKE" and $model eq "SELECT MODEL" and $loc ne "NONE" and $team eq "SELECT TEAM" and $lno eq "" and $slno eq "") {
$sql = qq{ select * from INVENTORY where LOCATION like '$loc%' };
$sql1 = qq{ select count(*) from INVENTORY where LOCATION like '$loc%' };
}

if ($make eq "SELECT MAKE" and $model eq "SELECT MODEL" and $loc eq "NONE" and $team ne "SELECT TEAM" and $slno eq "") {
$sql = qq{ select * from INVENTORY where TEAM = '$team' };
$sql1 = qq{ select count(*) from INVENTORY where TEAM = '$team' };
}

if ($make eq "SELECT MAKE" and $model eq "SELECT MODEL" and $loc ne "NONE" and $team eq "SELECT TEAM" and $lno ne "" and $slno eq "") {
$sql = qq{ select * from INVENTORY where LOCATION like '$locno%' };
$sql1 = qq{ select count(*) from INVENTORY where LOCATION like '$locno%' };
}

if ($make eq "SELECT MAKE" and $model eq "SELECT MODEL" and $loc eq "NONE" and $team eq "SELECT TEAM" and $slno ne "") {
$sql = qq{ select * from INVENTORY where SLNO = '$slno' };
$sql1 = qq{ select count(*) from INVENTORY where SLNO = '$slno' };
}



$sth = $dbh->prepare( $sql );
$sth1 = $dbh->prepare( $sql1 );
$sth->execute();
$sth1->execute();
$sth->bind_columns( undef, \$id, \$slno, \$location, \$team, \$make, \$model, \$monitor, \$keyboard, \$mouse, \$cdrom, \$phone, \$ipphone, \$empid, \$mcneed, \$host );
$sth1->bind_columns( undef, \$count );

printf << "EOF";
<form name="sampleform" method="POST" action="http://172.25.10.121/cgi-bin/invent/modify.cgi" >
EOF

$sth1->fetch();
printf "<b> Total Number of Entries : $count </b> ";
$sth1->finish();

printf << "EOF";
<table border=2>
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

if ($count eq 1) {

printf << "END";
</table>
<p align="center"><input type="hidden" name="loc" value="$locno" ></p>
	<p align="center"><input type="hidden" name="slno" value="$slno" ></p>
<p align="center"><input type="submit" name="Submit" value="Modify" ></p>
</form>

</body>
</html>
END

}
else
{
printf << "END";
</table>
</form>
</body>
</html>
END
}
