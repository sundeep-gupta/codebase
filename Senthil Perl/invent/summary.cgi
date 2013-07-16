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

printf << "EOF";
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>New Page 1</title>
</head>

<body >
EOF

my $sth = $dbh->prepare("SELECT count(*) from INVENTORY");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
$sth->bind_columns( undef, \$count );
$sth->fetch();
printf "<b> Total Number of Entries in Inautix : $count </b><br>";

printf << "EOF";
<table border=3>
  <tr>
	<th bgcolor=gray><font color=white>LOCATION</font></th>
	<th bgcolor=gray><font color=white>COMPAQ</font></th>
	<th bgcolor=gray><font color=white>DELL</font></th>
	<th bgcolor=gray><font color=white>HP</font></th>
	<th bgcolor=gray><font color=white>TOTAL</font></th>
  </tr>
EOF

my $sth = $dbh->prepare("select make,count(make) from INVENTORY where location like '10A%' group by make");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
$sth->bind_columns( undef, \$make, \$count );

printf "\n<tr bgcolor=\"\#efefef\"><td width=\"10\%\" align=\"center\">10A</td>";
$total = 0;

while( $sth->fetch() ) {
	printf "<td width=\"10\%\" align=\"center\">$count</td>";
	$total = $total+$count;
}
printf "<td width=\"10\%\" align=\"center\">$total</td>";
printf"</tr>";
my $sth = $dbh->prepare("select make,count(make) from INVENTORY where location like '10C%' group by make");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
$sth->bind_columns( undef, \$make, \$count );

printf "<tr bgcolor=\"\#efefef\"><td width=\"10\%\" align=\"center\">10C</td>";
$total = 0;

while( $sth->fetch() ) {
	printf "<td width=\"10\%\" align=\"center\">$count</td>";
	$total = $total+$count;
}
printf "<td width=\"10\%\" align=\"center\">$total</td>";
printf"</tr>";
$sth->finish();
my $sth = $dbh->prepare("select make,count(make) from INVENTORY where location like '10D%' group by make");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}

$sth->bind_columns( undef, \$make, \$count );

printf "<tr bgcolor=\"\#efefef\"><td width=\"10\%\" align=\"center\">10D</td>";
$total = 0;

while( $sth->fetch() ) {
	printf "<td width=\"10\%\" align=\"center\">$count</td>";
	$total = $total+$count;
}
printf "<td width=\"10\%\" align=\"center\">$total</td>";
printf"</tr>";
$sth->finish();
my $sth = $dbh->prepare("select make,count(make) from INVENTORY where location like '11C%' group by make");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
$sth->bind_columns( undef, \$make, \$count );

printf "<tr bgcolor=\"\#efefef\"><td width=\"10\%\" align=\"center\">11C</td>";
$total = 0;

while( $sth->fetch() ) {
	printf "<td width=\"10\%\" align=\"center\">$count</td>";
	$total = $total+$count;
}
printf "<td width=\"10\%\" align=\"center\">$total</td>";
printf"</tr></table>";
$sth->finish();

$sql = qq{ select count(*) from INVENTORY where location like '10A%'};

$sth = $dbh->prepare( $sql );
$sth->execute();
$sth->bind_columns( undef, \$count );

$sth->fetch();
printf "<b> Total Number of Entries in 10A : $count </b><br>";
$sth->finish();

printf << "EOF";
<table border=3>
  <tr>
	<th bgcolor=gray><font color=white>LOCATION</font></th>
	<th bgcolor=gray><font color=white>DELL-GX150</font></th>
	<th bgcolor=gray><font color=white>HP-D530</font></th>
	<th bgcolor=gray><font color=white>COMPAQ-D500</font></th>
	<th bgcolor=gray><font color=white>COMPAQ-D510</font></th>
	<th bgcolor=gray><font color=white>TOTAL</font></th>
  </tr>
EOF

$sql1 = qq{ select model, count(model) from INVENTORY where location like '10A TECH%' group by model };

