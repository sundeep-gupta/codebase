#!/usr/bin/perl
use DBD::mysql;
use perlchartdir;
use CGI;
$q = new CGI;

print "Content-type:text/html\n\n";
$dept = $q->param('dept');
@id=split(/\-/,$dept);$deptid=$id[0];
$start_date = $q->param('idate');
$end_date = $q->param('rdate');



#####
##### Here is the data fetch part for Size Info
#####  
$dsn = "DBI:mysql:database=isa_mysql;host=localhost";
$dbh = DBI->connect($dsn,"root",tst123);
my $sth = $dbh->prepare("SELECT clientusername, sum(bytesrecvd+bytessent) as val FROM ConsolidatedUserWebProxyLog where deptid = $deptid and logdate <= '$end_date 23:59:59' and logdate >= '$start_date 00:00:00' group by clientusername order by val desc limit 30");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}

while (my ($username,$Count) = $sth->fetchrow_array)
{
($domain,$user)=split(/\\/,$username);
$user =~ tr/A-Z/a-z/;
push @eid,$user;
push @data,int($Count/1024);
}

#####
##### This part is for the Employee ID Name mapping
#####
my $sth = $dbh->prepare("SELECT empid,firstname,secondname from employees");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
while (my ($id,$firstname,$secondname) = $sth->fetchrow_array)
{
$id =~ tr/A-Z/a-z/;
$Name{$id}=$id."-".$firstname;
}

foreach $id (@eid)
{
if (!defined($Name{$id})) { push @labels,$id; }
else { push @labels,$Name{$id}; }
}


#####
##### Graphing Part here
#####
 
my $c = new XYChart(800, 800);
$c->addTitle("Internet Users of $dept - $start_date to $end_date", "arialbi.ttf");
$c->setPlotArea(125, 30, 700, 750, $perlchartdir::Transparent,
    $perlchartdir::Transparent, $perlchartdir::Transparent,
    $perlchartdir::Transparent, $perlchartdir::Transparent);
my $layer = $c->addBarLayer(\@data, $c->gradientColor(125, 0, 775, 0, 0x8000,
    0xffffff));
$c->swapXY(1);
$layer->setBarGap(0.1);
$layer->setAggregateLabelFormat("{value} KB");
$layer->setAggregateLabelStyle("timesbi.ttf", 10, 0x663300);
my $textbox = $c->xAxis()->setLabels(\@labels);
$textbox->setFontStyle("arial.ttf");
$textbox->setFontSize(6);
$c->xAxis()->setColors($perlchartdir::Transparent, 0x663300);
$c->yAxis()->setColors($perlchartdir::Transparent, $perlchartdir::Transparent);
my $chart1URL = $c->makeTmpFile("/tmp/tmpcharts");
my $imageMap = $c->getHTMLImageMap("isa_historical_peruser_report.pl","user={xLabel}&idate=$start_date&rdate=$end_date" ,"title='{xLabel}: {value|0}'");

# $c->makeChart("/var/www/html/images/size_current.png");

printf <<"EOF";
<html><head><title>Internet Usage Report</title>

<body><table border="0" width="99%" cellpadding="2" cellspacing="0">
  <tr><td width="100%" colspan="2" bgcolor="#003399"><p align="center">

<b><font color="#FFFFFF">Internet Usage Report</font></b></p>
    </td></tr>

<tr><td width="100%" colspan="2" bgcolor="#F6F6F6"><p><b>Top Users by Bytes Transferred </b></td></tr>
<tr><td width="100%" colspan="2" bgcolor="#F6F6F6">
<img src="myimage.pl?img=/tmp/tmpcharts/$chart1URL" border="0" usemap="#map1">
<a href="http://172.25.10.121/cgi-bin/isa_historical_database_report.pl?data=dept&deptid=$deptid&idate=$start_date&rdate=$end_date"><img src="http://172.25.10.121/excel.gif" border="0" align="top" width="16" height="13" ></a>
<map name="map1">
$imageMap
</map>

</td></tr>

</table>
</form></body>
</html>
EOF

