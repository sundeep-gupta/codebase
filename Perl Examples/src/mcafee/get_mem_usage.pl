#!/usr/bin/perl -w
use strict;

my $log_file = "mem_cpu_usage.log";
my $delay    = 300;
my $PROCESS_LIST = [ 'VShield',
		     'fmpd', 
                      'Menulet', 
		      'appProtd', 
		      'FWService', 
		    'SiteAdvisorFM', 
	            'McAfee ',
                   'Menulet',
		   'AntiMalware',
		
   ];

my $PROCESS_LIST_2 = [ 'VShieldScanner' , 'VShieldScanManager','VShieldService',
		       'fmpd','Menulet', 'McAfee Internet Security', 'FWService',
                       'AntiMalwareUpdate','appProtd'];
my $cmd = "top -s 1 -l 1 ";
open (my $log, ">$log_file");
while (1) {
    my @output = `$cmd`;
    foreach my $line ( @output ) {
        print $log $line if grep { 
			  $line =~ /$_/;	
			} @$PROCESS_LIST;
	
	}
    print $log "\n\n";
    
    foreach my $process ( @$PROCESS_LIST_2 ) {
	`./leaks '$process' >> leaks_log.log`;
    }
    sleep $delay;
}
close($log);
