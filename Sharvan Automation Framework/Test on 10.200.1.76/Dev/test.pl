use ORAPP::WAN_Scalar;

$config = WAN_Scalar::new("10.200.199.90");

#$config->set_orbital_parameter('SlowSendRate',4000000);
#$config->set_orbital_parameter('PassThrough',0);
#$config->set_parameter('Compression.EnableCompression',0);

$config->get_parameter('UI.Softboost',1);
$config->set_parameter('UI.Softboost',1);
$config->get_parameter('UI.Softboost',1);

#$config->get_parameter('SlowSendRate');
#$config->get_parameter('PassThrough');
#$config->get_parameter('Compression.EnableCompression');

#$config->get_trace_logs("sc01orb01","root")


#$config2 = WAN_Scalar::new("10.201.201.103");


#my $wansim = {
#		bandwidth=>45,
#		delay=>100,
#		plr=>0
#	     };	

#$config2->configure_wansimulator($wansim);
