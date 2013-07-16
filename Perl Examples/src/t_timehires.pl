use Time::HiRes qw /gettimeofday/;
print gettimeofday(),"\n";
sleep(2);
print gettimeofday();