$sth = $dbh->prepare( $sql1 );
$sth->execute();

$total = 0;
%model_hash = ('D500',0,'D510',0,'GX150',0,'D530',0);

while ( ($model,$count) = $sth->fetchrow_array)
{
	$model_hash{$model} = $count;
	$total = $total + $count;
}

printf "\n<tr bgcolor=\"\#efefef\"><td width=\"10\%\" align=\"left\">10A TECH ROOM</td>";

foreach $key (keys (%model_hash))
{
	printf "<td width=\"10\%\" align=\"center\">$model_hash{$key}</td>";
}
printf "<td width=\"10\%\" align=\"center\">$total</td>";
printf"</tr>";
$sth->finish();

$sql1 = qq{ select model, count(model) from INVENTORY where location like '10A STOR%' group by model };

$sth = $dbh->prepare( $sql1 );
$sth->execute();

$total = 0;
%model_hash = ('D500',0,'D510',0,'GX150',0,'D530',0);

while ( ($model,$count) = $sth->fetchrow_array)
{
	$model_hash{$model} = $count;
	$total = $total + $count;
}

printf "\n<tr bgcolor=\"\#efefef\"><td width=\"10\%\" align=\"left\">10A STORE ROOM</td>";

foreach $key (keys (%model_hash))
{
	printf "<td width=\"10\%\" align=\"center\">$model_hash{$key}</td>";
}
printf "<td width=\"10\%\" align=\"center\">$total</td>";
printf"</tr>";
$sth->finish();

$sql1 = qq{ select model, count(model) from INVENTORY where location like '10A MEET%' group by model };

$sth = $dbh->prepare( $sql1 );
$sth->execute();

$total = 0;
%model_hash = ('D500',0,'D510',0,'GX150',0,'D530',0);

while ( ($model,$count) = $sth->fetchrow_array)
{
		$model_hash{$model} = $count;
		$total = $total + $count;
}

printf "\n<tr bgcolor=\"\#efefef\"><td width=\"10\%\" align=\"left\">10A MEETING ROOM</td>";

foreach $key (keys (%model_hash))
{
	printf "<td width=\"10\%\" align=\"center\">$model_hash{$key}</td>";
}
printf "<td width=\"10\%\" align=\"center\">$total</td>";
printf"</tr>";
$sth->finish();


$sql1 = qq{ select model, count(model) from INVENTORY where location not in('10A TECH ROOM','10A MEETING ROOM','10A STORE ROOM') and location like '10A%' group by model };

$sth = $dbh->prepare( $sql1 );
$sth->execute();
$total = 0;

%model_hash = ('D500',0,'D510',0,'GX150',0,'D530',0);

while ( ($model,$count) = $sth->fetchrow_array)
{
		$model_hash{$model} = $count;
		$total = $total + $count;
}

printf "\n<tr bgcolor=\"\#efefef\"><td width=\"10\%\" align=\"left\">10A USER LOCATION</td>";
foreach $key (keys (%model_hash))
{
	printf "<td width=\"10\%\" align=\"center\">$model_hash{$key}</td>";
}
printf "<td width=\"10\%\" align=\"center\">$total</td>";
printf"</tr></table>";
$sth->finish();

$sql = qq{ select count(*) from INVENTORY where location like '10C%'};

$sth = $dbh->prepare( $sql );
$sth->execute();
$sth->bind_columns( undef, \$count );

$sth->fetch();
printf "<b> Total Number of Entries in 10C : $count </b><br>";
$sth->finish();

printf << "EOF";
<table border=3>
  <tr>
	<th bgcolor=gray><font color=white>LOCATION</font></th>
	<th bgcolor=gray><font color=white>DELL-GX150</font></th>
	<th bgcolor=gray><font color=white>HP-D530</font></th>
	<th bgcolor=gray><font color=white>COMPAQ-D500</font></th>
	<th bgcolor=gray><font color=white>COMPAQ-D510</font></th>
	<th bgcolor=gray><font color=white>TOTAL</font></th>
  </tr>
