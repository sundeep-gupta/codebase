#!/usr/bin/perl
use DBD::mysql;
use perlchartdir;
use Date::Manip;
use CGI;
$q = new CGI;

@agent_name = ( "Bharathi","Rajkumar","Toms","Vanitha","Vasantha","Manikanden" );
@wrapup_data = ( "Desktop","Imaging","Mainframe Printer","Non-Productive","Password Reset","Test","Training/Mock","Unix" );
@Week = ( "Mon","Tue","Wed","Thu","Fri" );
@Hours = ( "05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20" );
@asa_1 = ( "2.00","2.25","2.50","2.75","3.00" );

print "Content-type:text/html\n\n";

$start_date = $q->param('idate');
$end_date = $q->param('rdate');

$dsn = "DBI:mysql:database=Help_desk;host=localhost";
$dbh = DBI->connect($dsn,"root",tst123 );


if ($start_date eq "" and $end_date eq "") 
{

my $sth = $dbh->prepare("SELECT CURDATE()");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
while ( $date = $sth->fetchrow_array)
{
	$curr_date = $date;
	chomp($curr_date);
	# print "Curr_date : $curr_date<br>";
}

@curr = split(/-/,$curr_date);
$start_dte = ParseDate(\@curr);
$start_day = UnixDate($start_dte,"%a");
chomp($start_day);  # print "$start_day \n";

if ( $start_day eq "Mon" )
{

my $sth = $dbh->prepare("SELECT DATE_SUB('$curr_date',INTERVAL 1 DAY)");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
while ( $date = $sth->fetchrow_array)
{
	$end_date = $date;
	chomp($end_date);
	# print "End_date : $end_date<br>";
}
my $sth = $dbh->prepare("SELECT DATE_SUB('$curr_date',INTERVAL 7 DAY)");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
while ( $date = $sth->fetchrow_array)
{
	$start_date = $date;
	chomp($start_date);
	# print "Star_date : $start_date<br>";
}
my $sth = $dbh->prepare("UPDATE Date SET Start_Date='$start_date' , End_Date='$end_date'");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}

}
else
{

my $sth = $dbh->prepare("SELECT * FROM Date");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
while ( ($start,$end) = $sth->fetchrow_array)
{
        $start_date = $start;
        $end_date = $end;
        chomp($start_date); chomp($end_date);
#         print "Start_date : $start_date \t End_date : $end_date\n";
}

}

}

@start = split(/-/,$start_date);
@end = split(/-/,$end_date);
$start_dt = ParseDate(\@start);
$end_dt = ParseDate(\@end);
$start_month = UnixDate($start_dt,"%b %d");
$end_month = UnixDate($end_dt,"%b %d");
 # print "$start_month \t $end_month\n";


%total_days = ();
my $sth = $dbh->prepare("SELECT Agent_Name,count(Agent_Name) from Calls_Report_Table where Calldate >= '$start_date 00:00:00' and Calldate <= '$end_date 23:59:59' group by Agent_Name");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
while (my ($name,$count) = $sth->fetchrow_array)
{
	$total_days{$name} = $count;
}
foreach $key (@agent_name) {
	push @total_call,$total_days{$key};
}

%total_days = ();
my $sth = $dbh->prepare("SELECT Agent_Name,round(avg(DelayTime),2) from Calls_Report_Table where Calldate >= '$start_date 00:00:00' and Calldate <= '$end_date 23:59:59' group by Agent_Name");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
while (my ($asaname,$asacount) = $sth->fetchrow_array)
{
$total_days{$asaname} = $asacount;
}
foreach $key (@agent_name) {
	push @asaavg,$total_days{$key};
}
my $sth = $dbh->prepare("SELECT round(avg(DelayTime),2) from Calls_Report_Table where Calldate >= '$start_date 00:00:00' and Calldate <= '$end_date 23:59:59' ");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
$asa = $sth->fetchrow_array;

%total_days = ();
my $sth = $dbh->prepare("select agent_name , round((sum(HoldTime+TalkTime+WorkTime)/3600),2) as dt from Calls_Report_Table where Calldate >= '$start_date 00:00:00' and Calldate <= '$end_date 23:59:59' group by Agent_Name");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
while (my ($asaname,$asacount) = $sth->fetchrow_array)
{
$total_days{$asaname} = $asacount;
}
foreach $key (@agent_name) {
	push @total_hrs,$total_days{$key};
}

