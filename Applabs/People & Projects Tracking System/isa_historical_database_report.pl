#!/usr/bin/perl
use DBD::mysql;
use perlchartdir;
use Date::Calc qw(Delta_Days);
use CGI;
$q = new CGI;

print "Content-type:text/html\n\n";
$start_date = $q->param('idate');
$end_date = $q->param('rdate');
$data = $q->param('data');
$deptid = $q->param('deptid');
$empid = $q->param('empid');
$time = $q->param('time');
$site = $q->param('site');

if ($time < 10) {
$last_time = "0"."$time";
}else
{$last_time = $time;
}

@start = split(/-/,$start_date);
@end = split(/-/,$end_date);
$diff = Delta_Days(@start, @end) + 1;


$dsn = "DBI:mysql:database=isa_mysql;host=localhost";
$dbh = DBI->connect($dsn,"root",tst123);


#####
##### This part is for the Employee ID Name mapping
#####
my $sth = $dbh->prepare("SELECT empid,firstname,secondname from employees");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
while (my ($id,$firstname,$secondname) = $sth->fetchrow_array)
{
$id =~ tr/A-Z/a-z/;
$Name{$id}=$firstname." ".$secondname;
}

#####
##### This part is for the Departmant ID Dept Name mapping
#####
my $sth = $dbh->prepare("SELECT dept_id,dept_name from department");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}
while (my ($dept_id,$dept_name) = $sth->fetchrow_array)
{
$DeptName{$dept_id}=$dept_name;
}


printf << "EOF";
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>New Page 1</title>
</head>

<body>
EOF


#####
##### Here is the data fetch part for Size Info
#####
if ( ($data eq "user") && ($empid eq '') )
{
my $sth = $dbh->prepare("SELECT clientusername,sum(bytesrecvd+bytessent) as val,logDate FROM ConsolidatedUserWebProxyLog where logdate <= '$end_date 23:59:59' and logdate >= '$start_date 00:00:00' group by clientusername order by val desc limit 10");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}

while (my ($username,$Count,$dt) = $sth->fetchrow_array)
{
($domain,$user)=split(/\\/,$username);
($df,$time)=split(/ /,$dt);
@date = $df;
$user =~ tr/A-Z/a-z/;
push @eid,$user;
push @data,int($Count/(1024*1024));
}

foreach $id (@eid)
{
if (!defined($Name{$id})) { push @labels,$id; }
else { push @labels,$Name{$id}; }
}

printf << "EOF";

<table border=0>
  <tr>
	<th bgcolor=gray><font color=white>ClientUserName</font></th>
	<th bgcolor=gray><font color=white>Size in MB</font></th>
  </tr>

EOF
$i=0;
foreach(@labels) {
	printf "\n<tr bgcolor=\#efefef><td width=\"10\%\">$labels[$i]</td><td width=\"10\%\"><p align=\"center\">$data[$i]</p></td>";
$i++;
}

}

if ( $data eq "site" && $site eq '' )
{
my $sth = $dbh->prepare("SELECT DestHost,sum(bytesrecvd+bytessent) as val,logDate FROM ConsolidatedUserWebProxyLog where logdate <= '$end_date 23:59:59' and logdate >= '$start_date 00:00:00' group by DestHost order by val desc limit 10");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}

while (my ($Site,$Count,$dt) = $sth->fetchrow_array)
{
push @labels_site,$Site;
($df,$time)=split(/ /,$dt);
@date = $df;
push @data_site,int($Count/(1024*1024));
}

printf << "EOF";

<table border=0>
  <tr>
        <th bgcolor=gray><font color=white>Internet Site</font></th>
        <th bgcolor=gray><font color=white>Size in MB</font></th>
  </tr>

EOF
$i=0;
foreach(@labels_site) {
        printf "\n<tr bgcolor=\#efefef><td width=\"10\%\">$labels_site[$i]</td><td width=\"10\%\"><p align=\"center\">$data_site[$i]</p></td>";
$i++;
}

}

if ( $data eq "dept" && $deptid eq '' )
{
my $sth = $dbh->prepare("SELECT deptid, sum(bytesrecvd+bytessent) as val,logDate FROM ConsolidatedUserWebProxyLog where deptid <> 'NULL' and logdate <= '$end_date 23:59:59' and logdate >= '$start_date 00:00:00' group by deptid order by val desc");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}

