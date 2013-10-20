#!/tools/bin/perl -w
use Time::localtime ;
$tm = localtime;
#$timeStamp = sprintf("%04d-%02d-%02d:%02d:%02d.%02d", $tm->year+1900, ($tm->mon)+1, $tm->mday, $tm->hour, $tm->min, $tm->sec);
$timeStamp = sprintf("%04d%02d%02d%02d%02d", $tm->year+1900, ($tm->mon)+1, $tm->mday, $tm->hour, $tm->min);
print "TIMESTAMP" , $timeStamp , "\n";

