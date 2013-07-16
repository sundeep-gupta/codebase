#!/usr/bin/perl -w


# This script is invoked via an HTTP GET request from either the DeviceSettings.pm module 
# or by the Visual Test script via the lwp-request command-line executable. Both methods
# entail issuing an HTTP request in the form of:
#
#  http://216.119.192.126/cgi-bin/wansimconfig.cgi?bw=x&dly=x&plr=x 
#
# where x is populated with values from the test case instance's configuration hash. 
# Presently, the only legal values for each setting are:
#        
#            Bandwidth (bw): 0 (max)
#                            2 (2 Mbps)	
#                            10 (10 Mbps)
#                            155 (155 Mbps)
#
#           Latency (delay): 0 (0 ms)
#                            2 (2 ms)
#                            50 (50 ms)
#                            100 (100 ms)
#
#    Packet Loss Rate (plr): 0 (0% packet loss)
#                            .01 (0.01% packet loss)
#                            .1 (0.1% packet loss)
#



use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);
new CGI;

print header;

if ( param("config") eq "defaults") {
	print system("/usr/local/bin/sudo -u root ipfw pipe 1 config bw 0 queue 0 delay 0 plr 0 2>&1");
	#print "<p>Default settings restored.</p>"; 
	#print "<p>New settings:</p><p>";
	#print system("/usr/local/bin/sudo -u root ipfw pipe show 2>&1");
	#print "</p>";

} else {
    
	my($bw,$delay,$plr) = (0, 0, 0);
    
    $bw = (defined(param("bw"))) ? param("bw") : 0;
    
    # Check to see if we have any decimals in our input. If so, we want to make sure we use bit/s, rather than Mbit/s
    if (defined($bw) && $bw =~ m/\./g) {
        $bw =~ s/\s+//g;
        $bw = $bw * 1000000;
        $bw .= "bit/s";
    }
    else {
        $bw .= "Mbit/s";
    }
    
    $delay = param("dly") if defined(param("dly"));
    $plr = param("plr") if defined(param("plr"));
	
        	
	my $command = "/usr/local/bin/sudo -u root ipfw pipe 1 config bw $bw delay $delay plr $plr 2>&1";
	
	print "<p>Executing: $command</p>";
	system($command);
}


