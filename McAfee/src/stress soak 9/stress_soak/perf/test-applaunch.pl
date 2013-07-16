#!/usr/bin/perl

open (CONFIG, "AppListConfig.txt")  || warn "Couldn't open config file for Application Launch Perf test cases\n";
my @configlines = <CONFIG>;
close (CONFIG);

# Execute each test case taking each line from config file

 my $perflogfile = "/tmp/perf_application_list.tmp";
`rm -f $perflogfile`;
$total_time = 0; 
   foreach my $testcase(@configlines)
 
   { 
    chomp ($testcase);
    print "$testcase\n";
    #launch and close the app (thru applescript)
    system (`osascript ../Includes/LaunchCloseApps.scpt "$testcase"`); 
   }

