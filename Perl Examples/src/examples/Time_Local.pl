use Time::Local;
$when = timegm(0,0,10,25,6,5);
utime $when, $when, $ARGV[0];
