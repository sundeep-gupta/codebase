#!/usr/bin/perl
use DBD::mysql;
use perlchartdir;
use CGI;
$q = new CGI;

print "Content-type:text/html\n\n";
$start_date = $q->param('idate');
$end_date = $q->param('rdate');
$uname = $q->param('user');
$isite = $q->param('site');

$dsn = "DBI:mysql:database=isa_mysql;host=localhost";
$dbh = DBI->connect($dsn,"root",tst123);

@labels_site = ();
@data_site = ();


#####
##### This part is for the Employee ID Name mapping
#####
my $sth = $dbh->prepare("SELECT empid,firstname,secondname from employees ");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
while (my ($id,$firstname,$secondname) = $sth->fetchrow_array)
{
$id =~ tr/A-Z/a-z/;
$Name{$id}=$firstname." ".$secondname;
}


#####
##### Here is the data fetch part for Size Info
##### 

if ( ($uname ne '') && ($isite eq '') )
{
my $sth = $dbh->prepare("SELECT empid FROM employees where empid like '%$uname%' or firstname like '%$uname%' or secondname like '%$uname%'");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}

while (my ($username) = $sth->fetchrow_array)
{
$username =~ tr/A-Z/a-z/;
push @eid,$username;
}
}


if ( ($uname ne '') && ($isite ne '') )
{
my $sth = $dbh->prepare("SELECT empid FROM employees where empid like '%$uname%' or firstname like '%$uname%' or secondname like '%$uname%'");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}

while (my ($username) = $sth->fetchrow_array)
{
$username =~ tr/A-Z/a-z/;
push @eid,$username;
}
}



#####
##### Here is the data fetch part for Size Info for Sites
#####
if ( ($uname eq '') && ($isite ne '') && ($start_date eq '') && ($end_date eq '') )
{
my $sth = $dbh->prepare("SELECT distinct(DestHost),sum(bytesrecvd+bytessent) as val FROM DailyUserWebProxyLog where DestHost like '%$isite%' group by DestHost order by val desc ");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}

while (my ($Site,$Count) = $sth->fetchrow_array)
{
push @labels_site,$Site;
push @data_site,int($Count/(1024*1024));
}
}

if ( ($uname eq '') && ($isite ne '') && ($start_date ne '') && ($end_date ne '') )
{
my $sth = $dbh->prepare("SELECT distinct(DestHost),sum(bytesrecvd+bytessent) as val FROM ConsolidatedUserWebProxyLog where logdate <= '$end_date 23:59:59' and logdate >= '$start_date 00:00:00' and DestHost like '%$isite%' group by DestHost order by val desc limit 20");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}

while (my ($Site,$Count) = $sth->fetchrow_array)
{
push @labels_site,$Site;
push @data_site,int($Count/(1024*1024));
}
}




foreach $id (@eid)
{
if (!defined($Name{$id})) { push @labels,$id; }
else { push @labels,$Name{$id}; }
}

#####
##### Graphing Part here
#####

$height = (( $#labels_site * 30 ) + 100 );

my $d = new XYChart(800, $height);

if ( ($isite ne '') && ($start_date eq '') && ($end_date eq '') )
{
$d->addTitle("Top Internet Sites by Bytes Transferred - Today", "arialbi.ttf");
}

if ( ($isite ne '') && ($start_date ne '') && ($end_date ne '') )
{
$d->addTitle("Top 20 Internet Sites by Bytes Transferred From $start_date To $end_date ", "arialbi.ttf");
}

$d->setPlotArea(125, 30, 700, ($height-50), $perlchartdir::Transparent,
    $perlchartdir::Transparent, $perlchartdir::Transparent,
    $perlchartdir::Transparent, $perlchartdir::Transparent);
my $layer = $d->addBarLayer(\@data_site, $d->gradientColor(125, 0, 775, 0, 0x8000,
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

if ( ($isite ne '') && ($start_date eq '') && ($end_date eq '') )
{
$imageMap2 = $d->getHTMLImageMap("isa_current_persite_report.pl","site={xLabel}" ,"title='{xLabel}: {value|0}'");
}

if ( ($isite ne '') && ($start_date ne '') && ($end_date ne '') )
{
$imageMap2 = $d->getHTMLImageMap("isa_historical_persite_report.pl","site={xLabel}&idate=$start_date&rdate=$end_date" ,"title='{xLabel}: {value|0}'");
}

if ( ($#labels_site < 0) && ($#labels < 0) )
{
#print "$#labels";
print "\nInvalid Entry ....";
}
else
{ 
if ( ($uname ne '') && ($isite ne '') && ($start_date ne '') && ($end_date ne '') )
{
print "\nSelect any one either the User or the Internet Site to get the report";
}
else
{

if( $isite ne '' )
{
printf <<"EOF";
<html><head><title>Internet Usage Report</title>
</head>
<body><table border="0" width="99%" cellpadding="2" cellspacing="0">
  <tr><td width="100%" colspan="2" bgcolor="#003399"><p align="center">

<b><font color="#FFFFFF">Internet Usage Report</font></b></p>
    </td></tr>


<tr><td width="100%" colspan="2" bgcolor="#F6F6F6"><p><b>Top Sites by Bytes Transferred </b></td></tr>
<tr><td width="100%" colspan="2" bgcolor="#F6F6F6">
<img src="myimage.pl?img=/tmp/tmpcharts/2/$chart2URL" border="0" usemap="#map2">
<map name="map2">
$imageMap2
</map>
<tr><td width="100%" colspan="2" bgcolor="#FFFFFF" height="3"></td></tr>


</table>
</body>
</html>
EOF
}

if ( ($uname ne '') && ($isite eq '') && ($start_date eq '') && ($end_date eq '') )
{
printf <<"EOF";
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>New Page 1</title>
</head>

<body>

<table border=0>
  <tr>
	<th bgcolor=gray><font color=white>S.No</font></th>
	<th bgcolor=gray><font color=white>User Name</font></th>
  </tr>

EOF
$sl_no = 1;
$i = 0;
foreach ( @labels)
{
$user = $labels[$i];
	printf "\n<tr bgcolor=\#efefef><td width=\"5\%\"><p align=\"center\">$sl_no</p></td><td width=\"10\%\"><p align=\"center\"><A href=\"/cgi-bin/isa_current_peruser_report.pl?user=$user\">$user</A></p></td></tr>";
$sl_no++;
$i++;

}

printf <<"EOF";
</table>
</body>
</html>
EOF

}

if ( ($uname ne '') && ($isite eq '') && ($start_date ne '') && ($end_date ne '') )
{
printf <<"EOF";
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>New Page 1</title>
</head>

<body>

<table border=0>
  <tr>
        <th bgcolor=gray><font color=white>S.No</font></th>
        <th bgcolor=gray><font color=white>User Name</font></th>
  </tr>

EOF
$sl_no = 1;
$i = 0;
foreach ( @labels)
{
$user = $labels[$i];
        printf "\n<tr bgcolor=\#efefef><td width=\"5\%\"><p align=\"center\">$sl_no</p></td><td width=\"10\%\"><p align=\"center\"><A href=\"/cgi-bin/isa_historical_peruser_report.pl?user=$user&idate=$start_date&rdate=$end_date\">$user</A></p></td></tr>";
$sl_no++;
$i++;

}

printf <<"EOF";
</table>
</body>
</html>
EOF

}
}
}
