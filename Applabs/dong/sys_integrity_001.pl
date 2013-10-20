#!/tools/bin/perl

=head1 NAME
sys_integrity_001.pl

=head1 SYNOPSIS


=head1 DESCRIPTION
This script calls 2 linux host to generate a total of 200
sessions of compressed data.
There are 2 Windows servers running Iperf service continuously in a loop
(use the script X:\dong-suites\iperfs.bat)

=head2 Overview

=head2 Test Category
Softboost & Compression.

=head1 ENVIRONMENT
The control unit is the tested linux_1. This script requires 3 inputs: linux_2.
Win_1, and Win_2.

The total number of sessions, data files, and duration can be statically changed
to accomodate various test scenarios when the needs arise.

=head1 BUGS

=head1 FILES

=head1 Authors

Dong Duong 
3/28/2005

=head1 COPYRIGHT


=cut 


#use Test::More  qw(no_plan); # the number of tests
use Test::More  tests => 1 ;  
use Carp ;
use Getopt::Std ;
use Net::RawIP qw ( :pcap);

getopt ("u, s, t") ;
if (  ! $opt_u || !$opt_s || !$opt_t ) {
  print "Usage: testcase -u <linux_2> -s <win_1> -t <win_2> \n" ;
  exit 1 ;
}
#Note that lin_1 is the host running this script.
my $lin_2 = $opt_u;
chomp ($lin_2);
my $win_1 = $opt_s;
chomp ($win_1);
my $win_2 = $opt_t;
chomp ($win_2);
my $sess = 100;    #modify this par to inrease/decrease the #sessions per direction
my $files = "/tools/files/comp_files/" #the directory of the tested files.
my $duration = 99999;
my $log_result = 0;
my $OUTPUT = "STDOUT";
my $testcase = "sys_integrity_001";

is (run_integrity ($lin_2, $win_1, $win_2), 1, "Sys_Integrity_01: Softboost & Compression") ;


sub run_integrity
  {
    my $lin_1 = shift ;
    my $win_1 = shift ;
    my $win_2 = shift ;
    if ($log_result) {
       my $log_file = ".\/logs\/"."$testcase".".log";
       open (LOG,  "> $log_file") || die "Could not open the file $log_file \n";
       $OUTPUT = "LOG"; }

#There are 3 options to activate Windows Iperf services:
# 1. Manually run /tools/../Filestest/iperf -s
# 2. or execute the /tools/../dong-suites/iperfs.bat
# 3. use SSH to invoke the iperfs.bat (need SSHD on windows
#----------------------------------------
# Execute the below line when SSHD for Windows is available:
#   print $OUTPUT `SSH administrator\@$win_1 \"x:\\dong-suites\\iperfs.bat\"`    
#   print $OUTPUT `SSH administrator\@$win_2 \"x:\\dong-suites\\iperfs.bat\"`

# Call iperf_c_comp.sh from the lin_1 system
# this will generate 100 sess between lin_1 and Win_1
  system (/tools/tests/dong/iperf_c_comp.sh $win_1 $sess $duration $files &);

#Run iperf_c_comp.sh on lin_2 using SSH
  system (ssh $lin_2 "/tools/tests/dong/iperf_c_comp.sh $win_2 $sess $duration $files" &);

#May need to monitor the DUT later on.
#For now, the test will run until <ctrl><break>
    
#    if ( test passes  ) {
#      return 1 ;
#      } else { 
#          return  0 ; }
  } #end of sub

