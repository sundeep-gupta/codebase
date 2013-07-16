#!/usr/bin/perl
use DBD::mysql;
use perlchartdir;
use Date::Manip;

@month = ( "Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec" );
@wrapup = ( "Desktop Issues","Imaging Issues","Mainframe Printer Issues","Non-Productive Calls","Password Reset","Test Calls","Training/Mock Calls","Unix Issues" );
print "Content-type:text/html\n\n";

$dsn = "DBI:mysql:database=Help_desk;host=localhost";
$dbh = DBI->connect($dsn,"root",tst123 );

my $sth = $dbh->prepare("select distinct(DATE_FORMAT(calldate,'%Y')) from Calls_Report_Table");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
while (my ($year) = $sth->fetchrow_array)
{
push @yr,$year;
}
print "@yr<br>";

foreach $key (@yr)
{
my $sth = $dbh->prepare("select DATE_FORMAT(calldate,'%b') as dt, count(WrapupData) from Calls_Report_Table where DATE_FORMAT(calldate,'%Y')='$key' group by dt desc");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
while (my ($mon,$count) = $sth->fetchrow_array)
{
push @months,$mon;
push @total_call,$count;
}
}
$i = 0;
foreach $key (@months)
{
my $sth = $dbh->prepare("select WrapupData,count(WrapupData) as ct from Calls_Report_Table where DATE_FORMAT(calldate,'%b') = '$key' group by WrapupData ");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
$j = 0;
while (my ($data,$count_data) = $sth->fetchrow_array)
{
$count_wrapup[$j][$i] = $count_data;
# print "$count_wrapup[$i][$j]<br>";
$j++;
}
$i++;
}

my $f = new XYChart(500, 250);
$f->addTitle("Work Load per month");
$f->yAxis()->setTitle("Total No of Calls");
$f->xAxis()->setTitle("Months");
$f->setPlotArea(80, 30, 350, 150);
my $layer = $f->addBarLayer2($perlchartdir::Side, 1);
$layer->addDataSet(\@total_call, $f->gradientColor(0, 500, 80, 0, 0x8000, 0xffffff), "");
$layer->setAggregateLabelStyle();
$layer->setBarGap(0.6);
$f->xAxis()->setLabels(\@months)->setFontStyle("arialbd.ttf");
$f->yAxis()->setLabelStyle("arialbd.ttf");
my $chart1URL = $f->makeTmpFile("/tmp/1/");

my $c = new XYChart(970, 350);
$c->setPlotArea(60, 60, 280, 240);
$c->addLegend(55, 25, 0, "", 8)->setBackground($perlchartdir::Transparent);
$c->addTitle("Monthly Call Categories");
$c->yAxis()->setTitle("Total No of Calls");
$c->xAxis()->setLabels(\@months);
$c->xAxis()->setTitle("Months");
my $layer = $c->addBarLayer2($perlchartdir::Stack, 1);
$layer->addDataSet($count_wrapup[0], -1, "Desktop Issues");
$layer->addDataSet($count_wrapup[1], -1, "Imaging Issues");
$layer->addDataSet($count_wrapup[2], -1, "Mainframe Printer Issues");
$layer->addDataSet($count_wrapup[3], -1, "Non-Productive Calls");
$layer->addDataSet($count_wrapup[4], -1, "Password Reset");
$layer->addDataSet($count_wrapup[5], -1, "Test Calls");
$layer->addDataSet($count_wrapup[6], -1, "Training/Mock Calls");
$layer->addDataSet($count_wrapup[7], -1, "Unix Issues");
$layer->setAggregateLabelStyle();
$layer->setBarGap(0.6);
$layer->setDataLabelStyle();
my $chart2URL = $c->makeTmpFile("/tmp/2/");


printf <<"EOF";
<html><head><title>Pershing Helpdesk Report</title>
</head>
<body><table border="0" width="99%" cellpadding="2" cellspacing="0">

<tr><td width="50%" colspan="1" bgcolor="#F6F6F6">
<img src="myimage.pl?img=/tmp/1/$chart1URL" border="0">
</td></tr>

<tr><td width="50%" colspan="1" bgcolor="#F6F6F6">
<img src="myimage.pl?img=/tmp/2/$chart2URL" border="0">
</td></tr>

</table>
</body>
</html>
EOF