EOF

$sql1 = qq{ select model, count(model) from INVENTORY where location like '10C TECH%' group by model };

$sth = $dbh->prepare( $sql1 );
$sth->execute();

$total = 0;
%model_hash = ('D500',0,'D510',0,'GX150',0,'D530',0);

while ( ($model,$count) = $sth->fetchrow_array)
{
	$model_hash{$model} = $count;
	$total = $total + $count;
}

printf "\n<tr bgcolor=\"\#efefef\"><td width=\"10\%\" align=\"left\">10C TECH ROOM</td>";

foreach $key (keys (%model_hash))
{
	printf "<td width=\"10\%\" align=\"center\">$model_hash{$key}</td>";
}
printf "<td width=\"10\%\" align=\"center\">$total</td>";
printf"</tr>";
$sth->finish();

$sql1 = qq{ select model, count(model) from INVENTORY where location like '10C STOR%' group by model };

$sth = $dbh->prepare( $sql1 );
$sth->execute();

$total = 0;
%model_hash = ('D500',0,'D510',0,'GX150',0,'D530',0);

while ( ($model,$count) = $sth->fetchrow_array)
{
	$model_hash{$model} = $count;
	$total = $total + $count;
}

printf "\n<tr bgcolor=\"\#efefef\"><td width=\"10\%\" align=\"left\">10C STORE ROOM</td>";

foreach $key (keys (%model_hash))
{
	printf "<td width=\"10\%\" align=\"center\">$model_hash{$key}</td>";
}
printf "<td width=\"10\%\" align=\"center\">$total</td>";
printf"</tr>";
$sth->finish();

$sql1 = qq{ select model, count(model) from INVENTORY where location like '10C MEET%' group by model };

$sth = $dbh->prepare( $sql1 );
$sth->execute();

$total = 0;
%model_hash = ('D500',0,'D510',0,'GX150',0,'D530',0);

while ( ($model,$count) = $sth->fetchrow_array)
{
		$model_hash{$model} = $count;
		$total = $total + $count;
}

printf "\n<tr bgcolor=\"\#efefef\"><td width=\"10\%\" align=\"left\">10C MEETING ROOM</td>";

foreach $key (keys (%model_hash))
{
	printf "<td width=\"10\%\" align=\"center\">$model_hash{$key}</td>";
}
printf "<td width=\"10\%\" align=\"center\">$total</td>";
printf"</tr>";
$sth->finish();


$sql1 = qq{ select model, count(model) from INVENTORY where location not in('10C TECH ROOM','10C MEETING ROOM','10C STORE ROOM') and location like '10C%' group by model };

$sth = $dbh->prepare( $sql1 );
$sth->execute();
$total = 0;

%model_hash = ('D500',0,'D510',0,'GX150',0,'D530',0);

while ( ($model,$count) = $sth->fetchrow_array)
{
		$model_hash{$model} = $count;
		$total = $total + $count;
}

printf "\n<tr bgcolor=\"\#efefef\"><td width=\"10\%\" align=\"left\">10C USER LOCATION</td>";
foreach $key (keys (%model_hash))
{
	printf "<td width=\"10\%\" align=\"center\">$model_hash{$key}</td>";
}
printf "<td width=\"10\%\" align=\"center\">$total</td>";
printf"</tr></table>";
$sth->finish();

$sql = qq{ select count(*) from INVENTORY where location like '10D%'};

$sth = $dbh->prepare( $sql );
$sth->execute();
$sth->bind_columns( undef, \$count );

$sth->fetch();
printf "<b> Total Number of Entries in 10D : $count </b><br>";
$sth->finish();

