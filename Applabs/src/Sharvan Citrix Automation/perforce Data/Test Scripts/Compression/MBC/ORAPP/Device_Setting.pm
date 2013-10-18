package Device_Setting;

use ORAPP::WAN_Scalar;
use ORAPP::WAN_Simulator;
use ORAPP::Config;

sub new {
		$self = {};
		bless $self;
		return $self;
	}
my $config = Config::new();

sub config_wan_scalars {
	shift;
	my $ref_wan_scalar_settings = shift;
	my %wan_scalar_settings = %{$ref_wan_scalar_settings};

	my ($wan_scalar,@wan_scalars, $parameter,$obj_wan_scalar);
	push (@wan_scalars, $config->{"ORBITAL1"});
	push (@wan_scalars, $config->{"ORBITAL2"});

	foreach $wan_scalar (@wan_scalars) {
		$obj_wan_scalar = WAN_Scalar::new($wan_scalar);
		foreach $parameter (keys %wan_scalar_settings) {
			if (!$obj_wan_scalar->set_parameter($parameter,$wan_scalar_settings{$parameter})){
				return 0;
			}
		}
	}
	return 1;
}

sub config_wan_simulator {
	shift;
	my $ref_wan_sim_settings = shift;
	my %wan_sim_settings = %{$ref_wan_sim_settings};

	my $wan_sim = WAN_Simulator::new($config->{"WAN_SIMULATOR"});
	if ($wan_sim->configure_wansimulator(\%wan_sim_settings)) {
		return 1;
	}else {
		return 0;
	}
}

sub reset_perf_counters {
	shift;
	
	my ($wan_scalar,@wan_scalars, $parameter,$obj_wan_scalar);
	push (@wan_scalars, $config->{"ORBITAL1"});
	push (@wan_scalars, $config->{"ORBITAL2"});

	foreach $wan_scalar (@wan_scalars) {
		$obj_wan_scalar = WAN_Scalar::new($wan_scalar);
		if (!$obj_wan_scalar->reset_perf_counters()){
			return 0;
		}
	}
	return 1;
}

sub reset_compression_history {
	shift;
	
	my ($wan_scalar,@wan_scalars, $parameter,$obj_wan_scalar);
	push (@wan_scalars, $config->{"ORBITAL1"});
	push (@wan_scalars, $config->{"ORBITAL2"});

	foreach $wan_scalar (@wan_scalars) {
		$obj_wan_scalar = WAN_Scalar::new($wan_scalar);
		if (!$obj_wan_scalar->exec_console_command("CompressionHistory reset")){
			return 0;
		}
	}
	return 1;
}




1;