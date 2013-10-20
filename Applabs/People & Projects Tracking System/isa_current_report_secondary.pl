#!/usr/bin/perl
use DBD::mysql;
use perlchartdir;
use CGI;
$q = new CGI;

print "Content-type:text/html\n\n";
# $report_date = $q->param('report_date');

#####
##### This part is for the Employee ID Name mapping
#####
$dsn = "DBI:mysql:database=isa_mysql;host=localhost";
$dbh = DBI->connect($dsn,"root",tst123);

my $sth = $dbh->prepare("SELECT empid,firstname,secondname from employees");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
while (my ($id,$firstname,$secondname) = $sth->fetchrow_array)
{
$id =~ tr/A-Z/a-z/;
$Name{$id}=$id."-".$firstname;
}

#####
##### This part is for the Departmant ID Dept Name mapping
#####
my $sth = $dbh->prepare("SELECT dept_id,dept_name from department");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
while (my ($dept_id,$dept_name) = $sth->fetchrow_array)
{
$DeptName{$dept_id}=$dept_id."-".$dept_name;
}


#####
##### Here is the data fetch part for Size Info
#####  
# $dsn = "DBI:mysql:database=isa_mysql;host=localhost";
# $dbh = DBI->connect($dsn,"root",tst123);
my $sth = $dbh->prepare("SELECT clientusername,sum(bytesrecvd+bytessent) as val FROM DailyUserWebProxyLog group by clientusername order by val desc limit 10");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}

while (my ($username,$Count) = $sth->fetchrow_array)
{
($domain,$user)=split(/\\/,$username);
$user =~ tr/A-Z/a-z/;
push @eid,$user;
push @data,int($Count/(1024*1024));
}

foreach $id (@eid)
{
if (!defined($Name{$id})) { push @labels,$id; }
else { push @labels,$Name{$id}; }
}


#####
##### Here is the data fetch part for Size Info for Sites
#####
# $dsn = "DBI:mysql:database=isa_mysql;host=localhost";
# $dbh = DBI->connect($dsn,"root",tst123);
my $sth = $dbh->prepare("SELECT DestHost,sum(bytesrecvd+bytessent) as val FROM DailyUserWebProxyLog group by DestHost order by val desc limit 10");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}

while (my ($Site,$Count) = $sth->fetchrow_array)
{
push @labels_site,$Site;
push @data_site,int($Count/(1024*1024));
}

#####
##### Here is the data fetch part for Size Info for Sites
#####
# $dsn = "DBI:mysql:database=isa_mysql;host=localhost";
# $dbh = DBI->connect($dsn,"root",tst123);
my $sth = $dbh->prepare("SELECT deptid, sum(bytesrecvd+bytessent) as val FROM DailyUserWebProxyLog where deptid <> 'NULL' group by deptid order by val desc");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}

while (my ($Dept_Id,$Count) = $sth->fetchrow_array)
{
push @dept_id,$Dept_Id;
push @data_dept,int($Count/(1024*1024));
}
foreach $deptid (@dept_id)
{push @labels_dept,$DeptName{$deptid};}

# print "\nDepartments: @dept_id";
#####
##### Graphing Part here
#####
 
my $c = new XYChart(600, 250);
$c->addTitle("Top 10 Internet Users by Bytes Transferred - Today", "arialbi.ttf");
$c->setPlotArea(100, 30, 400, 200, $perlchartdir::Transparent,
    $perlchartdir::Transparent, $perlchartdir::Transparent,
    $perlchartdir::Transparent, $perlchartdir::Transparent);
my $layer = $c->addBarLayer(\@data, $c->gradientColor(100, 0, 500, 0, 0x8000,
    0xffffff));
$c->swapXY(1);
$layer->setBarGap(0.1);
$layer->setAggregateLabelFormat("{value} MB");
$layer->setAggregateLabelStyle("timesbi.ttf", 10, 0x663300);
my $textbox = $c->xAxis()->setLabels(\@labels);
$textbox->setFontStyle("arial.ttf");
$textbox->setFontSize(6);
$c->xAxis()->setColors($perlchartdir::Transparent, 0x663300);
$c->yAxis()->setColors($perlchartdir::Transparent, $perlchartdir::Transparent);
my $chart1URL = $c->makeTmpFile("/tmp/tmpcharts/1");
my $imageMap = $c->getHTMLImageMap("isa_current_peruser_report.pl","user={xLabel}" ,"title='{xLabel}: {value|0}'");

