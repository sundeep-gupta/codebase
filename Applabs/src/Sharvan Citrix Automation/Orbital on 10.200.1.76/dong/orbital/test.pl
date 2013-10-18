#!/usr/bin/perl -w
 
use strict;
use FindBin;
use XMLRPC::Lite;
use Data::Dumper;
use orbital_constants;
use orbital_rpc;
 
#
# Initialization code
#
my $orb = "10.200.38.53" ;
#my $Rpc = Orbital::Rpc->new('http://10.200.38.53:2050/RPC2');
my $Rpc = Orbital::Rpc->new('http://localhost:2050/RPC2');
sleep 3;
print "Test started.\n";
   #
   # If there was an Alert, display it
   #
   (my $NumAlerts, my @Alerts) = $Rpc->get_alerts();
      print("Displaying Alert!\n");
      print" @Alerts \n";
 
   my $MaxAllowedThroughput = $Rpc->get_throughput();
   print "MAX THROUGHPUT: $MaxAllowedThroughput \n";
   my $IsPassthrough = $Rpc->get_parameter("PassThrough");
   print("PassThrough: $IsPassthrough\n");
    
   (my $IPAddress, my $IPMask, my $Dns, my $Gateway, my $Dhcp, my $Hostname) = $Rpc->get_system_net_info();
    
   print "IP: $IPAddress\n";
   print "Netmask: $IPMask\n";
   print "Gateway: $Gateway\n";
   print "DNS: $Dns\n";

