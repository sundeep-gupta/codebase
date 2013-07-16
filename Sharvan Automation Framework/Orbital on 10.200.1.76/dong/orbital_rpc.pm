#!/usr/bin/perl
#
package Orbital::Rpc;

#use strict;
use XMLRPC::Lite;
use Data::Dumper;
#use orbital_constants;
use Frontier::Client;

######################################################################
#
# This class is used to wrap all XMLRPC management calls to the filter
#
######################################################################

sub new()
{
	my $self = ();
   
	shift();
	$self->{RPC_SERVER_URL} = shift();;

   if (::DEBUG) { print "Connecting to: " . $self->{RPC_SERVER_URL} . "\n"; }
      
	bless($self);
	return $self;
}

#
# Return if a variable is a hash
#
sub element_exists
{
   my $potential_hash = shift;

   return (ref($potential_hash) eq "HASH");
}

#
# Retrieve a system parameter
#
sub get_parameter()
{
   my $self = shift;
   my $param = shift;
   my $Response = XMLRPC::Lite->proxy($self->{RPC_SERVER_URL})
              ->call('Get', {Class => "PARAMETER", Attribute => $param })
              ->result;

#	print "Dumping: " . Dumper( $Response );   
  
   if ( (element_exists(${$Response}{$param})) && ( exists(${$Response}{$param}{'Fault'})) )
   {
      print "Fault returned by get_parameter\n";
      print Dumper($Response) . "\n";
      exit;
   }   
   return $Response->{$param}{'XML'};
}

#
# Set a system parameter
#
sub set_parameter()
{
	my $self = shift;
	my $param = shift;
	my $value = shift;
	
	my $Response = XMLRPC::Lite->proxy($self->{RPC_SERVER_URL})
		->call('Set', {Class => "PARAMETER", Attribute => $param, Value => $value })
		->result;
	
#	print Dumper(@value);
#	print Dumper($Response) . "\n\n";
	#print "Extracted: " . ${$Value}{$param} . "\n\n";
							
	return ${$Response}{$param};
}

#
# Sets the max throughput of the box.
#
sub get_throughput()
{
	my $self = shift;	
	return $self->get_parameter("SlowSendRate");	
}

#
# Sends a system command
#
sub send_command()
{
	my $self = shift;
	my $param = shift;
	
	my $Response = XMLRPC::Lite->proxy($self->{RPC_SERVER_URL})
			->call('Command', $param)
			->result;
}

#
# Queries the system for the IP and Mask
#
sub get_system_variable()
{
   my $self = shift;
   my $param = shift;

   my $Response = XMLRPC::Lite->proxy($self->{RPC_SERVER_URL})
                     ->call('Get', {Class => "SYSTEM", Attribute => $param})
                     ->result;
	
#  print Dumper($Response);

	return ${$Response}{$param};
}

#
# Queries the system for the IP and Mask and returns it as an structed value
#
sub get_system_var_struct()
{
   my $self = shift;
   my $param = shift;

	my $Response = XMLRPC::Lite->proxy($self->{RPC_SERVER_URL})
							->call('GetParameterAsXML', $param)
							->result;
	   
#  print Dumper($Response);
   return $Response;                     
}

#
# Get the management adapters network info
#
sub get_system_net_info()
{
   my $self =shift;
   
	my $Response = XMLRPC::Lite->proxy($self->{RPC_SERVER_URL})
							->call('Get', {Class => "SYSTEM", Attribute => "NetworkInfo"})
							->result;
   print Dumper($Response);	
   my $Address = ${$Response}{"NetworkInfo"}{"Address"}{"Dotted"};
   my $Mask    = ${$Response}{"NetworkInfo"}{"Mask"}{"Dotted"};
   my $Dns     = ${$Response}{"NetworkInfo"}{"Dns"}{"Dotted"};
   my $Gateway = ${$Response}{"NetworkInfo"}{"Gateway"}{"Dotted"};
   my $Dhcp    = ${$Response}{"NetworkInfo"}{"Dhcp"};
   my $Hostname= ${$Response}{"NetworkInfo"}{"Hostname"};
   
   return ($Address, $Mask, $Dns, $Gateway, $Dhcp, $Hostname);
}

