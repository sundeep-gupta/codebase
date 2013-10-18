package WAN_Simulator;

use XMLRPC::Lite;
use ORAPP::Config;
use LWP::Simple;
#use Net::SCP qw(scp iscp);
use strict;
use Data::Dumper;
use ORAPP::Global_Library;


# -----------------------------------------------------------
# SETTINGS:
# -----------------------------------------------------------

my $CONFIG = Config::new();

# Define the following
my $ORBITAL_PORT = $CONFIG->{'ORBITAL_PORT'};    # Port number of the Orbital device

# -----------------------------------------------------------
# FUNCTIONS:
# -----------------------------------------------------------

#
# new() - Object constructor
# Input: - $hashref - Hash reference containing all of our test case instance information
# Output - Object reference
sub new {
	my $machine_ip = shift;
	my $self = {
		        "rpc_server_ip"=>$machine_ip
	};
	bless $self, 'WAN_Simulator';
    return $self;
}


my $global_library=Global_Library::new();

# configure_wansimulator() - Configure the WAN-simulator using the given settings
# Input:  $wansim - Hash reference containing delay router settings
# Output: None
sub configure_wansimulator {
    my $wansimip = shift;
	my $wansim = shift;
    
    my $ip = $wansimip->{'rpc_server_ip'};
    my $bw = $wansim->{'bandwidth'};
    my $dly = $wansim->{'delay'};
    my $plr = $wansim->{'plr'};
    my $url = "http://$ip/cgi-bin/wansimconfig.cgi?bw=$bw&dly=$dly&plr=$plr";

	$global_library->print_message("Setting WAN Simulator parameter(s) bw: [$bw], delay: [$dly], plr: [$plr]");
    my $content = get($url);

    # Check to see if anything was returned
    if (!defined($content)) {
        $global_library->print_message("ORAPP>> configure_wansimulator() -> ERROR: No content was returned for LWP::Simple::get()");
		return 1;
    }
	else{
		$global_library->print_message("Parameter(s) set successfully");
		return 0;
	}
}

1;

__END__
