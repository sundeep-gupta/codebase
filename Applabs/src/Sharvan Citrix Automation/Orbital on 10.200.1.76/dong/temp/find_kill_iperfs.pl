#!/usr/bin/perl
#Dong (3/07/05)
#This script determines if IPERF service is running
#If it does, extract the PID and kill it.
use strict;
my $string = `ps -e | grep iperf | tail -1 `;
my @field = split(/\s+/,$string);
#print "MYFIELDS  ..\n @field";
if (( $string =~ /iperf/)) {
  print "The IPERF Service is running\n";
#Need to kill the Deamon
#Note that a sucessful KILL return a zero, so be carefull
#with the subsequent IF
  if (`kill $field[1]`) {
	   print "the Iperf deamon ID:$field[1] was not killed";
		 } else {
	   print "the Iperf deamon ID:$field[1] was killed";
		 }
#	return 1;
	}else {
	print "Iperf service is not started\n";
#  return 0; 
	}
