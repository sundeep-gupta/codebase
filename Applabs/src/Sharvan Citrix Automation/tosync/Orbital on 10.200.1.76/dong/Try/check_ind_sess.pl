#!/tools/bin/perl -w



use Test::More  qw(no_plan); 
use Carp ;
use Getopt::Std ;
use Net::RawIP qw ( :pcap) ;

use Time::localtime ;
$tm = localtime;
$timeStamp = sprintf("%04d-%02d-%02d:%02d:%02d.%02d", $tm->year+1900, ($tm->mon)+1, $tm->mday, $tm->hour, $tm->min, $tm->sec);

my $OUTPUT = "STDOUT";
   open (IN,  " testin.txt") || die "Could not open the file: $!  \n";
   open (OUT,  "> testout.txt") || die "Could not create the file: $!  \n";
my $i = 0;
my @sess_result=0;
my @line;
my $total=0;
my $expected_range = 0.70;
my $pass = PASS;
print OUT "$timeStamp\n";
while (<IN>) {
    if (/\/sec/ && !(/\[SUM\]/)) {print OUT;
    @line = split(/\s+/);     #same as split(/\ +/, $_)
    if ($line[7] eq "Mbits\/sec") {$line[6] *= 1000}   #convert to Kbits/sec 
    $sess_result[$i++] = $line[6];
    $total += $line[6]
    }
}   
print ("Average is ", int($total/$i), "\n") ;
printf ("Average is %5d \n", $total/$i ) ;
my $average= int($total/$i);
$average *= $expected_range;
print "AVERAGE:   $average \n";
$i=0; 
while ($sess_result[$i]) {
  if ($sess_result[$i] <=  $average ){
     $pass = FAIL;     
     print "Individual Session BW Allocation Failure \n";
     print ("At the session: ", $i + 1, "\n");
     } 
  
 print "$sess_result[$i++] \n";
  
}
print "PASS/FAIL: $pass \n";
#   my @flow1_rate = split(/\s+/, $flow1_result);
# if (( $string =~ /iperf/)) {