printf << "EOF";
<table border=3>
  <tr>
	<th bgcolor=gray><font color=white>LOCATION</font></th>
	<th bgcolor=gray><font color=white>DELL-GX150</font></th>
	<th bgcolor=gray><font color=white>HP-D530</font></th>
	<th bgcolor=gray><font color=white>COMPAQ-D500</font></th>
	<th bgcolor=gray><font color=white>COMPAQ-D510</font></th>
	<th bgcolor=gray><font color=white>TOTAL</font></th>
  </tr>
EOF

$sql1 = qq{ select model, count(model) from INVENTORY where location like '10D TECH%' group by model };

$sth = $dbh->prepare( $sql1 );
$sth->execute();

$total = 0;
%model_hash = ('D500',0,'D510',0,'GX150',0,'D530',0);

while ( ($model,$count) = $sth->fetchrow_array)
{
	$model_hash{$model} = $count;
	$total = $total + $count;
}

printf "\n<tr bgcolor=\"\#efefef\"><td width=\"10\%\" align=\"left\">10D TECH ROOM</td>";

foreach $key (keys (%model_hash))
{
	printf "<td width=\"10\%\" align=\"center\">$model_hash{$key}</td>";
}
printf "<td width=\"10\%\" align=\"center\">$total</td>";
printf"</tr>";
$sth->finish();

$sql1 = qq{ select model, count(model) from INVENTORY where location like '10D STOR%' group by model };

$sth = $dbh->prepare( $sql1 );
$sth->execute();

$total = 0;
%model_hash = ('D500',0,'D510',0,'GX150',0,'D530',0);

while ( ($model,$count) = $sth->fetchrow_array)
{
	$model_hash{$model} = $count;
	$total = $total + $count;
}

printf "\n<tr bgcolor=\"\#efefef\"><td width=\"10\%\" align=\"left\">10D STORE ROOM</td>";

foreach $key (keys (%model_hash))
{
	printf "<td width=\"10\%\" align=\"center\">$model_hash{$key}</td>";
}
printf "<td width=\"10\%\" align=\"center\">$total</td>";
printf"</tr>";
$sth->finish();

$sql1 = qq{ select model, count(model) from INVENTORY where location like '10D MEET%' group by model };

$sth = $dbh->prepare( $sql1 );
$sth->execute();

$total = 0;
%model_hash = ('D500',0,'D510',0,'GX150',0,'D530',0);

while ( ($model,$count) = $sth->fetchrow_array)
{
		$model_hash{$model} = $count;
		$total = $total + $count;
}

printf "\n<tr bgcolor=\"\#efefef\"><td width=\"10\%\" align=\"left\">10D MEETING ROOM</td>";

foreach $key (keys (%model_hash))
{
	printf "<td width=\"10\%\" align=\"center\">$model_hash{$key}</td>";
}
printf "<td width=\"10\%\" align=\"center\">$total</td>";
printf"</tr>";
$sth->finish();


$sql1 = qq{ select model, count(model) from INVENTORY where location not in('10D TECH ROOM','10D MEETING ROOM','10D STORE ROOM') and location like '10D%' group by model };

$sth = $dbh->prepare( $sql1 );
$sth->execute();
$total = 0;

%model_hash = ('D500',0,'D510',0,'GX150',0,'D530',0);

while ( ($model,$count) = $sth->fetchrow_array)
{
		$model_hash{$model} = $count;
		$total = $total + $count;
}

printf "\n<tr bgcolor=\"\#efefef\"><td width=\"10\%\" align=\"left\">10D USER LOCATION</td>";
foreach $key (keys (%model_hash))
{
	printf "<td width=\"10\%\" align=\"center\">$model_hash{$key}</td>";
}
printf "<td width=\"10\%\" align=\"center\">$total</td>";
printf"</tr></table>";
$sth->finish();

$sql = qq{ select count(*) from INVENTORY where location like '11C%'};

$sth = $dbh->prepare( $sql );
$sth->execute();
$sth->bind_columns( undef, \$count );

$sth->fetch();
printf "<b> Total Number of Entries in 11C : $count </b><br>";
$sth->finish();

