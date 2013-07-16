#!/usr/bin/perl
package WANScaler::XmlRpc;

use 5.008;
use strict;
use warnings;

use XMLRPC::Lite;
use Data::Dumper;
use Frontier::Client;
use WANScaler::Constants;

use vars qw( @ISA $VERSION);

require Exporter;
############################################################################################
#                          Module creation related things.                                 #
############################################################################################
$VERSION = "1.0";
our @ISA = qw(Exporter);


######################################################################
#
# This class is used to wrap all XMLRPC management calls to the filter
#
######################################################################

sub new() {
    my $self = ();
    shift();
    $self->{RPC_SERVER_URL} = shift();;
    bless($self);
    return $self;
}
sub get_vm_consumption {
	my $self = shift;

	my $ret = $self->get_system_variable("VMConsumption");
    return undef unless ($ret or $ret->{"VMConsumption"});

}

sub get_orbital_version {
	my $self = shift;
	my $version = $self->get_system_variable("Version");
	my @versions = split(/\s+/, $version);
    my $i = 0;
    my $release ="";
    while ($versions[$i]) {
       if ($versions[$i++] eq "Release") {
          $release = "$versions[$i++]"."-";
          my $subver = int ($versions[++$i]);
          $release = "$release$subver";
        }
    }
    return $release;
}

# Set Hardboost on
sub set_hardboost {
	my $self = shift;
    return $self->set_parameter("UI.Softboost","0");
}

# Set send rate to given value.
sub set_send_rate {
	my $self = shift;
    my $value = shift;
    return ERROR if ((!defined($value)) || $value < 0);
    return $self->set_parameter("SlowSendRate",$value);
}
# Get the Hardboost status
sub is_hardboost {
	my $self = shift;
    my $val = $self->get_parameter("UI.Softboost");

}
# Get the send rate.
sub get_send_rate {
	my $self = shift;
    return $self->get_parameter("SlowSendRate");
}

#
# Reread the License file and change the status of Orbital License.
#
sub reread_license_file {
   my $self = shift;
   my $param = shift;
   my $result = XMLRPC::Lite->proxy($self->{RPC_SERVER_URL})
              ->call('RereadLicenseFile', {})
              ->result;
   return $result;
}

#
#Get the Status of Primary License
#
sub get_primary_license_status() {
   my $self = shift;
   my @arr =("PrimaryLicenseFileStatus");

   my $result = XMLRPC::Lite->proxy($self->{RPC_SERVER_URL})
                     ->call('Get', {Class => "SYSTEM", Attribute => \@arr})
                     ->result;
    return $result
}

sub get_secondary_license_status {
   my $self = shift;
   my @arr =("SecondaryLicenseFileStatus");

   my $result = XMLRPC::Lite->proxy($self->{RPC_SERVER_URL})
                     ->call('Get', {Class => "SYSTEM", Attribute => \@arr})
                     ->result;
    return $result
}

sub set_primary_license {
 	my $self = shift;
    my $license = shift;
    my %lic = ();
    $lic{'PrimaryLicense'} = $license;
    return $self->set_license_info(\%lic);
}

sub set_secondary_license {
 	my $self = shift;
    my $license = shift;
    my %lic = ();
    $lic{'SecondaryLicense'} = $license;
    return $self->set_license_info(\%lic);
}


sub get_license_info() {

   my $self = shift;
   my $param = shift;
   my $result = XMLRPC::Lite->proxy($self->{RPC_SERVER_URL})
              ->call('Get', {Class => "LIMIT"})
              ->result;
  return $result;
}
# Set the limits
sub set_license_info() {

   my $self = shift;
   my $param = shift;
   my $result = XMLRPC::Lite->proxy($self->{RPC_SERVER_URL})
              ->call('Set', {Class => "LIMIT", Attribute=>$param})
              ->result;
  return $result;
}

#
# Sets the max throughput of the box.
#
sub get_throughput() {
	my $self = shift;
	return $self->get_parameter("SlowSendRate");
}


sub reboot {
    my $self = shift;
    $self->send_command("reboot");
}

sub reboot_required {
	my $self = shift;
    $self->set_system_variable("UnitRequiresReboot",1);
}
sub get_acclerated_active_count {
	my $self = shift;
    return $self->get_system_variable("AcceleratedActiveConnections");
}
sub get_active_connections {
	my $self = shift;
    my $response = XMLRPC::Lite->proxy($self->{RPC_SERVER_URL})
    							->call('GetInstances',{Class=>'CONNECTION'})
                                ->result;
    return $response;
}

