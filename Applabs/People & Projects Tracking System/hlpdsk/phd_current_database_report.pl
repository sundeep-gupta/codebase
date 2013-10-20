#!/usr/bin/perl
use DBD::mysql;
use perlchartdir;
use CGI;
$q = new CGI;

print "Content-type:text/html\n\n";
$start_date = $q->param('idate');
$end_date = $q->param('rdate');
$type = $q->param('type');

$dsn = "DBI:mysql:database=Help_desk;host=localhost";
$dbh = DBI->connect($dsn,"root",tst123 );

if ($type eq "category") 
{
	my $sth = $dbh->prepare("SELECT WrapupData,count(WrapupData) from Calls_Report_Table where Calldate >= '$start_date 00:00:00' and Calldate <= '$end_date 23:59:59' group by WrapupData");
	if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
	if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
	$i=0;
	while (my ($data,$total) = $sth->fetchrow_array)
	{
		push @datas,$data;
		push @totals,$total;
		$i++;
	}
printf << "EOF";
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>Pershing Help Desk Table Report</title>
</head>

<body>
<table border=0>
  <tr>
	<th bgcolor=gray><font color=white>Wrapup Data</font></th>
	<th bgcolor=gray><font color=white>Total No of Calls</font></th>
EOF

for($j=0;$j<$i;$j++) {
	printf "\n<tr bgcolor=\#efefef><td width=\"10\%\">$datas[$j]</td><td width=\"10\%\"><p align=\"center\">$totals[$j]</p></td></tr>";
}

printf << "END";
</table>
</body>
</html>
END
}

if ($type eq "load")
{
	my $sth = $dbh->prepare("SELECT Agent_Name,count(Agent_Name) from Calls_Report_Table where Calldate >= '$start_date 00:00:00' and Calldate <= '$end_date 23:59:59' group by Agent_Name");
	if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
	if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
	$i=0;
	while (my ($name,$count) = $sth->fetchrow_array)
	{
		push @datas,$name;
		push @totals,$count;
		$i++;
	}
printf << "EOF";
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>Pershing Help Desk Table Report</title>
</head>

<body>
<table border=0>
  <tr>
	<th bgcolor=gray><font color=white>Agent Name</font></th>
        <th bgcolor=gray><font color=white>Total No of Calls</font></th>
EOF

for($j=0;$j<$i;$j++) {
	printf "\n<tr bgcolor=\#efefef><td width=\"10\%\">$datas[$j]</td><td width=\"10\%\"><p align=\"center\">$totals[$j]</p></td></tr>";
}


printf << "END";
</table>
</body>
</html>
END
}

if ($type eq "asa") 
{
	my $sth = $dbh->prepare("SELECT Agent_Name,round(avg(DelayTime),2) from Calls_Report_Table where Calldate >= '$start_date 00:00:00' and Calldate <= '$end_date 23:59:59' group by Agent_Name");
	if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
	if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
	$i=0;
	while (my ($name,$count) = $sth->fetchrow_array)
	{
		push @datas,$name;
		push @totals,$count;
		$i++;
	}
printf << "EOF";
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>Pershing Help Desk Table Report</title>
</head>

<body>
<table border=0>
  <tr>
	<th bgcolor=gray><font color=white>Agent Name</font></th>
	<th bgcolor=gray><font color=white>Average Speed of Answer</font></th>
EOF

for($j=0;$j<$i;$j++) {
	printf "\n<tr bgcolor=\#efefef><td width=\"10\%\">$datas[$j]</td><td width=\"10\%\"><p align=\"center\">$totals[$j]</p></td></tr>";
}


printf << "END";
</table>
</body>
</html>
END
}

if ($type eq "dist") 
{
	my $sth = $dbh->prepare("SELECT Day,count(Day) from Calls_Report_Table where Calldate >= '$start_date 00:00:00' and Calldate <= '$end_date 23:59:59' group by Day");
	if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
	if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
	$i=0;
	while (my ($day,$total_day) = $sth->fetchrow_array)
	{
		push @datas,$day;
		push @totals,$total_day;
		$i++;
	}
printf << "EOF";
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>Pershing Help Desk Table Report</title>
</head>

<body>
<table border=0>
  <tr>
	<th bgcolor=gray><font color=white>Day</font></th>
	<th bgcolor=gray><font color=white>Total No of Calls</font></th>
EOF

for($j=0;$j<$i;$j++) {
	printf "\n<tr bgcolor=\#efefef><td width=\"10\%\">$datas[$j]</td><td width=\"10\%\"><p align=\"center\">$totals[$j]</p></td></tr>";
}


printf << "END";
</table>
</body>
</html>
END
}

