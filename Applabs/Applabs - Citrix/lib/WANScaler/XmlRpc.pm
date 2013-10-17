#!/usr/bin/perl
package WANScaler::XmlRpc;

use 5.008;
use strict;
use warnings;

use XMLRPC::Lite;
use Data::Dumper;
use Exporter;

use constant ERROR => 0x01;
use vars qw( @ISA $VERSION);

$VERSION = "1.0";
our @ISA = qw(Exporter);

sub new() {
    my $self = ();
    shift();

    $self->{RPC_SERVER_URL} = shift();;
    bless($self);
    return $self;
}

sub get_virtual_clients {
	my $self = shift;
    my $ret = $self->get_parameter("System.VirtualClients");
    return $ret;
}

sub set_virtual_clients {
	my $self = shift;
    my $clients = shift;
    my $ret = $self->set_parameter("System.VirtualClients",$clients);
    return $ret;
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


#
# Retrieve a parameter
#
sub get_parameter() {

   my $self = shift;
   my $param = shift;
   my $Response = XMLRPC::Lite->proxy($self->{RPC_SERVER_URL})
              ->call('Get', {Class => "PARAMETER", Attribute => $param })
              ->result;
   if ( (element_exists(${$Response}{$param})) && ( exists(${$Response}{$param}{'Fault'}))

) {
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
		->call('Set', {Class => "PARAMETER", Attribute => $param, Value => $value

})
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
# THIS FUNCTION IS USED BY OTHER MODULES ALSO - INHERITED
#
sub get_system_variable {
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
# Gets the linkspeed/dupex for each adapter
#
sub get_adapter_info {

   my ($self) = @_;

   my @Attributes = ("InstanceNumber", "DisplayName", "LinkSpeedDuplex", "Duplex","WireSpeed");

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
              ->call('Get', {Class => "ADAPTER", Instance => $AdapterNum, Attribute =>

\@Attributes})
              ->result;
   return $InfoResponse;

}

# Return if a variable is a hash
#
sub element_exists {
   my $potential_hash = shift;
   return (ref($potential_hash) eq "HASH");
}
sub reset_perf_counters {
	my $self = shift;
	return $self->call('ResetPerfCounters');
}
sub call {
	my ($self, $method, $parameters) = @_;
    print $self->{RPC_SERVER_URL};
   my $InfoResponse = XMLRPC::Lite->proxy($self->{RPC_SERVER_URL})
              ->call($method,$parameters)
              ->result;
   return $InfoResponse;

}
1;