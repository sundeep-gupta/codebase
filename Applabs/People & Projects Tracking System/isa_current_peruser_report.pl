#!/usr/bin/perl
use DBD::mysql;
use perlchartdir;
use CGI;
$q = new CGI;

print "Content-type:text/html\n\n";
$user = $q->param('user');
# print "$user\n";
@id=split(/\-/,$user);$empid=$id[0];

#####
##### Here is the data fetch part for Size Info
#####  
$dsn = "DBI:mysql:database=isa_mysql;host=localhost";
$dbh = DBI->connect($dsn,"root",tst123);
# my $sth = $dbh->prepare("SELECT DestHost,sum(bytesrecvd+bytessent) as val FROM DailyUserWebProxyLog where clientusername like '%$empid%' group by DestHost order by val desc limit 20");
my $sth = $dbh->prepare("SELECT DestHost,sum(bytesrecvd+bytessent) as val FROM DailyUserWebProxyLog where clientusername like '%$empid' group by DestHost order by val desc limit 20");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}

while (my ($site,$Count) = $sth->fetchrow_array)
{
push @labels,$site;
push @data,int($Count/1024);
}

#####
##### Graphing Part here
#####
 
my $c = new XYChart(800, 400);
$c->addTitle("Top 20 Sites Visited by $user - Today", "arialbi.ttf");
$c->setPlotArea(125, 30, 700, 350, $perlchartdir::Transparent,
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
my $imageMap = $c->getHTMLImageMap("isa_current_persite_report.pl","site={xLabel}" ,"title='{xLabel}: {value|0}'");

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
<a href="http://172.25.10.121/cgi-bin/isa_current_database_report.pl?data=user&empid=$empid"><img src="http://172.25.10.121/excel.gif" border="0" align="top" width="16" height="13" ></a>
<map name="map1">
$imageMap
</map>
</td></tr>

</table>
</form></body>
</html>
EOF

