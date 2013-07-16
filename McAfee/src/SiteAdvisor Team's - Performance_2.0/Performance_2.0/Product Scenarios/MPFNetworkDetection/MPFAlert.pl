use strict;
use warnings;
use Carp qw(confess);
use Carp::Assert;
use lib "../../Lib";
use VSO;
use AlertHandler;
use Log;
use Time::HiRes qw(time);

my $oLog=new Log("../Logs/$0.log",{overwrite=>0,verbose=>5});
my $StartTime;
my $EndTime;
my $NewIp;

select(STDOUT);
$|=1;

open(LOG,">../Logs/MPFAlert.log") or confess "Could not open file for writing";

$oLog->Info(2,"The IP detected is ". VSO::GetIP());
print "Please remove the machine from this network and connect to another network for the test to continue\n";
$oLog->Info(2,"Waiting for Machine to be unplugged");
while(VSO::GetIP() ne '127.0.0.1'){

    print "Network cable is still plugged In.\r";
	sleep 1;
}
$oLog->Info(2,"Machine unplugged");
print "Connect the machine to a new network\n";

$oLog->Info(2,"Waiting for a new IP");
while(VSO::GetIP eq '127.0.0.1'){

	print "Network not connected\r";
	sleep 1;
}
 $NewIp=VSO::GetIP();
$oLog->Info(2,"The IP detected is  $NewIp" );
print "\nThe IP detected is  $NewIp\n";
$StartTime=time;
until(GetHeader()=~m/new network connection/gi){

	sleep 1;
	print "Waiting for network alert\r";
}
$EndTime=time;
$oLog->Info(2,"StartTime : $StartTime");
$oLog->Info(2,"StartTime : $EndTime");
$oLog->Info(2,"Time Taken : ".($EndTime-$StartTime));
print LOG "StartTime: $StartTime\n";
print LOG "EndTime: $EndTime\n";
print LOG "TimeTaken: ".($EndTime-$StartTime)."\n";
print LOG "---------------------------------------------------------------------------\n";
print "\nTime taken : ".($EndTime-$StartTime)." Secs";