%total_days = ();
my $sth = $dbh->prepare("SELECT Day,count(Day) from Calls_Report_Table where Calldate >= '$start_date 00:00:00' and Calldate <= '$end_date 23:59:59' group by Day");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
while (my ($day,$total_day) = $sth->fetchrow_array)
{
$total_days{$day} = $total_day;
}
foreach $key (@Week) {
	push @day_total,$total_days{$key};
}

%total_days = ();
my $sth = $dbh->prepare("SELECT WrapupData,count(WrapupData) from Calls_Report_Table where Calldate >= '$start_date 00:00:00' and Calldate <= '$end_date 23:59:59' group by WrapupData");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
while (my ($data,$total) = $sth->fetchrow_array)
{
	if ( ($data =~ /Issues/) or ($data =~ /Calls/)) 
	{
		$data =~ s/Issues//g;
		$data =~ s/Calls//g;
		chop($data);
		$total_days{$data} = $total;
	}
	else
	{
		$total_days{$data} = $total;
	}	
}
foreach $key (@wrapup_data) {
	push @total_data,$total_days{$key};
}

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
@one = ();
@thr = ();

my $sth = $dbh->prepare("select count(wrapupdata) from Calls_Report_Table where Calldate >= '$start_date 00:00:00' and Calldate <= '$end_date 23:59:59' and delaytime > 20 ");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
$total = $sth->fetchrow_array;
my $sth = $dbh->prepare("select count(wrapupdata) from Calls_Report_Table where Calldate >= '$start_date 00:00:00' and Calldate <= '$end_date 23:59:59' ");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
$calls = $sth->fetchrow_array;
if ( $calls ne 0 )
{ $sla = 1 - ( $total / $calls ); }
# $sla = 1 - ( $total / $calls );
if ($sla >= 0.8) { $sla_per = $sla*100 ; }
if ($sla < 0.8) { $sla_per = (($sla/0.8)*100); }

my $sth = $dbh->prepare("select count(wrapupdata) from Calls_Report_Table where Calldate >= '$start_date 00:00:00' and Calldate <= '$end_date 23:59:59' and TimeToAband > 0 ");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
$total_time = $sth->fetchrow_array;
my $sth = $dbh->prepare("select count(wrapupdata) from Calls_Report_Table where Calldate >= '$start_date 00:00:00' and Calldate <= '$end_date 23:59:59' ");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
$calls = $sth->fetchrow_array;
if ( $calls ne 0 )
{ $t2a = $total_time/$calls; }
else { $t2a = 0; }
# $t2a = $total_time/$calls;

my $f = new XYChart(500, 250);
$f->addTitle("Work Load by Agent - $start_month to $end_month");
$f->yAxis()->setTitle("Total No of Calls");
$f->xAxis()->setTitle("Agent Name");
$f->setPlotArea(50, 30, 400, 150);
my $layer = $f->addBarLayer2($perlchartdir::Side, 1);
$layer->addDataSet(\@total_call, $f->gradientColor(0, 500, 80, 0, 0x8000, 0xffffff), "");
$layer->setAggregateLabelStyle();
$layer->setBarGap(0.6);
$f->xAxis()->setLabels(\@agent_name)->setFontStyle("arialbd.ttf");
$f->yAxis()->setLabelStyle("arialbd.ttf");
my $chart1URL = $f->makeTmpFile("/tmp/1/");
my $imageMap1 = $f->getHTMLImageMap("phd_current_per_report.pl","type=user&user={xLabel}&idate=$start_date&rdate=$end_date" ,"title='{xLabel}:{value|0}'");

my $d = new XYChart(500, 250);
$d->addTitle("Average Speed of Answer by Agent - $start_month to $end_month");
$d->yAxis()->setTitle("Average Speed in secs");
$d->xAxis()->setTitle("Agent Name");
$d->setPlotArea(80, 30, 400, 150);
$d->yAxis()->setLabels(\@asa_1)->setFontStyle("arialbd.ttf");
$d->yAxis()->addMark($asa, 0x8000, "Average = $asa")->setLineWidth(2);
my $layer = $d->addBarLayer2($perlchartdir::Side, 1);
$layer->addDataSet(\@asaavg, $d->gradientColor(0, 500, 80, 0, 0x8000, 0xffffff), "");
$layer->setAggregateLabelStyle();
$layer->setBarGap(0.6);
$d->xAxis()->setLabels(\@agent_name)->setFontStyle("arialbd.ttf");
# $d->yAxis()->setLabelStyle("arialbd.ttf");
my $chart2URL = $d->makeTmpFile("/tmp/2/");
my $imageMap2 = $d->getHTMLImageMap("phd_current_per_report.pl","type=avg&avguser={xLabel}&idate=$start_date&rdate=$end_date" ,"title='{xLabel}:{value|0}'");

