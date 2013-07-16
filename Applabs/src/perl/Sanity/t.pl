use Data::Dumper;
use WANScaler::XmlRpc::ServiceClass;
my $scp = WANScaler::XmlRpc::ServiceClass->new('http://10.199.32.62:2050/RPC2');
####################### RULES FOR SERVICE CLASS ###############################

my $service_name = 'Test123';
my $rule = {
			'SRC_IP' => '*',
            'DST_IP' => '*',
            'FRM_PRT' => 5002,
            'TO_PRT' => 5002,
            'BIDIR' => 0
#            'SRC_NUM_IP' =>
#			'DST_NUM_IP' =>
			};
$response = $scp->add_rule($service_name, $rule);
print Dumper($response);

#################### CREATE Service Class ####################################
#my $service_name = 'Test123';
#my $queue = 'queueA';
#$scp->create_new($service_name,$queue);

################## GET Service Class ######################################
### By ID
#my $response = $scp->get_service_class_by_id(1024);
## By Name
#my $response = $scp->get_service_class_by_name('Telnet');
#### Get Service Classes [ALL]

####################### CONNECTIONS #####################################
#$response = $scp->enable_flow_control('Telnet');
#print Dumper($response);

#print Dumper($response);
#$response = $scp->get_active_connection_count;
#$response = $scp->get_all_active_connections();
#print Dumper($response);
# $response = $scp->get_cifs_accelerated_connection_count;
# print Dumper($response);
#foreach my $inst_num (@{$response->{'Instances'}}) {
#	print $inst_num;
#	$response = $scp->get_active_connection_details($inst_num);
#    print Dumper($response);
#}
#my $response = $scp->get_cifs_accelerated_connections();
print Dumper($response);