my $d = new XYChart(600, 250);
$d->addTitle("Top 10 Internet Sites by Bytes Transferred - Today", "arialbi.ttf");
$d->setPlotArea(100, 30, 400, 200, $perlchartdir::Transparent,
    $perlchartdir::Transparent, $perlchartdir::Transparent,
    $perlchartdir::Transparent, $perlchartdir::Transparent);
my $layer = $d->addBarLayer(\@data_site, $d->gradientColor(100, 0, 500, 0, 0x8000,
    0xffffff));
$d->swapXY(1);
$layer->setBarGap(0.1);
$layer->setAggregateLabelFormat("{value} MB");
$layer->setAggregateLabelStyle("timesbi.ttf", 10, 0x663300);
my $textbox = $d->xAxis()->setLabels(\@labels_site);
$textbox->setFontStyle("arial.ttf");
$textbox->setFontSize(6);
$d->xAxis()->setColors($perlchartdir::Transparent, 0x663300);
$d->yAxis()->setColors($perlchartdir::Transparent, $perlchartdir::Transparent);
my $chart2URL = $d->makeTmpFile("/tmp/tmpcharts/2");
my $imageMap2 = $d->getHTMLImageMap("isa_current_persite_report.pl","site={xLabel}" ,"title='{xLabel}: {value|0}'");


my $e = new XYChart(600, 350);
$e->addTitle("Department Wise Usage by Bytes Transferred - Today", "arialbi.ttf");
$e->setPlotArea(100, 30, 400, 300, $perlchartdir::Transparent,
    $perlchartdir::Transparent, $perlchartdir::Transparent,
    $perlchartdir::Transparent, $perlchartdir::Transparent);
my $layer = $e->addBarLayer(\@data_dept, $e->gradientColor(100, 0, 500, 0, 0x8000,
    0xffffff));
$e->swapXY(1);
$layer->setBarGap(0.1);
$layer->setAggregateLabelFormat("{value} MB");
$layer->setAggregateLabelStyle("timesbi.ttf", 10, 0x663300);
my $textbox = $e->xAxis()->setLabels(\@labels_dept);
$textbox->setFontStyle("arial.ttf");
$textbox->setFontSize(6);
$e->xAxis()->setColors($perlchartdir::Transparent, 0x663300);
$e->yAxis()->setColors($perlchartdir::Transparent, $perlchartdir::Transparent);
my $chart3URL = $e->makeTmpFile("/tmp/tmpcharts/3");
my $imageMap3 = $e->getHTMLImageMap("isa_current_perdept_report.pl","dept={xLabel}" ,"title='{xLabel}: {value|0}'");

