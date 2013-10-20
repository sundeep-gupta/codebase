#!/usr/bin/perl
use DBI;
use perlchartdir;
use CGI;
$q = new CGI;

print "Content-type:text/html\n\n";

###
$dsn = "DBI:mysql:database=inventory;host=localhost";
$dbh = DBI->connect($dsn,"root",tst123);
###

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
$mcneed = $q->param("mn");chomp($mcneed);
$empid = $q->param("eid");chomp($empid);
$update = $q->param('update');chomp($update);

$slno =~ tr/a-z/A-Z/;
$location =~ tr/a-z/A-Z/;
$model =~ tr/a-z/A-Z/;
$team =~ tr/a-z/A-Z/;
$make =~ tr/a-z/A-Z/;
$empid =~ tr/a-z/A-Z/;

# $host = "MAA"."$slno";
$host = $slno;

if ($team eq "SELECT TEAM") {
	$team = " ";
}

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

if ($update eq "inatinv") 
{
$sql = qq{ select max(ID)+1 from INVENTORY };
$sth = $dbh->prepare($sql);
$sth->execute();
$sth->bind_columns( undef, \$count );
while( $sth->fetch() ) 
{}
$sth->finish();
$sql = qq{ insert into INVENTORY values ($count,'$slno','$location','$team','$make','$model','$monitor','$keyboard','$mouse','$cdrom','$phone','$ipphone','$empid','$mcneed','$host') };
$sth = $dbh->prepare($sql);
$ret = $sth->execute();
}

if ($ret eq 1){ print "\n<B>Updated Successfully.........</B> ";}else { print "<B>Some Problem with the Input ... Please verify ...</B>\n";}
$dbh->disconnect();

printf << "END";
</body>
</html>
END
