#!/usr/bin/perl
use DBD::mysql;
use perlchartdir;
use CGI;
$q = new CGI;

print "Content-type:text/html\n\n";
$report_date = $q->param('report_date');


#####
##### Here is the data fetch part for Size Info
#####  
$dsn = "DBI:mysql:database=isa_mysql;host=inatpuxven01";
$dbh = DBI->connect($dsn, root, tst123);
my $sth = $dbh->prepare("SELECT clientusername,sum(bytesrecvd+bytessent) as val FROM WebProxyLog where clientusername not like '%anonymous%' and  logdate = '$report_date' group by clientusername order by val desc limit 10");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}

while (my ($username,$Count) = $sth->fetchrow_array)
{
($domain,$user)=split(/\\/,$username);
$user =~ tr/A-Z/a-z/;
push @eid,$user;
push @data,int($Count/(1024*1024));
}



#####
##### Here is the data fetch part for Hits Info
#####
my $sth = $dbh->prepare("SELECT clientusername,count(*) as val FROM WebProxyLog where clientusername not like '%anonymous%' and  logdate = '$report_date' group by clientusername order by val desc limit 10");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) { die "Error:" . $sth->errstr . "\n"; }

while (my ($empid,$Count) = $sth->fetchrow_array)
{
($domain,$user)=split(/\\/,$empid);
$user =~ tr/A-Z/a-z/;
push @eid_hits,$user;
push @data_hits,$Count;
}

#####
##### Here is the data fetch part for Maximum Hit Site
#####
my $sth = $dbh->prepare("SELECT DestHost,count(*) as val FROM WebProxyLog where clientusername not like '%anonymous%' and  logdate = '$report_date' group by DestHost order by val desc limit 10");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}

while (my ($site,$Count) = $sth->fetchrow_array)
{
push @labels_site_hits,$site;
push @data_site_hits,$Count;
}

#####
##### Here is the data fetch part for Maximum Size Transfer Site
#####
my $sth = $dbh->prepare("SELECT DestHost,sum(bytesrecvd+bytessent) as val FROM WebProxyLog where clientusername not like '%anonymous%' and  logdate = '$report_date' group by DestHost order by val desc limit 10");

if (!$sth) {
      die "Error:" . $dbh->errstr . "\n";
  }
if (!$sth->execute) {
      die "Error:" . $sth->errstr . "\n";
  }
while (my ($site,$Count) = $sth->fetchrow_array)
{
push @labels_site_size,$site;
push @data_site_size,int($Count/(1024*1024));
}

#####
##### This part is for the Employee ID Name mapping
#####
my $sth = $dbh->prepare("SELECT * from employees");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
while (my ($id,$name) = $sth->fetchrow_array)
{
$id =~ tr/A-Z/a-z/;
$Name{$id}=$name;
}

foreach $id (@eid)
{
if (!defined($Name{$id})) { push @labels,$id; }
else { push @labels,$Name{$id}; }
}
foreach $id (@eid_hits)
{
if (!defined($Name{$id})) { push @labels_hits,$id; }
else { push @labels_hits,$Name{$id}; }
}



#####
##### Graphing Part here
#####
 
my $c = new XYChart(600, 250);
$c->addTitle("Top 10 Internet Users by Bytes Transferred on $report_date", "arialbi.ttf");
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
$c->makeChart("/venket/isa/size.png");


my $d = new XYChart(600, 250);
$d->addTitle("Top 10 Internet Users by Number of Hits on $report_date", "arialbi.ttf");
$d->setPlotArea(100, 30, 400, 200, $perlchartdir::Transparent,
    $perlchartdir::Transparent, $perlchartdir::Transparent,
    $perlchartdir::Transparent, $perlchartdir::Transparent);
my $layer = $d->addBarLayer(\@data_hits, $d->gradientColor(100, 0, 500, 0, 0x8000,0xffffff));
$d->swapXY(1);
$layer->setBarGap(0.1);
$layer->setAggregateLabelFormat("{value} Hits");
$layer->setAggregateLabelStyle("timesbi.ttf", 10, 0x663300);
my $textbox = $d->xAxis()->setLabels(\@labels_hits);
$textbox->setFontStyle("arial.ttf");
$textbox->setFontSize(6);
$d->xAxis()->setColors($perlchartdir::Transparent, 0x663300);
$d->yAxis()->setColors($perlchartdir::Transparent, $perlchartdir::Transparent);
$d->makeChart("/venket/isa/hits.png");

