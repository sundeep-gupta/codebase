package WANScaler::XmlRpc::ServiceClass;
use WANScaler::XmlRpc;
use Data::Dumper;
use vars qw(@ISA);
our @ISA = qw(WANScaler::XmlRpc);

sub new {
	my $package = shift;
    my $self = WANScaler::XmlRpc->new(@_);
    bless $self,$package;
}
######################### GETTERS FOR SERVICE CLASS ###########################
sub get_service_class_by_id {
	my $self = shift;
    my $classid = shift;
	my $response = $self->__get_service_class($classid);
    return $response;
}

sub get_service_class_by_name {
	my $self = shift;
    my $name = shift;
    my $response = $self->get_all_service_class;
    foreach $service (@$response) {
		return $service if ($service->{'ClassName'} eq $name);
    }
    return 'Service not found';
}

sub get_all_service_class  {
	my $self = shift;
	return  $self->__get_service_class(0);
}


sub __get_service_class {

   my $self = shift;
   my $class = shift;

#   print Dumper($self);

   my $response = $self->call('ServiceClassGet',{'ClassID' => $class});
   return $response;
}

############# SERVICE CLASS OPERATIONS - ADD, MODIFY, DELETE ###################

sub create_new {
	my $self = shift;
    my $name = shift;
    my $queue = shift;
    my $service_class = {
    					'ClassID' 	=> $self->__get_next_service_id,
                        'ClassName'	=> $name,
                        'Policy' 	=> {
                        				'FlowControl' 	=> 1,
                                        'Compression' 	=> 1,
                                        'ServiceQueue' 	=> $queue,
                                        'CIFS' 			=> 1
                        				}
    					};
    print Dumper($service_class);
	my $sc = $self->call('ServiceClassCreate',$service_class);
    return $sc;
}
sub __get_next_service_id {
	my $self = shift;
	my $sc = $self->get_all_service_class();
    my $max = 1000;
    foreach my $service (@$sc) {
		$max = ($service->{'ClassID'} > $max )?$service->{'ClassID'}:$max;
    }
    print $max;
    return $max+1;

}

sub create_rule {
	my $self = shift;
    my $service_name = shift;
    my $rule = shift;
	my $service_class = $self->get_service_class_by_name($service_name);
	my $rule_rec = $self->__create_rules_rec($rule);
    $service_class->{'SRC_DEST_IP_PORT_ARRAY'} = $rule_rec;
    my $response = $self->test_server_interface_out("ServiceClassChange",$service_class);
    $response = $self->change_service_class($service_class);

}
sub test_server_interface_out {
	my $self = shift;
    my $method = shift;
    my $param = shift;
    return $self->call($method,$param);
}
sub change_service_class {
	my $self = shift;
    my $service_class = shift;
	return $self->call('ServiceClassChange',$service_class);
}
sub __create_rules_rec {
	my $self = shift;
    my $rule = shift;
    my $rule_rec = {};
    if( is_not_null_or_asterisk($rule->{'SRC_IP'} )) {
		$rule_rec = {'Source' => {
        						  'IPAddressMask' => {
                                  						'Display' => $rule->{'SRC_IP'},
        											  	'Dotted'  => $rule->{'SRC_NUM_IP'}
                                                      }
                                 }
                    };
    }
	if( is_not_null_or_asterisk($rule->{'DST_IP'}) ) {
		$rule_rec = {'Source' => {
        						  'IPAddressMask' => {
                                  						'Display' => $rule->{'SRC_IP'},
        											  	'Dotted'  => $rule->{'SRC_NUM_IP'}
                                                      }
                                 }
                    } ;
    }
    $rule_rec->{'Bidirectional'} = $rule->{'BIDIR'};

    if( is_null_or_asterisk($rule->{'FRM_PRT'} or is_null_or_asterisk($rule->{'TO_PRT'})) {

    } elsif (is_ {

    }
    	// If both values are null
		if (!value_not_null_or_asterisk($fromPort) && !value_not_null_or_asterisk($toPort)) {
		    // Do not put any values in the xml

		// If both values are not null
		} else if (value_not_null_or_asterisk($fromPort) && value_not_null_or_asterisk($toPort)) {

			// Place a range in the xml
			$ruleRec['Destination']['PortRange']['Begin'] = $fromPort;
			$ruleRec['Destination']['PortRange']['End'] = $toPort;

		// Only one value is null
		} else {

			// Place the one non null value in the xml
			if (value_not_null_or_asterisk($fromPort)) {
				$ruleRec['Destination']['Port'] = $fromPort;
			}
			if (value_not_null_or_asterisk($toPort)) {
				$ruleRec['Destination']['Port'] = $toPort;
			}
		}
		return $ruleRec;
}

sub is_null_or_asterisk {
	my $ip = shift;
	return 1 if  ( ! defined($ip) and $ip eq '*' );
    return 0;
}
#################### SETTERS FOR SERVICE CLASS POLICY ##########################

sub enable_flow_control {
	my $self = shift;
    my $name = shift;
    my $service_class = $self->get_service_class_by_name($name);
    my $class_id 	  = $service_class->{'ClassID'};

    my $param = {'ClassID' => $class_id,
    			 'Policy'  => {'FlowControl' => 1,
                 			   'Compression' => $service_class->{'Policy'}->{'Compression'},
                  			   'CompressionType' => $service_class->{'Policy'}->{'CompressionType'},
                 			   'ServiceQueue' => $service_class->{'Policy'}->{'ServiceQueue'},
                 			  }
                };
    my $response = $self->call('ServiceClassSetPolicy',$param);
    return $response;

}