#
# Get the management adapters network info
#
sub get_system_net_info() {
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
sub set_system_net_info() {
   my $self = shift;
   my ($Address, $Mask, $Dns, $Gateway, $Dhcp, $Hostname) = @_;
   my $Response;

   my %Params = ("Address"=> {"Dotted", $Address},
                 "Mask"=>    {"Dotted", $Mask},
                 "Dns"=>     {"Dotted", $Dns},
                 "Gateway"=> {"Dotted", $Gateway},
                 "Dhcp"=>$Dhcp, "Hostname"=>$Hostname);

   my %Params2 = ("NetworkInfo"=>\%Params);

   my %Params3 = ("Class"=>"SYSTEM", "Attribute"=>\%Params2);

   $Response = XMLRPC::Lite->proxy($self->{RPC_SERVER_URL})
		->call('Set', {Class=>"SYSTEM", Attribute=>\%Params2} )
		->result;

}


#
# Get the current rate data is moving through the system (in bits-per-second).
# Returned are LineUsage and GoodPut, both smoothed across 5 seconds
#
sub get_current_transfer_rate {

   my ($self) = @_;
   my @param = ("SmoothedLineUsage", "SmoothedGoodPut");

   my $Response = XMLRPC::Lite->proxy($self->{RPC_SERVER_URL})
                 ->call('Get', {Class => "SYSTEM", Attribute => \@param })
                 ->result;

   return (${$Response}{"SmoothedLineUsage"}) * 8, (${$Response}{"SmoothedGoodPut"}) * 8;
}

#
# Retrieve a parameter
#
sub get_parameter() {

   my $self = shift;
   my $param = shift;
   my $Response = XMLRPC::Lite->proxy($self->{RPC_SERVER_URL})
              ->call('Get', {Class => "PARAMETER", Attribute => $param })
              ->result;
   if ( (element_exists(${$Response}{$param})) && ( exists(${$Response}{$param}{'Fault'})) ) {
     return undef;
   }
   return $Response->{$param}{'XML'};
}


#
# Set a system parameter
#
sub set_parameter() {
	my $self = shift;
	my $param = shift;
	my $value = shift;

	my $Response = XMLRPC::Lite->proxy($self->{RPC_SERVER_URL})
		->call('Set', {Class => "PARAMETER", Attribute => $param, Value => $value })
		->result;
	return ${$Response}{$param};
}

#
# Sends a system command
#
sub send_command() {
	my $self = shift;
	my $param = shift;

	my $Response = XMLRPC::Lite->proxy($self->{RPC_SERVER_URL})
			->call('Command', $param)
			->result;
}

#
# Queries the system for the IP and Mask
#
sub get_system_variable() {
   my $self = shift;
   my $param = shift;

   my $Response = XMLRPC::Lite->proxy($self->{RPC_SERVER_URL})
                     ->call('Get', {Class => "SYSTEM", Attribute => $param})
                     ->result;

   return ${$Response}{$param};
}

#
# Queries the system for the IP and Mask and returns it as an structed value
#
sub get_system_var_struct() {
   my $self = shift;
   my $param = shift;

   my $Response = XMLRPC::Lite->proxy($self->{RPC_SERVER_URL})
						->call('GetParameterAsXML', $param)
                                                ->result;

#  print Dumper($Response);
   return $Response;
}

#
# Queries the system for Alerts
#
sub get_alerts( ) {
   my ($self) = @_;
   my $CountResponse = XMLRPC::Lite->proxy($self->{RPC_SERVER_URL})
              ->call('Get', {Class => "SYSTEM", Attribute => "AlertCount"})
              ->result;
   my $NumAlerts = ${$CountResponse}{"AlertCount"};
   my @Alerts;
   if ($NumAlerts != 0) {

      my $Response = XMLRPC::Lite->proxy($self->{RPC_SERVER_URL})
              ->call('Get', {Class => "SYSTEM", Attribute => "Alerts"})
              ->result;
      my $i =0;

      while ( (${$Response}{"Alerts"}{"Asserted"}[$i]) ) {
       if (${$Response}{"Alerts"}{"Asserted"}[$i][0]) {
	        push(@Alerts, ${$Response}{"Alerts"}{"Asserted"}[$i][0]{"Class"} );
       }
       $i++;
     }


      # If we didn't stuff any alerts into out list, set $NumAlerts = 0
      if ( scalar(@Alerts) == 0) {
	      $NumAlerts = 0;
      }
   }
   return ($NumAlerts, @Alerts);
}

#
# Gets the linkspeed/dupex for each adapter
#
sub get_adapter_info {

   my ($self) = @_;

   my @Attributes = ("InstanceNumber", "DisplayName", "LinkSpeedDuplex", "Duplex", "WireSpeed");

   my $InfoResponse = XMLRPC::Lite->proxy($self->{RPC_SERVER_URL})
              ->call('Get', {Class => "ADAPTER", Attribute => \@Attributes})
              ->result;
   return $InfoResponse;

}

#
# Sets the linkspeed/dupex for each adapter
#
sub set_adapter_info( ) {
   my ($self, $AdapterNum, $LinkDuplex) = @_;
   my @Attributes = {LinkSpeedDuplex=>$LinkDuplex};
   my $InfoResponse = XMLRPC::Lite->proxy($self->{RPC_SERVER_URL})
              ->call('Get', {Class => "ADAPTER", Instance => $AdapterNum, Attribute => \@Attributes})
              ->result;
   return $InfoResponse;

}

# Return if a variable is a hash
#
sub element_exists {
   my $potential_hash = shift;
   return (ref($potential_hash) eq "HASH");
}
1;
