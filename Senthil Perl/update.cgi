#!/usr/bin/perl
use DBD::mysql;
use perlchartdir;
use CGI;
$q = new CGI;

print "Content-type:text/html\r\n\n";

$eid = $q->param("eid");chomp($eid);
$did = $q->param("did");chomp($did);
$fn = $q->param("fn");chomp($fn);
$sn = $q->param("sn");chomp($sn);

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

$dsn = "DBI:mysql:database=isa_mysql;host=localhost";
$dbh = DBI->connect($dsn,"root",tst123 );

my $sth = $dbh->prepare("insert into employees values ('$eid','$did','$fn','$sn') ");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
# if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}

$ret = $sth->execute();

if ($ret eq 1){ print "\n<B>Updated Successfully.........</B> ";}else { print "<B>Some Problem with the Input ... Please verify ...</B>\n";}
$dbh->disconnect();

printf << "END";
</body>
</html>
END

