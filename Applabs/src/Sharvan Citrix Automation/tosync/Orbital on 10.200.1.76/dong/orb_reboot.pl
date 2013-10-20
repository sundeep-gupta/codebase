#!/tools/bin/perl

=head1 NAME
orb_reboot.pl

=head1 SYNOPSIS


=head1 DESCRIPTION
Make sure Orb is reliably rebooted without coredumps (bug #1010)

=head2 Overview

=head2 Test Category

=head1 ENVIRONMENT

=head1 BUGS

=head1 FILES

=head1 Authors

Dong Duong 
04/05/2005

=head1 COPYRIGHT


=cut 


#use Test::More  qw(no_plan); # the number of tests
use Test::More  tests => 1 ;  
use Carp ;
use Getopt::Std ;


my $testcase = "orb_reboot;
getopt ("o") ;
if (  ! $opt_o ) {
  print "Usage: $testcase -o <Orb IP> \n" ;
  exit 1 ;
}
my $host = $opt_o;
chomp ($host);
my $times = 100;
my $log_result = 0;
my $OUTPUT = "STDOUT";

is(run_reboot($host,$times), 1, "System Reset Reliability") ;

sub run_integrity
  {
     if ($log_result) {
       my $log_file = ".\/logs\/"."$testcase".".log";
       open (LOG,  "> $log_file") || die "Could not open the file $log_file \n";
       $OUTPUT = "LOG"; }
    for ($i = 1; $i <= $times; $i++)
      { $result = `ssh $host \"\/etc\/init.d\/orbital restart \"` ;
        sleep 30
    if ( test passes  ) {
      return 1 ;
      } else { 
          return  0 ; }
  } #end of sub