printf << "EOF";
<table border=3>
  <tr>
	<th bgcolor=gray><font color=white>LOCATION</font></th>
	<th bgcolor=gray><font color=white>DELL-GX150</font></th>
	<th bgcolor=gray><font color=white>HP-D530</font></th>
	<th bgcolor=gray><font color=white>COMPAQ-D500</font></th>
	<th bgcolor=gray><font color=white>COMPAQ-D510</font></th>
	<th bgcolor=gray><font color=white>TOTAL</font></th>
  </tr>
EOF

$sql1 = qq{ select model, count(model) from INVENTORY where location like '11C TECH%' group by model };

$sth = $dbh->prepare( $sql1 );
$sth->execute();

$total = 0;
%model_hash = ('D500',0,'D510',0,'GX150',0,'D530',0);

while ( ($model,$count) = $sth->fetchrow_array)
{
	$model_hash{$model} = $count;
	$total = $total + $count;
}

printf "\n<tr bgcolor=\"\#efefef\"><td width=\"10\%\" align=\"left\">11C TECH ROOM</td>";

foreach $key (keys (%model_hash))
{
	printf "<td width=\"10\%\" align=\"center\">$model_hash{$key}</td>";
}
printf "<td width=\"10\%\" align=\"center\">$total</td>";
printf"</tr>";
$sth->finish();

$sql1 = qq{ select model, count(model) from INVENTORY where location like '11C STOR%' group by model };

$sth = $dbh->prepare( $sql1 );
$sth->execute();

$total = 0;
%model_hash = ('D500',0,'D510',0,'GX150',0,'D530',0);

while ( ($model,$count) = $sth->fetchrow_array)
{
	$model_hash{$model} = $count;
	$total = $total + $count;
}

printf "\n<tr bgcolor=\"\#efefef\"><td width=\"10\%\" align=\"left\">11C STORE ROOM</td>";

foreach $key (keys (%model_hash))
{
	printf "<td width=\"10\%\" align=\"center\">$model_hash{$key}</td>";
}
printf "<td width=\"10\%\" align=\"center\">$total</td>";
printf"</tr>";
$sth->finish();

$sql1 = qq{ select model, count(model) from INVENTORY where location like '11C MEET%' group by model };

$sth = $dbh->prepare( $sql1 );
$sth->execute();

$total = 0;
%model_hash = ('D500',0,'D510',0,'GX150',0,'D530',0);

while ( ($model,$count) = $sth->fetchrow_array)
{
		$model_hash{$model} = $count;
		$total = $total + $count;
}

printf "\n<tr bgcolor=\"\#efefef\"><td width=\"10\%\" align=\"left\">11C MEETING ROOM</td>";

foreach $key (keys (%model_hash))
{
	printf "<td width=\"10\%\" align=\"center\">$model_hash{$key}</td>";
}
printf "<td width=\"10\%\" align=\"center\">$total</td>";
printf"</tr>";
$sth->finish();


$sql1 = qq{ select model, count(model) from INVENTORY where location not in('11C TECH ROOM','11C MEETING ROOM','11C STORE ROOM') and location like '11C%' group by model };

$sth = $dbh->prepare( $sql1 );
$sth->execute();
$total = 0;

%model_hash = ('D500',0,'D510',0,'GX150',0,'D530',0);

while ( ($model,$count) = $sth->fetchrow_array)
{
		$model_hash{$model} = $count;
		$total = $total + $count;
}

printf "\n<tr bgcolor=\"\#efefef\"><td width=\"10\%\" align=\"left\">11C USER LOCATION</td>";
foreach $key (keys (%model_hash))
{
	printf "<td width=\"10\%\" align=\"center\">$model_hash{$key}</td>";
}
printf "<td width=\"10\%\" align=\"center\">$total</td>";
printf"</tr></table>";
$sth->finish();



$dbh->disconnect();

printf << "END";
</body>
</html>
END



