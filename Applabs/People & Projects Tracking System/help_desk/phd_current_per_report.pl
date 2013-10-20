#!/usr/bin/perl
use DBD::mysql;
use perlchartdir;
use Date::Manip;
use Number::Format;
my $x = new Number::Format %args;
use CGI;
$q = new CGI;


print "Content-type:text/html\n\n";

$start_date = $q->param('idate');
$end_date = $q->param('rdate');
$type = $q->param('type');
$day = $q->param('day1');
print $day1;
@start = split(/-/,$start_date);
@end = split(/-/,$end_date);
$start_dt = ParseDate(\@start);
$end_dt = ParseDate(\@end);
$start_month = UnixDate($start_dt,"%b %d");
$end_month = UnixDate($end_dt,"%b %d");
# print "$start_month \t $end_month\n";
# print "$type \t $type_name\n";

$dsn = "DBI:mysql:database=Help_desk;host=localhost";
$dbh = DBI->connect($dsn,"root",tst123 );

if ( $type eq "user" and $day ne "")
{
$type_name = $q->param('user');
my $sth = $dbh->prepare("SELECT WrapupData, count(WrapupData) as wdt from Calls_Report_Table where Calldate >= '$start_date 00:00:00' and Calldate <= '$end_date 23:59:59' and Agent_name = '$type_name' and day = '$day' group by WrapupData order by wdt desc");

if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
while (my ($name,$count) = $sth->fetchrow_array)
{
push @wrapup_nameR,$name;
push @total_callR,$count;
$Total_Batch_Size += $count;
}
@wrapup_name=reverse(@wrapup_nameR);
@total_call=reverse(@total_callR);
# print "@wrapup_name<br>";
# print "@total_call<br>";

$height =  ($#wrapup_name * 100);
# print $height;
}


if ( $type eq "user" and $day eq "")
{
$type_name = $q->param('user');
my $sth = $dbh->prepare("SELECT WrapupData, count(WrapupData) as wdt from Calls_Report_Table where Calldate >= '$start_date 00:00:00' and Calldate <= '$end_date 23:59:59' and Agent_name = '$type_name' group by WrapupData order by wdt desc");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
while (my ($name,$count) = $sth->fetchrow_array)
{
push @wrapup_nameR,$name;
push @total_callR,$count;
$Total_Batch_Size += $count;
}
@wrapup_name=reverse(@wrapup_nameR);
@total_call=reverse(@total_callR);
# print "@wrapup_name<br>";
# print "@total_call<br>";

$height =  ($#wrapup_name * 100);
# print $height;
}

if ( $type eq "day" )
{
$type_name = $q->param('day');
my $sth = $dbh->prepare("SELECT agent_name, count(agent_name) as wdt from Calls_Report_Table where Calldate >= '$start_date 00:00:00' and Calldate <= '$end_date 23:59:59' and day = '$type_name' group by agent_name order by wdt desc");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
while (my ($name,$count) = $sth->fetchrow_array)
{
push @wrapup_nameR,$name;
push @total_callR,$count;
$Total_Batch_Size += $count;
}
@wrapup_name=reverse(@wrapup_nameR);
@total_call=reverse(@total_callR);
# print "@wrapup_name<br>";
# print "@total_call<br>";

$height =  ($#wrapup_name * 100);
# print $height;
}

if ( $type eq "wrapup" )
{  $type_name = $q->param('wrapup'); 
my $sth = $dbh->prepare("SELECT agent_name, count(agent_name) as wdt from Calls_Report_Table where Calldate >= '$start_date 00:00:00' and Calldate <= '$end_date 23:59:59' and wrapupdata like '$type_name%' group by agent_name order by wdt desc");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
while (my ($name,$count) = $sth->fetchrow_array)
{
push @wrapup_nameR,$name;
push @total_callR,$count;
$Total_Batch_Size += $count;
}
@wrapup_name=reverse(@wrapup_nameR);
@total_call=reverse(@total_callR);
# print "@wrapup_name<br>";
# print "@total_call<br>";
if ( $#wrapup_name eq 0)
{ $height = 100; }
else
{ $height =  ($#wrapup_name * 100); }
}

if ( $type eq "avg" )
{  $type_name = $q->param('avguser'); 
my $sth = $dbh->prepare("SELECT WrapupData, round(avg(DelayTime),2) as wdt from Calls_Report_Table where Calldate >= '$start_date 00:00:00' and Calldate <= '$end_date 23:59:59' and agent_name = '$type_name' group by wrapupdata order by wdt desc");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
while (my ($name,$count) = $sth->fetchrow_array)
{
push @wrapup_nameR,$name;
push @total_callR,$count;
}
@wrapup_name=reverse(@wrapup_nameR);
@total_call=reverse(@total_callR);
# print "@wrapup_name<br>";
# print "@total_call<br>";
my $sth = $dbh->prepare("SELECT round(avg(DelayTime),2) from Calls_Report_Table where Calldate >= '$start_date 00:00:00' and Calldate <= '$end_date 23:59:59' and agent_name = '$type_name' ");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
$asa = $sth->fetchrow_array;
$Total_Batch_Size = $asa;
$height =  ($#wrapup_name * 100);
# print $height;
}

if ( $type eq "hour" )
{  $type_name = $q->param('Hour'); 
my $sth = $dbh->prepare("SELECT WrapupData, count(wrapupdata) as wdt from Calls_Report_Table where Calldate >= '$start_date 00:00:00' and Calldate <= '$end_date 23:59:59' and DATE_FORMAT(calldate,'%H:00') = '$type_name' and day = '$day' group by wrapupdata order by wdt desc");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
while (my ($name,$count) = $sth->fetchrow_array)
{
push @wrapup_nameR,$name;
push @total_callR,$count;
$Total_Batch_Size += $count;
}
@wrapup_name=reverse(@wrapup_nameR);
@total_call=reverse(@total_callR);
# print "@wrapup_name<br>";
# print "@total_call<br>";

$height =  ($#wrapup_name * 100);
# print $height;
}

my $c = new XYChart(800, $height);
if ( $type eq "user" and $day ne "")
{
$c->addTitle(" Work Load by $type_name on $day - $start_month to $end_month ", "arialbi.ttf");
}
if ( $type eq "user" and $day eq "")
{
$c->addTitle(" Work Load by $type_name - $start_month to $end_month ", "arialbi.ttf");
}

if ( $type eq "day" )
{
$c->addTitle(" Call Distribution on $type_name - $start_month to $end_month ", "arialbi.ttf");
}
if ( $type eq "wrapup" )
{
$c->addTitle(" Call Categories on $type_name - $start_month to $end_month ", "arialbi.ttf");
}
if ( $type eq "avg" )
{
$c->addTitle(" Average Speed of Answer by $type_name - $start_month to $end_month ", "arialbi.ttf");
}
if ( $type eq "hour" )
{
$c->addTitle(" Load Distribution at $type_name on - $start_month to $end_month ", "arialbi.ttf");
}
$c->setPlotArea(125, 30, 700, ($height-50), $perlchartdir::Transparent,
    $perlchartdir::Transparent, $perlchartdir::Transparent,
    $perlchartdir::Transparent, $perlchartdir::Transparent);
$layer = $c->addBarLayer(\@total_call, $c->gradientColor(125, 0, 775, 0, 0x8000,0xffffff));
$layer->setAggregateLabelFormat("{value}");
$c->swapXY(1);
$layer->setBarGap(0.1);
$layer->setAggregateLabelStyle("timesbi.ttf", 10, 0x663300);
my $textbox = $c->xAxis()->setLabels(\@wrapup_name);
$textbox->setFontStyle("arial.ttf");
$textbox->setFontSize(6);
$c->xAxis()->setColors($perlchartdir::Transparent, 0x663300);
$c->yAxis()->setColors($perlchartdir::Transparent, $perlchartdir::Transparent);
my $chart1URL = $c->makeTmpFile("/tmp/1/");
if ( $type eq "day" )
{
  $imageMap1 = $c->getHTMLImageMap("phd_current_per_report.pl","type=user&day1=$type_name&user={xLabel}&idate=$start_date&rdate=$end_date" ,"title='{xLabel}: {value|0}'");
}

printf <<"EOF";
<html><head><title>Pershing Helpdesk Report - Report</title>
<body>
<form name="sampleform" method="POST" action="/cgi-bin/tpva/server_report.pl">
<table border="0" width="99%" cellpadding="3" cellspacing="0">
  <tr><td width="100%" colspan="3" bgcolor="#003399"><p align="center">
<b><font color="#FFFFFF">Pershing Helpdesk Performance</font></b></p>
    </td></tr>

<tr><td width="100%" colspan="3" bgcolor="#F6F6F6"><p><b>
EOF

if ( $type eq "user" and $day ne "")
{
	printf "Number of Calls attended by $type_name on $day : $Total_Batch_Size ";
}
if ( $type eq "user" and $day eq "")
{
printf "Number of Calls attended by $type_name : $Total_Batch_Size ";
}
if ( $type eq "day" )
{
printf "Number of Calls on $type_name : $Total_Batch_Size ";
}
if ( $type eq "wrapup" )
{
printf "Number of $type_name : $Total_Batch_Size ";
}
if ( $type eq "avg" )
{
printf "Average Speed of Answer by $type_name : $Total_Batch_Size ";
}
if ( $type eq "hour" )
{
printf "Number of Calls at $type_name : $Total_Batch_Size ";
}

printf <<"EOF";
</b></td></tr>
<tr><td width="100%" colspan="3" bgcolor="#F6F6F6">

<img src="myimage.pl?img=/tmp/1/$chart1URL" border="0" usemap="#map1">
<map name="map1">
$imageMap1
</map>
</td></tr>
</table>
</form></body>
</html>
EOF


