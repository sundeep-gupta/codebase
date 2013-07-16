package WANScaler::XmlRpc::System;
use strict;
use Readonly;
use WANScaler::XmlRpc;

Readonly my $MAX_CPU_USAGE_TIME => 'MainCPUUsageTime';
Readonly my $MAX_CPU_IDLE_TIME 	=> 'MainCPUIdleTime';

use vars qw(@ISA);
our @ISA = qw(WANScaler::XmlRpc);

###################### CONSTRUCTOR ##########################
sub new {
	my $package = shift;
    my $self = WANScaler::XmlRpc->new(@_);
    bless $self,$package;
}

##################### CPU UTILIZATION ######################
sub get_cpu_utilization {
	my $self = shift;
    my $response1 = $self->get_system_variable($MAX_CPU_USAGE_TIME);
    my $response2 = $self->get_system_variable($MAX_CPU_IDLE_TIME);
	return &__compute_cpu($response1,$response2);
}

sub __compute_cpu {
	my ($used,$idle) = @_;
    my @usage_rate = @{$used->{'Rate'}};
    my @idle_rate = @{$idle->{'Rate'}};
    my ($usage_sum, $idle_sum);

	 foreach my $rate (@usage_rate){
	     $usage_sum = $usage_sum + $rate;
     }
	foreach my $rate (@idle_rate){
	    $idle_sum = $idle_sum + $rate;
    }
    my $cpu = ($usage_sum / ($usage_sum + $idle_sum))*100;
    return $cpu;
}

##################### VIRTUAL MEMORY CONSUMPTION ########################
sub get_vm_consumption {
	my $self = shift;

	my $ret = $self->get_system_variable("VMConsumption");
    return undef unless ($ret or $ret->{"VMConsumption"});
}

########################## WANScaler VERSION ############################
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

######################## ACCELERATED ACTIVE COUNT ############################
sub get_acclerated_active_count {
	my $self = shift;
    return $self->get_system_variable("AcceleratedActiveConnections");
}

################ GET SYSTEM NET INFORMATION ##################################
sub get_system_net_info() {
   my $self =shift;

   my $Response = $self->get_system_variable("NetworkInfo");
   print Dumper($Response);
   my $Address = ${$Response}{"NetworkInfo"}{"Address"}{"Dotted"};
   my $Mask    = ${$Response}{"NetworkInfo"}{"Mask"}{"Dotted"};
   my $Dns     = ${$Response}{"NetworkInfo"}{"Dns"}{"Dotted"};
   my $Gateway = ${$Response}{"NetworkInfo"}{"Gateway"}{"Dotted"};
   my $Dhcp    = ${$Response}{"NetworkInfo"}{"Dhcp"};
   my $Hostname= ${$Response}{"NetworkInfo"}{"Hostname"};

   return ($Address, $Mask, $Dns, $Gateway, $Dhcp, $Hostname);
}

########### MANAGEMENT ADAPTER INFORMATION IS SET HERE ... :-) ################
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

################# HAVE TO CHANGE THIS --- TODO ############################

   $Response = XMLRPC::Lite->proxy($self->{RPC_SERVER_URL})
		->call('Set', {Class=>"SYSTEM", Attribute=>\%Params2} )
		->result;

}


############# CURRENT DATA TRANSFER RATE (bps) ##############
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

################ CHECK IF WE HAVE ALERTS ###########################
sub get_alerts {

   my $self  = shift;
   my $CountResponse = $self->get_system_variable("AlertCount");
   my $NumAlerts = ${$CountResponse}{"AlertCount"};
   my @Alerts;
   if ($NumAlerts != 0) {

      my $Response = $self->get_system_variable("Alerts");
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