while (my ($Dept_Id,$Count,$dt) = $sth->fetchrow_array)
{
push @dept_id,$Dept_Id;
($df,$time)=split(/ /,$dt);
@date = $df;
push @data_dept,int($Count/(1024*1024));
}

foreach $deptid (@dept_id)
{push @labels_dept,$DeptName{$deptid};}

printf << "EOF";

<table border=0>
  <tr>
        <th bgcolor=gray><font color=white>Department Name</font></th>
        <th bgcolor=gray><font color=white>Size in MB</font></th>
  </tr>

EOF
$i=0;
foreach(@labels_dept) {
        printf "\n<tr bgcolor=\#efefef><td width=\"10\%\">$labels_dept[$i]</td><td width=\"10\%\"><p align=\"center\">$data_dept[$i]</p></td>";
$i++;
}

}

if ( $data eq "time" && $time eq '' )
{
my $sth = $dbh->prepare("SELECT DATE_FORMAT(logDate,'%H') as dt, round(sum(bytesrecvd+bytessent)/1024/1024/$diff,0) as MB_Transferred,logdate FROM ConsolidatedUserWebProxyLog where logdate <= '$end_date 23:59:59' and logdate >= '$start_date 00:00:00' GROUP BY dt order by dt");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}

while (my ($hours,$size,$dt) = $sth->fetchrow_array)
{
push @Time,$hours;
($df,$time)=split(/ /,$dt);
@date = $df;
push @Size_MB,int($size);
}


printf << "EOF";

<table border=0>
  <tr>
        <th bgcolor=gray><font color=white>Hours</font></th>
        <th bgcolor=gray><font color=white>Size in MB</font></th>
  </tr>

EOF
$i=0;
foreach(@Time) {
        printf "\n<tr bgcolor=\#efefef><td width=\"10\%\"><p align=\"center\">$Time[$i]</p></td><td width=\"10\%\"><p align=\"center\">$Size_MB[$i]</p></td>";
$i++;
}

}

if ( ($data eq "dept") && ($deptid ne '') )
{
my $sth = $dbh->prepare("SELECT clientusername, sum(bytesrecvd+bytessent) as val,logdate FROM ConsolidatedUserWebProxyLog where deptid = $deptid and logdate <= '$end_date 23:59:59' and logdate >= '$start_date 00:00:00' group by clientusername order by val desc limit 30");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}

while (my ($username,$Count,$dt) = $sth->fetchrow_array)
{
($domain,$user)=split(/\\/,$username);
$user =~ tr/A-Z/a-z/;
push @eid,$user;
($df,$time)=split(/ /,$dt);
@date = $df;
push @data,int($Count/1024);
}

foreach $id (@eid)
{
if (!defined($Name{$id})) { push @labels,$id; }
else { push @labels,$Name{$id}; }
}


printf << "EOF";

<table border=0>
  <tr>
        <th bgcolor=gray><font color=white>Clientusername</font></th>
        <th bgcolor=gray><font color=white>Size in MB</font></th>
  </tr>

EOF
$i=0;
foreach(@labels) {
        printf "\n<tr bgcolor=\#efefef><td width=\"10\%\"><p align=\"center\">$labels[$i]</p></td><td width=\"10\%\"><p align=\"center\">$data[$i]</p></td><td width=\"25\%\">";
$i++;
}

}

if ( ($data eq "user") && ($empid ne '') )
{
my $sth = $dbh->prepare("SELECT DestHost,sum(bytesrecvd+bytessent) as val,logdate FROM ConsolidatedUserWebProxyLog where clientusername like '%$empid%' and logdate <= '$end_date 23:59:59' and logdate >= '$start_date 00:00:00' group by DestHost order by val desc limit 20");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}

while (my ($site,$Count,$dt) = $sth->fetchrow_array)
{
push @labels,$site;
($df,$time)=split(/ /,$dt);
@date = $df;
push @data,int($Count/1024);
}


printf << "EOF";

<table border=0>
  <tr>
        <th bgcolor=gray><font color=white>Internet Site</font></th>
        <th bgcolor=gray><font color=white>Size in MB</font></th>
  </tr>

