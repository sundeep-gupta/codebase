#!/tools/bin/perl
#
# Dong 3/21/05
# This test requires the HTTPD running on the server.  All the
# files being downloaded from the HTTPD must exist in the 
# /var/www/html directory. For convenience, just do a symbolic copy
#from the /tools/files directory )cp -s /tools/files/* /var/www/html
# ***check the /etc/httpd/logs for errors if appl
#**********************************************
use Test::More tests => 2; # the number of tests
use Getopt::Std;

use vars qw( $opt_s);
getopt ("s") ;
my $host;
if ( $opt_s ) {
   $host = $opt_s ;
} 
my $testcase = "ab";
die "\nUsage: $testcase.pl -s  < HTTP Server ip address> \n\n" unless ($host ) ;
chomp ($host) ;

my $url= "http://" . $host ."/" ;
my $log_result = 1;
my $OUTPUT = "STDOUT";


print "URL:$url\n";
#ok( run_ab( 4,2, $url, "1k.file") =~ /^Failed\W+requests:\W+0$/gxms   , 'ab: 1k file 4 times, 2 concurrent') ;
#ok( run_ab( 8,2, $url, "1k.file") =~ /^Failed\W+requests:\W+0$/gxms   , 'ab: 1k file 8 times, 2 concurrent') ;
#ok( run_ab( 20,10, $url, "1k.file") =~ /^Failed\W+requests:\W+0$/gxms  , 'ab: 1k file 20 times,  10 concurrent') ;
#ok( run_ab( 40,10, $url, "1k.file") =~ /^Failed\W+requests:\W+0$/gxms  , 'ab: 1k file 40 times, 10 concurrent') ;
#ok( run_ab( 100,20, $url, "1k.file") =~ /^Failed\W+requests:\W+0$/gxms , 'ab: 1k file 100 times, 20 concurrent') ;

#ok( run_ab( 4,2, $url, "10k.file") =~ /^Failed\W+requests:\W+0$/gxms   , 'ab: 10k file 4 times, 2 concurrent') ;
#ok( run_ab( 8,2, $url, "10k.file") =~ /^Failed\W+requests:\W+0$/gxms   , 'ab: 10k file 8 times, 2 concurrent') ;
#ok( run_ab( 20,4, $url, "10k.file") =~ /^Failed\W+requests:\W+0$/gxms  , 'ab: 10k file 20 times,  4 concurrent') ;

#ok( run_ab( 4,2, $url, "100k.file") =~ /^Failed\W+requests:\W+0$/gxms   , 'ab: 100k file 4 times, 2 concurrent') ;
#ok( run_ab( 8,2, $url, "100k.file") =~ /^Failed\W+requests:\W+0$/gxms   , 'ab: 100k file 8 times, 2 concurrent') ;

#ok( run_ab( 4,2, $url, "1M.file") =~ /^Failed\W+requests:\W+0$/gxms   , 'ab: 1M file 4 times, 2 concurrent') ;
#ok( run_ab( 8,2, $url, "1M.file") =~ /^Failed\W+requests:\W+0$/gxms   , 'ab: 1M file 8 times, 2 concurrent') ;
#ok( run_ab( 20,4, $url, "1M.file") =~ /^Failed\W+requests:\W+0$/gxms  , 'ab: 1M file 20 times,  4 concurrent') ;
ok( run_ab( 40,8, $url, "100M.file") =~ /^Failed\W+requests:\W+0$/gxms  , 'ab: 100M file 40 times, 8 concurrent') ;
ok( run_ab( 400,100, $url, "srf719M.txt") =~ /^Failed\W+requests:\W+0$/gxms  , 'ab:isrf719M.txt file 40 times, 8 concurrent') ;

sub run_ab
  {
  my $connections = shift ;
  my $concurrent = shift ;
  my $url = shift ;
  my $file = shift ;
  $url .= "/$file" ;
  
  if ($log_result) {
       my $log_file = ".\/logs\/"."$testcase".".log";
       open (LOG,  ">> $log_file") || die "Could not open the file $log_file \n";
       $OUTPUT = "LOG";
     }

  my $ab  = `/tools/bin/ab -n $connections -c $concurrent $url`  ;
  print $OUTPUT  "Test Result: $ab \n";
  print $OUTPUT  "------------------------------ \n\n";
  return $ab ;
}

