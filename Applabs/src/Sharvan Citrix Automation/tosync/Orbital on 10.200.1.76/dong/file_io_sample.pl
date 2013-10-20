#!/tools/bin/perl

#use Test::More  qw(no_plan); # the number of tests
use Test::More  tests => 1 ;  
use Carp ;
use Getopt::Std ;
use Net::RawIP qw ( :pcap) ;
my $testcase = "softboost_001";
my $log_result = 1;
my $OUTPUT = "STDOUT";
if ($log_result) {
   my $log_file = ".\/logs\/"."$testcase".".log";
   open (LOG,  "> $log_file") || die "can't open the file $log_file";
   print STDOUT "see if it print to mon";
   $OUTPUT = "LOG";
    }  
   print $OUTPUT "test result ..$result \n";
   print $OUTPUT "The expected rate: $expected_rate Mbits/sec\n";
   print $OUTPUT "The actual rate  : $rates[6] $rates[7]\n";