EOF
$i=0;
foreach(@labels) {
        printf "\n<tr bgcolor=\#efefef><td width=\"10\%\"><p align=\"center\">$labels[$i]</p></td><td width=\"10\%\"><p align=\"center\">$data[$i]</p></td>";
$i++;
}

}

if ( ($data eq "site") && ($site ne '') )
{
my $sth = $dbh->prepare("SELECT clientusername,sum(bytesrecvd+bytessent) as val,logdate FROM ConsolidatedUserWebProxyLog where DestHost = '$site' and logdate <= '$end_date 23:59:59' and logdate >= '$start_date 00:00:00' group by ClientUserName order by val desc limit 20");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}

while (my ($username,$Count,$dt) = $sth->fetchrow_array)
{
($domain,$user)=split(/\\/,$username);
$user =~ tr/A-Z/a-z/;
push @eid,$user;
($df,$time)=split(/ /,$dt);
@date = $df;
push @data,int($Count/1024);
}

foreach $id (@eid)
{
if (!defined($Name{$id})) { push @labels,$id; }
else { push @labels,$Name{$id}; }
}


printf << "EOF";

<table border=0>
  <tr>
        <th bgcolor=gray><font color=white>Clientusername</font></th>
        <th bgcolor=gray><font color=white>Size in MB</font></th>
  </tr>

EOF
$i=0;
foreach(@labels) {
        printf "\n<tr bgcolor=\#efefef><td width=\"10\%\"><p align=\"center\">$labels[$i]</p></td><td width=\"10\%\"><p align=\"center\">$data[$i]</p></td>";
$i++;
}

}

if ( ($data eq "usersperhour") && ($time ne '') )
{
my $sth = $dbh->prepare("SELECT clientusername,sum(bytesrecvd+bytessent) as val,logdate FROM ConsolidatedUserWebProxyLog where logdate <= '$end_date 23:59:59' and logdate >= '$start_date 00:00:00' and DATE_FORMAT(logDate, '%H:%i') like '$last_time:%' group by ClientUserName order by val desc limit 10");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}

while (my ($username,$Count,$dt) = $sth->fetchrow_array)
{
($domain,$user)=split(/\\/,$username);
$user =~ tr/A-Z/a-z/;
push @eid,$user;
($df,$time)=split(/ /,$dt);
@date = $df;
push @data,int($Count/(1024));
}

foreach $id (@eid)
{
if (!defined($Name{$id})) { push @labels,$id; }
else { push @labels,$Name{$id}; }
}


printf << "EOF";

<table border=0>
  <tr>
        <th bgcolor=gray><font color=white>Clientusername</font></th>
        <th bgcolor=gray><font color=white>Size in MB</font></th>
  </tr>

EOF
$i=0;
foreach(@labels) {
                         printf "\n<tr bgcolor=\#efefef><td width=\"10\%\"><p align=\"center\">$labels[$i]</p></td><td width=\"10\%\"><p align=\"center\">$data[$i]</p></td>";
$i++;
}

}

if ( ($data eq "sitesperhour") && ($time ne '') )
{
my $sth = $dbh->prepare("SELECT DestHost,sum(bytesrecvd+bytessent) as val,logdate FROM ConsolidatedUserWebProxyLog where logdate <= '$end_date 23:59:59' and logdate >= '$start_date 00:00:00' and DATE_FORMAT(logDate, '%H:%i') like '$last_time:%' group by DestHost order by val desc limit 10");
if (!$sth) {die "Error:" . $dbh->errstr . "\n";}
if (!$sth->execute) {die "Error:" . $sth->errstr . "\n";}

while (my ($Site,$Count,$dt) = $sth->fetchrow_array)
{
push @labels_site,$Site;
($df,$time)=split(/ /,$dt);
@date = $df;
push @data_site,int($Count/(1024));
}


printf << "EOF";

<table border=0>
  <tr>
        <th bgcolor=gray><font color=white>Internet Site</font></th>
        <th bgcolor=gray><font color=white>Size in MB</font></th>
  </tr>

EOF
$i=0;
foreach(@labels_site) {
                         printf "\n<tr bgcolor=\#efefef><td width=\"10\%\"><p align=\"center\">$labels_site[$i]</p></td><td width=\"10\%\"><p align=\"center\">$data_site[$i]</p></td>";
$i++;
}

}



printf << "END";
</table>
</body>
</html>
END
