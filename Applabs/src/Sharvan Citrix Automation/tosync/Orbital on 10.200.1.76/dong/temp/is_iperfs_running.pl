#!/usr/bin/perl
#This script determines if IPERF service is running
use strict;
my $string = `ps -e | grep iperf`;
print "my string, $string";
if (( $string =~ /iperf/)) {
  print "The IPERF Service is running\n";
	return 1;
	}else {
	print "Iperf service is not started\n";
  return 0; 
	}
