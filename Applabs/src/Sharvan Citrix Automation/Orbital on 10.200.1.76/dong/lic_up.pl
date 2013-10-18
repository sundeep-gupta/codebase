#!/tools/bin/perl

=head1 NAME
lic_up.pl

=head1 SYNOPSIS


=head1 DESCRIPTION
Make sure Orb is reliably rebooted without coredumps (bug #1010)

=head2 Overview
This script call a Python utility (Val's) to upgrade the Primary license via UI.
Since this python script only changes the primary license, the tested Orb needs to
have its secondary license empty.
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

my $testcase = "lic_up";
getopt ("o") ;
if (!$opt_o ) {
  print "Usage: $testcase -o <Orb IP> \n" ;
  exit 1 ;
}
my $host = $opt_o;
chomp ($host);
my $times = 200;
my $log_result = 0;
my $OUTPUT = "STDOUT";

is(run_upgrade($host,$times), 1, "License Upgrade Reliability") ;

sub run_upgrade
{
   my $pythonpath="PYTHONPATH=\/tools\/medusa-20010416";
   my $python="\/tools\/bin\/python";
   my $ui_ctrl="\/tools\/tests\/dong\/python\/ui_ctrl.py";
   my $license="\/tools\/tests\/dong\/python\/lic_pars";
     if ($log_result) {
       my $log_file = ".\/logs\/"."$testcase".".log";
       open (LOG,  "> $log_file") || die "Could not open the file $log_file \n";
       $OUTPUT = "LOG"; }
    for ($i = 1; $i <= $times; $i++)
      {
        my $pid = `ssh $host \"ps -e |grep orbital \"`;
        print $OUTPUT "Upgrade License the $i time \n";
        print $OUTPUT "The Current Orbital PID:\n $pid \n"; 
        $result = `$pythonpath $python $ui_ctrl -I $license $host ` ;
        if (!$result)        #if Python call was not sucessful, exit
          { 
          print $OUTPUT "Python Utility Call failed ...\n";
          exit 1;
          }
        sleep 60;
        #wait until the Orb comes back
        if (`ssh $host \"ls \/orbital\/current\/server\/Trace\/core\* \"`)
          { 
           print "Coredump was generated...\n";
           return 0; }
          else {
            print $OUTPUT "Test $i Passed: no coredump \n"; }
       print $OUTPUT "-------------------------------------\n";
      }  #end of FOR loop
    return 1;   #If no coredump be the end of test 
 } #end of sub