my $h = new XYChart(500, 250);
$h->addTitle("Total no of Hours Worked by Agent - $start_month to $end_month");
$h->yAxis()->setTitle("Hours");
$h->xAxis()->setTitle("Agent Name");
$h->setPlotArea(50, 30, 400, 150);
my $layer = $h->addBarLayer2($perlchartdir::Side, 1);
$layer->addDataSet(\@total_hrs, $h->gradientColor(0, 500, 80, 0, 0x8000, 0xffffff), "");
$layer->setAggregateLabelStyle();
$layer->setBarGap(0.6);
$h->xAxis()->setLabels(\@agent_name)->setFontStyle("arialbd.ttf");
$h->yAxis()->setLabelStyle("arialbd.ttf");
my $chart6URL = $h->makeTmpFile("/tmp/6/");
# my $imageMap6 = $h->getHTMLImageMap("phd_current_per_report.pl","type=avg&avguser={xLabel}&idate=$start_date&rdate=$end_date" ,"title='{xLabel}:{value|0}'");

my $e = new XYChart(500, 250);
$e->addTitle("Call Distribution - $start_month to $end_month");
$e->yAxis()->setTitle("Total No of Calls");
$e->xAxis()->setTitle("Days");
$e->setPlotArea(50, 30, 400, 150);
my $layer = $e->addBarLayer2($perlchartdir::Side, 1);
$layer->addDataSet(\@day_total, $e->gradientColor(0, 500, 80, 0, 0x8000, 0xffffff), "");
$layer->setAggregateLabelStyle();
$layer->setBarGap(0.6);
$e->xAxis()->setLabels(\@Week)->setFontStyle("arialbd.ttf");
$e->yAxis()->setLabelStyle("arialbd.ttf");
my $chart3URL = $e->makeTmpFile("/tmp/3/");
my $imageMap3 = $e->getHTMLImageMap("phd_current_per_report.pl","type=day&day={xLabel}&idate=$start_date&rdate=$end_date" ,"title='{xLabel}:{value|0}'");

my $g = new XYChart(500, 250);
$g->addTitle("Call Categories - $start_month to $end_month");
$g->yAxis()->setTitle("Total No of Calls");
$g->xAxis()->setTitle("Wrapupdata");
$g->setPlotArea(50, 30, 400, 150);
my $layer = $g->addBarLayer2($perlchartdir::Side, 1);
$layer->addDataSet(\@total_data, $g->gradientColor(0, 500, 80, 0, 0x8000, 0xffffff), "");
$layer->setAggregateLabelStyle();
$layer->setBarGap(0.6);
$g->xAxis()->setLabelStyle("arialbd.ttf",9)->setFontAngle(25);
$g->xAxis()->setLabels(\@wrapup_data);
$g->yAxis()->setLabelStyle("arialbd.ttf");
my $chart4URL = $g->makeTmpFile("/tmp/4/");
my $imageMap4 = $g->getHTMLImageMap("phd_current_per_report.pl","type=wrapup&wrapup={xLabel}&idate=$start_date&rdate=$end_date" ,"title='{xLabel}:{value|0}'");

my $c = new XYChart(500, 275);
$c->setPlotArea(50, 30, 425, 190)->setGridColor(0xc0c0c0, 0xc0c0c0);
$c->addTitle("Score Card of Each Calls per Hour - $start_month to $end_month");
$c->xAxis()->setTitle("Hours in EST");
$c->yAxis()->setTitle("Total No of Calls");
$c->xAxis()->setLabels(\@Hours)->setFontStyle("arialbd.ttf");
$c->yAxis()->setLabelStyle("arialbd.ttf");
my $layer = $c->addBoxWhiskerLayer(\@one, \@thr, \@max, \@min, \@avg, 0x9999ff, 0xcc)->setLineWidth(2);
my $chart5URL = $c->makeTmpFile("/tmp/5/");

printf <<"EOF";
<html><head><title>Pershing Helpdesk Report</title>
<form name="sampleform" method="POST" action="/cgi-bin/hlpdsk/phd_current_report.pl">
<SCRIPT language=javascript 
src="/javascript/cal2.js"></SCRIPT>
<SCRIPT language=javascript 
src="/javascript/cal_conf2.js"></SCRIPT>
</head>
<body><table border="0" width="99%" cellpadding="2" cellspacing="0">
  <tr><td width="100%" colspan="2" bgcolor="#F6F6F6"><p><b>Select Date for Report</b></td></tr>