#
# Set the management adapters network info
#
sub set_system_net_info()
{
   my $self = shift;
   my ($Address, $Mask, $Dns, $Gateway, $Dhcp, $Hostname) = @_;      
   my $Response;
   
   my %Params = ("Address"=> {"Dotted", $Address}, 
                 "Mask"=>    {"Dotted", $Mask}, 
                 "Dns"=>     {"Dotted", $Dns},
                 "Gateway"=> {"Dotted", $Gateway}, 
                 "Dhcp"=>$Dhcp, "Hostname"=>$Hostname);
   
   my %Params2 = ("NetworkInfo"=>\%Params);
#  	print "P2222  ",Dumper(\%Params2), "\n";
   my %Params3 = ("Class"=>"SYSTEM", "Attribute"=>\%Params2);
   
#  	print "P333  ", Dumper(\%Params3), "\n";

#   print "----------------------------------------\n";
	$Response = XMLRPC::Lite->proxy($self->{RPC_SERVER_URL})
		->call('Set', {Class=>"SYSTEM", Attribute=>\%Params2} )
		->result;
                     
#   print "----------------------------------------\n";                     
# 	print "Response: . " . Dumper($Response);	
}

#
# Get the current rate data is moving through the system (in bits-per-second). 
# Returned are LineUsage and GoodPut, both smoothed across 5 seconds
#
sub get_current_transfer_rate( )
{
   my ($self) = @_;   

   my @Params = ("SmoothedLineUsage", "SmoothedGoodPut");
                                                                                                                      
#   my $server = Frontier::Client->new( url => RPC_SERVER_URL );
#   my $Response = $server->call("Get", {Class => "SYSTEM", Attribute => \@Params});
    my $Response = XMLRPC::Lite->proxy($self->{RPC_SERVER_URL})
                 ->call('Get', {Class => "SYSTEM", Attribute => \@param })
                 ->result;

   return (${$Response}{"SmoothedLineUsage"}) * 8, (${$Response}{"SmoothedGoodPut"}) * 8;   
}

#
# Queries the system for Alerts
#
sub get_alerts( )
{
   my ($self) = @_;   
   my $CountResponse = XMLRPC::Lite->proxy($self->{RPC_SERVER_URL})
              ->call('Get', {Class => "SYSTEM", Attribute => "AlertCount"})
              ->result;
   my $NumAlerts = ${$CountResponse}{"AlertCount"};
   my @Alerts; 
   if ($NumAlerts != 0)
   {
#      print("Alert Count: $NumAlerts\n");
      my $Response = XMLRPC::Lite->proxy($self->{RPC_SERVER_URL})
              ->call('Get', {Class => "SYSTEM", Attribute => "Alerts"})
              ->result;
      my $i =0;       
#The Alert messages are stored in the 3rd ele of the second array (weird?)
      while ( (${$Response}{"Alerts"}{"Asserted"}[$i]) )
      {
       # print "first array $i" , Dumper(${$Response}{"Alerts"}{"Asserted"}[$i]);
       # print "Second arry ", Dumper(${$Response}{"Alerts"}{"Asserted"}[$i][0]);
       if (${$Response}{"Alerts"}{"Asserted"}[$i][0]) 
       {
        push(@Alerts, ${$Response}{"Alerts"}{"Asserted"}[$i][0]{"Class"} );
       }
     $i++; 
     }
#      print Dumper(\@Alerts);
                  
      # If we didn't stuff any alerts into out list, set $NumAlerts = 0
      if ( scalar(@Alerts) == 0)
      {
      $NumAlerts = 0;
      }
   }
   
   return ($NumAlerts, @Alerts);
   
   #return (${$Response}{"SmoothedLineUsage"}) * 8, (${$Response}{"SmoothedGoodPut"}) * 8;   
}

#
# Gets the linkspeed/dupex for each adapter
#
sub get_adapter_info( )
{
   my ($self) = @_;   
                                                                                                                      
#   my $server = Frontier::Client->new( RPC_SERVER_URL );

   my @Attributes = ("InstanceNumber", "DisplayName", "LinkSpeedDuplex", "Duplex", "WireSpeed");
#   my $InfoResponse = $server->call("Get", {Class => "ADAPTER", Attribute => \@Attributes  });   
   my $InfoResponse = XMLRPC::Lite->proxy($self->{RPC_SERVER_URL})
              ->call('Get', {Class => "ADAPTER", Attribute => \@Attributes})
              ->result;
   
#  print Dumper($InfoResponse);
   return $InfoResponse;
   
}

#
# Sets the linkspeed/dupex for each adapter
#
sub set_adapter_info( )
{
   my ($self, $AdapterNum, $LinkDuplex) = @_;   
   my @Attributes = {LinkSpeedDuplex=>$LinkDuplex};      
#   my $InfoResponse = $server->call("Set", {Class => "ADAPTER", Instance => $AdapterNum, Attribute => @Attributes  } );   
   
   my $InfoResponse = XMLRPC::Lite->proxy($self->{RPC_SERVER_URL})
              ->call('Get', {Class => "ADAPTER", Instance => $AdapterNum, Attribute => \@Attributes})
              ->result;
   return $InfoResponse;
   
}

1;