if ($type eq "hour")
{

@Hours = ( "05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20" );
%total_days = ();
$i = 0;
foreach $key (@Hours)
{

my $sth = $dbh->prepare("select count(date_format(calldate,'%H')) as hour from Calls_Report_Table where Calldate >= '$start_date 00:00:00' and Calldate <= '$end_date 23:59:59' and date_format(calldate,'%H') = '$key' group by date_format(calldate,'%D') order by hour");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
$j = 0;
$sum=0;
@total_calls = ();
$flag = 0;
while (($data) = $sth->fetchrow_array)
{
        push @total_calls,$data;
        $sum = $sum+$data;
        $j++;
        $flag = 1;
}
if ($flag eq 1)
{
        $avg[$i] = $sum/$j;
        $min[$i] = $total_calls[0];
        $max[$i] = $total_calls[$#total_calls];
}
else
{
        $avg[$i] = 0;
        $min[$i] = 0;
        $max[$i] = 0;
}
$i++;
}

printf << "EOF";
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>Pershing Help Desk Table Report</title>
</head>

<body>
<table border=0>
  <tr>
        <th bgcolor=gray><font color=white>Hours</font></th>
        <th bgcolor=gray><font color=white>Minimum No of Calls</font></th>
        <th bgcolor=gray><font color=white>Maximum No of Calls</font></th>
        <th bgcolor=gray><font color=white>Average No of Calls</font></th>
EOF

$j = 0;
foreach(@Hours) {
        printf "\n<tr bgcolor=\#efefef><td width=\"10\%\"><p align=\"center\">$Hours[$j]</p></td><td width=\"10\%\"><p align=\"center\">$min[$j]</p></td><td width=\"10\%\"><p align=\"center\">$max[$j]</p></td><td width=\"10\%\"><p align=\"center\">$avg[$j]</p></td></tr>";
$j++;
}


printf << "END";
</table>
</body>
</html>
END
}

if ($type eq "all") 
{
my $sth = $dbh->prepare("SELECT * FROM Calls_Report_Table where Calldate <= '$end_date 23:59:59' and Calldate >= '$start_date 00:00:00' order by calldate");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
$i = 0;
while ( ($Agent_Name,$DNIS,$Calldate,$WrapupData,$Duration,$RingTime,$DelayTime,$TimeToAband,$HoldTime,$TalkTime,$WorkTime) = $sth->fetchrow_array)
{
push @user,$Agent_Name;
push @dnis_no,$DNIS;
push @call,$Calldate;
push @wrap,$WrapupData;
push @dura,$Duration;
push @ring,$RingTime;
push @delay,$DelayTime;
push @time,$TimeToAband;
push @hold,$HoldTime;
push @talk,$TalkTime;
push @work,$WorkTime;
$i++;
}

printf << "EOF";
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>Pershing Help Desk Table Report</title>
</head>

<body>
<table border=0>
  <tr>
	<th bgcolor=gray><font color=white>Agent Name</font></th>
	<th bgcolor=gray><font color=white>DNIS</font></th>
	<th bgcolor=gray><font color=white>Calldate</font></th>
	<th bgcolor=gray><font color=white>WrapupData</font></th>
	<th bgcolor=gray><font color=white>Duration</font></th>
	<th bgcolor=gray><font color=white>RingTime</font></th>
	<th bgcolor=gray><font color=white>DelayTime</font></th>
	<th bgcolor=gray><font color=white>TimeToAband</font></th>
	<th bgcolor=gray><font color=white>HoldTime</font></th>
	<th bgcolor=gray><font color=white>TalkTime</font></th>
	<th bgcolor=gray><font color=white>WorkTime</font></th>
  </tr>

EOF

for($j=0;$j<$i;$j++) {
	printf "\n<tr bgcolor=\#efefef><td width=\"10\%\">$user[$j]</td><td width=\"10\%\"><p align=\"center\">$dnis_no[$j]</p></td><td width=\"10\%\"><p align=\"center\">$call[$j]</p></td><td width=\"10\%\"><p align=\"center\">$wrap[$j]</p></td><td width=\"10\%\"><p align=\"center\">$dura[$j]</p></td><td width=\"10\%\"><p align=\"center\">$ring[$j]</p></td><td width=\"10\%\"><p align=\"center\">$delay[$j]</p></td><td width=\"10\%\"><p align=\"center\">$time[$j]</p></td><td width=\"10\%\"><p align=\"center\">$hold[$j]</p></td><td width=\"10\%\"><p align=\"center\">$talk[$j]</p></td><td width=\"10\%\"><p align=\"center\">$work[$j]</p></td></tr>";
}


printf << "END";
</table>
</body>
</html>
END
}