<tr><td width="50%" bgcolor="#F6F6F6">
<p align="center"><b>From&nbsp;</b>&nbsp;&nbsp;&nbsp; <INPUT name=idate size="20"><SMALL><A
      href="javascript:showCal('Calendar1')">  Date</A></small></p>
<td width="50%" bgcolor="#F6F6F6">
<p align="center"><b>To</b>&nbsp;&nbsp;&nbsp; <INPUT name=rdate size="20"><SMALL><A
      href="javascript:showCal('Calendar2')">  Date</A></small></p>
<tr><td width="100%" colspan="2" bgcolor="#F6F6F6">
<p align="center"><input type="submit" value="Submit" name="B1">
</td></tr>
<tr><td width="100%" colspan="2" bgcolor="#F6F6F6"></td></tr>
<tr><td width="100%" colspan="2" bgcolor="#FFFFFF" height="3"></td></tr>
</p>
<tr><td width="50%" colspan="1" bgcolor="#FFFFFF">
<p align="center"><B> Metrics<B>
<table border="1" width="100%">
  <tr>
    <td width="50%">Average Speed of Answer</td>
    <td width="50%" align = "center">$asa secs</td>
  </tr>
  <tr>
    <td width="50%">SLA (80%% in 20 secs)</td>
    <td width="50%" align = "center">$sla_per%</td>
  </tr>
  <tr>
    <td width="50%">Abandon Rate</td>
    <td width="50%" align = "center">$t2a%</td>
  </tr>
</table>
<br><p align="left">Call Categories&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://172.25.10.121/cgi-bin/help_desk/phd_current_database_report.pl?type=category&idate=$start_date&rdate=$end_date"><img src="http://172.25.10.121/excel.gif" border="0" width="16" height="13" align="center" ></a>
<br>Work Load by Agent&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://172.25.10.121/cgi-bin/help_desk/phd_current_database_report.pl?type=load&idate=$start_date&rdate=$end_date"><img src="http://172.25.10.121/excel.gif" border="0" width="16" height="13" ></a>
<br>ASA by Agent&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://172.25.10.121/cgi-bin/help_desk/phd_current_database_report.pl?type=asa&idate=$start_date&rdate=$end_date"><img src="http://172.25.10.121/excel.gif" border="0" width="16" height="13" ></a>
<br>Call Distribution&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://172.25.10.121/cgi-bin/help_desk/phd_current_database_report.pl?type=dist&idate=$start_date&rdate=$end_date"><img src="http://172.25.10.121/excel.gif" border="0" width="16" height="13" ></a>
<br>Calls Per Hour&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://172.25.10.121/cgi-bin/help_desk/phd_current_database_report.pl?type=hour&idate=$start_date&rdate=$end_date"><img src="http://172.25.10.121/excel.gif" border="0" width="16" height="13" ></a>
<br>Entire Report&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://172.25.10.121/cgi-bin/help_desk/phd_current_database_report.pl?type=all&idate=$start_date&rdate=$end_date"><img src="http://172.25.10.121/excel.gif" border="0" width="16" height="13" ></a>
<BR>
<BR>
<BR>
</td>

<td width="50%" colspan="1" bgcolor="#F6F6F6">
<img src="myimage.pl?img=/tmp/4/$chart4URL" border="0" usemap="#map4">
<map name="map4">
$imageMap4
</map>
</td></tr>

<tr><td width="50%" colspan="1" bgcolor="#F6F6F6">
<img src="myimage.pl?img=/tmp/1/$chart1URL" border="0" usemap="#map1">
<map name="map1">
$imageMap1
</map>
</td>

<td width="50%" colspan="1" bgcolor="#F6F6F6">
<img src="myimage.pl?img=/tmp/2/$chart2URL" border="0" usemap="#map2">
<map name="map2">
$imageMap2
</map>
</td></tr>

<tr><td width="50%" colspan="1" bgcolor="#F6F6F6">
<img src="myimage.pl?img=/tmp/6/$chart6URL" border="0" usemap="#map6">
<map name="map6">
$imageMap6
</map>
</td>

<td width="50%" colspan="1" bgcolor="#F6F6F6">
<img src="myimage.pl?img=/tmp/3/$chart3URL" border="0" usemap="#map3">
<map name="map3">
$imageMap3
</map>
</td></tr>

<tr><td width="50%" colspan="1" bgcolor="#F6F6F6">
<img src="myimage.pl?img=/tmp/5/$chart5URL" border="0">
</td></tr>

</table>
</form></body>
</html>
EOF

# 