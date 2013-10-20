package WAN_Scalar;

use XMLRPC::Lite;
use ORAPP::Config;
use strict;
use ORAPP::Global_Library;
use LWP::Simple;
my $config = Config::new();
my $global_library=Global_Library::new();
my $ORBITAL_PORT = $config->{'ORBITAL_PORT'};

sub new {
	my $ws = shift;
	my $self = {
		"rpc_server_ip"=>$ws
	};
	bless $self, 'WAN_Scalar';
    return $self;
}

sub set_parameter {
    chomp(my $self = shift);
    chomp(my $param = shift);
    chomp(my $value = shift);

    my $url = "http://$self->{rpc_server_ip}:$ORBITAL_PORT/RPC2";
    
	# Define our parameter names and values
    my $parameter_name = ($param) ? $param : "Parameter name not defined";
    my $parameter_value = (($value) || ($value == 0)) ? $value : "Parameter value not defined";

    $global_library->print_message("Setting orbital [$self->{rpc_server_ip}] parameter: [$param] with value: [$value]");
    my $response =  XMLRPC::Lite
        ->proxy($url)
        ->call('Set', {Class => "PARAMETER", Attribute => $param, Value => eval($value) })
        ->result;

    if (defined(${$response}{'Fault'})) {
	$global_library->print_message("${$response}{'Fault'}\n");
	$global_library->print_message("Parameter couldn't be set");
	return 0;
    }
    else {
        $global_library->print_message("Parameter set successfully");
        return 1;
    }		
}

sub get_parameter {
    chomp(my $self = shift);
    chomp(my $param = shift);

    my $url = "http://$self->{rpc_server_ip}:$ORBITAL_PORT/RPC2";

    # Define our parameter names and values
    my $parameter_name = ($param) ? $param : "Parameter name not defined";

    $global_library->print_message("Getting orbital [$self->{rpc_server_ip}] parameter: [$param]");
    my $response =  XMLRPC::Lite
         ->proxy($url)
         ->call('Get', {Class => "PARAMETER", Attribute => "$param" })
         ->result;


    if (!defined(${$response}{$param}{'Fault'})) {
        while (( my $okey, my $oval) = each %$response) {
             if ($oval->{'XML'} =~ (m/^ARRAY/)) {
                  $global_library->print_message($okey . " = " . $oval->{'Text'});
              }
             else {
                    $global_library->print_message($okey . " = " . $oval->{'XML'});
              }
         }
		 return 1;
     }
     else {
            print "${$response}{$param}{'Fault'} $param\n";
			return 0;
     }

}
sub exec_console_command {
        chomp(my $self = shift);
        my $param = shift;
        my $response = XMLRPC::Lite->proxy("http://$self->{rpc_server_ip}:2050/RPC2")
                ->call('Command', $param)
                ->result;
       
        if($response ne "Fault")
	{
		return 1;
	}else{
		return 0;
	}	                
}

sub reset_perf_counters {
        chomp(my $self = shift);
                
	$global_library->print_message("Resetting Perf Counters at [$self->{rpc_server_ip}]");
        my $response = XMLRPC::Lite->proxy("http://$self->{rpc_server_ip}:2050/RPC2")
            ->call("ResetPerfCounters")
            ->result;
	if($response ne "Fault")
	{
		return 1;
	}else{
		return 0;
	}	
}            

1;

__END__