my $sth = $dbh->prepare("SELECT DATE_FORMAT(logDate,'%H'), round(sum(bytesrecvd+bytessent)/1024/1024,0) as MB_Transferred, 
count(distinct(clientusername)) FROM DailyUserWebProxyLog GROUP BY DATE_FORMAT(logDate, '%H')");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}

while (my ($hours,$size) = $sth->fetchrow_array)
{
push @Time,$hours;
#push @Size_MB,int($size);
$Size_MB{$hours} = int($size);
}

sub my_sort {
  # got hash keys $a and $b automatically
  return $a <=> $b;
}

$j=0;
foreach $key (sort my_sort keys %Size_MB)
{ 
	$k=$key;
	if( $j == $k )
	{
		push (@bytes_fp,($Size_MB{$key})); 
		$j++;
	}
	else
	{
		for($n=$j;$n<$k;$n++)
		{
			push (@bytes_fp,0);
		}
		$j=$n;
		if( $j eq $k )
		{
			push (@bytes_fp,($Size_MB{$key})); 
			$j++;
		}
	}
}

for ($i=0;$i<24 ;$i++) { push (@Time_all,$i); }

# print "@bytes_fp<br>";

my $f = new XYChart(600, 400);
$f->addTitle("Total Usage by Bytes Transferred per Hour - Today", "arialbi.ttf");
$f->yAxis()->setTitle("Size in MB");
$f->xAxis()->setTitle("Time in Hours");
$f->setPlotArea(80, 30, 500, 300);
my $layer = $f->addBarLayer2($perlchartdir::Side, 1);
# $layer->addDataSet(\@data, 0x3333cc, "Number of Files");
# $layer->addDataSet(\@Size_MB, 0xc3c3e6, "Total Size MB");
$layer->addDataSet(\@bytes_fp, $f->gradientColor(0, 500, 80, 0, 0x8000, 0xffffff), "Total Size MB");
$layer->setBarGap(0);
$f->xAxis()->setLabels(\@Time_all)->setFontStyle("arialbd.ttf");
$f->yAxis()->setLabelStyle("arialbd.ttf");
my $chart4URL = $f->makeTmpFile("/tmp/tmpcharts/4");
my $imageMap4 = $f->getHTMLImageMap("isa_current_perhour_report.pl","time={xLabel}","title='{dataSetName}: {value|0}'");

my $sth = $dbh->prepare("select objectsource,sum(bytesrecvd+bytessent) as val from DailyCacheWebProxyLog group by objectsource order by val desc limit 6");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}

while (my ($Cache,$Count) = $sth->fetchrow_array)
{
push @labels_cache,$Cache;
push @data_cache,int($Count/(1024*1024));
}
my $depths = [30, 25, 20, 15, 10, 5, 0];

my $g = new PieChart(500, 330, 0xccccff, -1, 1);
$g->addTitle("Proxy Server Source Breakdown", "timesbi.ttf", 14)->setBackground( 0x9999ff);
$g->setPieSize(250, 150, 105);
$g->set3D();
$g->setLabelLayout($perlchartdir::SideLayout);
$g->setLabelStyle()->setBackground($perlchartdir::SameAsMainColor,$perlchartdir::Transparent, 1);
$g->setLineColor($perlchartdir::SameAsMainColor, 0x0);
$g->setStartAngle(225);
$g->setData(\@data_cache, \@labels_cache);
my $chart5URL = $g->makeTmpFile("/tmp/tmpcharts/5");




printf <<"EOF";
<html><head><title>Internet Usage Report</title>
<form name="sampleform" method="POST" action="/cgi-bin/isa_historical_report.pl">
<SCRIPT language=javascript 
src="/javascript/cal2.js"></SCRIPT>
<SCRIPT language=javascript 
src="/javascript/cal_conf2.js"></SCRIPT>
</head>
<body><table border="0" width="99%" cellpadding="2" cellspacing="0">
  <tr><td width="100%" colspan="2" bgcolor="#003399"><p align="center">

<b><font color="#FFFFFF">Internet Usage Report</font></b></p>
    </td></tr>

<tr><td width="100%" colspan="2" bgcolor="#F6F6F6"><p><b>Select Date for Report</b></td></tr>
<tr><td width="50%" bgcolor="#F6F6F6">
<p align="center"><b>From&nbsp;</b>&nbsp;&nbsp;&nbsp; <INPUT name=idate size="20"><SMALL><A
      href="javascript:showCal('Calendar1')">  Date</A></small>
<td width="50%" bgcolor="#F6F6F6">
<p align="center"><b>To</b>&nbsp;&nbsp;&nbsp; <INPUT name=rdate size="20"><SMALL><A
      href="javascript:showCal('Calendar2')">  Date</A></small>
<tr><td width="100%" colspan="2" bgcolor="#F6F6F6">
<p align="center"><input type="submit" value="Submit" name="B1">
</td></tr>
<tr><td width="100%" colspan="2" bgcolor="#F6F6F6"></td></tr>
<tr><td width="100%" colspan="2" bgcolor="#F6F6F6"><p align="left"> <strong>Note: </strong> Select To Date & From Date as same day to get any particular day's report
<br></td></tr>
<tr><td width="100%" colspan="2" bgcolor="#FFFFFF" height="3"></td></tr>