my $e = new XYChart(600, 250);
$e->addTitle("Top 10 Internet Sites by Number of Hits on $report_date", "arialbi.ttf");
$e->setPlotArea(100, 30, 400, 200, $perlchartdir::Transparent,
    $perlchartdir::Transparent, $perlchartdir::Transparent,
    $perlchartdir::Transparent, $perlchartdir::Transparent);
my $layer = $e->addBarLayer(\@data_site_hits, $e->gradientColor(100, 0, 500, 0, 0x8000,
    0xffffff));
$e->swapXY(1);
$layer->setBarGap(0.1);
$layer->setAggregateLabelFormat("{value} Hits");
$layer->setAggregateLabelStyle("timesbi.ttf", 10, 0x663300);
my $textbox = $e->xAxis()->setLabels(\@labels_site_hits);
$textbox->setFontStyle("arial.ttf");
$textbox->setFontSize(6);
$e->xAxis()->setColors($perlchartdir::Transparent, 0x663300);
$e->yAxis()->setColors($perlchartdir::Transparent, $perlchartdir::Transparent);
$e->makeChart("/venket/isa/site_hits.png");

my $f = new XYChart(600, 250);
$f->addTitle("Top 10 Internet Sites by Bytes Transferred on $report_date", "arialbi.ttf");
$f->setPlotArea(100, 30, 400, 200, $perlchartdir::Transparent,
    $perlchartdir::Transparent, $perlchartdir::Transparent,
    $perlchartdir::Transparent, $perlchartdir::Transparent);
my $layer = $f->addBarLayer(\@data_site_size, $f->gradientColor(100, 0, 500, 0, 0x8000,
    0xffffff));
$f->swapXY(1);
$layer->setBarGap(0.1);
$layer->setAggregateLabelFormat("{value} MB");
$layer->setAggregateLabelStyle("timesbi.ttf", 10, 0x663300);
my $textbox = $f->xAxis()->setLabels(\@labels_site_hits);
$textbox->setFontStyle("arial.ttf");
$textbox->setFontSize(6);
$f->xAxis()->setColors($perlchartdir::Transparent, 0x663300);
$f->yAxis()->setColors($perlchartdir::Transparent, $perlchartdir::Transparent);
$f->makeChart("/venket/isa/site_size.png");




printf <<"EOF";
<html><head><title>Internet Usage Report</title>

<body><table border="0" width="99%" cellpadding="2" cellspacing="0">
  <tr><td width="100%" colspan="2" bgcolor="#003399"><p align="center">

<b><font color="#FFFFFF">Internet Usage Report</font></b></p>
    </td></tr>

<tr><td width="100%" colspan="2" bgcolor="#F6F6F6"><p><b>Top Users by Bytes Transferred </b></td></tr>
<tr><td width="100%" colspan="2" bgcolor="#F6F6F6"><img border="0" src="/isa/size.png" width="600" height="250"></td></tr>

<tr><td width="100%" colspan="2" bgcolor="#F6F6F6" colspan="2"><p><b>Top Users by Number of Hits</b></td></tr>
<tr><td width="100%" colspan="2" bgcolor="#F6F6F6"><img border="0" src="/isa/hits.png" width="600" height="250"></td></tr>

<tr><td width="100%" colspan="2" bgcolor="#F6F6F6" colspan="2"><p><b>Top Sites by Number of Hits</b></td></tr>
<tr><td width="100%" colspan="2" bgcolor="#F6F6F6"><img border="0" src="/isa/site_hits.png" width="600" height="250"></td></tr>

<tr><td width="100%" colspan="2" bgcolor="#F6F6F6" colspan="2"><p><b>Top Sites by Bytes Transferred</b></td></tr>
<tr><td width="100%" colspan="2" bgcolor="#F6F6F6"><img border="0" src="/isa/site_size.png" width="600" height="250"></td></tr>

</table>
</form></body>
</html>
EOF