<tr><td width="100%" colspan="2" bgcolor="#F6F6F6"><p><b>Top Users by Bytes Transferred - Click on the Green Bar to get Finer Details</b></td></tr>
<tr><td width="100%" colspan="2" bgcolor="#F6F6F6">
<img src="myimage.pl?img=/tmp/tmpcharts/1/$chart1URL" border="0" usemap="#map1">
<a href="http://172.25.10.121/cgi-bin/isa_current_database_report.pl?data=user"><img src="http://172.25.10.121/excel.gif" border="0" align="top" width="16" height="13" ></a><map name="map1">
$imageMap
</map>
<tr><td width="100%" colspan="2" bgcolor="#FFFFFF" height="3"></td></tr>


<tr><td width="100%" colspan="2" bgcolor="#F6F6F6"><p><b>Top Sites by Bytes Transferred </b></td></tr>
<tr><td width="100%" colspan="2" bgcolor="#F6F6F6">
<img src="myimage.pl?img=/tmp/tmpcharts/2/$chart2URL" border="0" usemap="#map2">
<a href="http://172.25.10.121/cgi-bin/isa_current_database_report.pl?data=site"><img src="http://172.25.10.121/excel.gif" border="0" align="top" width="16" height="13" ></a><map name="map2">
$imageMap2
</map>
<tr><td width="100%" colspan="2" bgcolor="#FFFFFF" height="3"></td></tr>


<tr><td width="100%" colspan="2" bgcolor="#F6F6F6"><p><b>Department Wise Usage by Bytes Transferred </b></td></tr>
<tr><td width="100%" colspan="2" bgcolor="#F6F6F6">
<img src="myimage.pl?img=/tmp/tmpcharts/3/$chart3URL" border="0" usemap="#map3">
<a href="http://172.25.10.121/cgi-bin/isa_current_database_report.pl?data=dept"><img src="http://172.25.10.121/excel.gif" border="0" align="top" width="16" height="13" ></a><map name="map3">
$imageMap3
</map>
<tr><td width="100%" colspan="2" bgcolor="#FFFFFF" height="3"></td></tr>


<tr><td width="100%" colspan="2" bgcolor="#F6F6F6"><p><b>Total Usage by Bytes Transferred </b></td></tr>
<tr><td width="100%" colspan="2" bgcolor="#F6F6F6">
<img src="myimage.pl?img=/tmp/tmpcharts/4/$chart4URL" border="0" usemap="#map4">
<a href="http://172.25.10.121/cgi-bin/isa_current_database_report.pl?data=time"><img src="http://172.25.10.121/excel.gif" border="0" align="top" width="16" height="13" ></a><map name="map4">
$imageMap4
</map>
<tr><td width="100%" colspan="2" bgcolor="#FFFFFF" height="3"></td></tr>


<tr><td width="100%" colspan="2" bgcolor="#F6F6F6"><p><b>Proxy Server Cache Usage </b></td></tr>
<tr><td width="50%" colspan="1" bgcolor="#F6F6F6">
<img src="myimage.pl?img=/tmp/tmpcharts/5/$chart5URL" border="0">


</td><td width="50%" bgcolor="#F6F6F6">
<strong>0</strong> = No information available<br>
<strong>Cache</strong> = Source is the Proxy cache<br>
<strong>Inet</strong> = Source is the Internet<br>
<strong>VCache</strong> = Source is cache. Object was verified against original
source<br>
<strong>NVCache</strong> = Source is cache but original source could not be
verified<br>
<strong>VFInet</strong> = Source is Internet. Object was in cache, but original
source was newer.<br>
<strong>NotModified</strong> = Object retrieved from cache. Client performed an
If-Modofied-Since and object was found to be current<br>
<strong>MemberObject</strong> = Source is the cache of another Proxy array
member server<br>
<strong>Upstream </strong>= Source is an upstream Proxy Server's cache

</td></tr>
<tr><td width="100%" colspan="2" bgcolor="#FFFFFF" height="3"></td></tr>



</table>
</form></body>
</html>
EOF

