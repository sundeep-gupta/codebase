use XMLRPC::Lite;
use Data::Dumper;

my $param = {
         Class=> 'CONNECTION',
         Filter=> {
                    "Address" => {
                    			'Src' => {
                                            Range => {
                                                     Left => {
                                                                Dotted => '0.0.0.0',
                                                                Port => 0
                                                                },
                                                     Right => {
                                                                Dotted	=>'255.255.255.255',
                                                                Port 	=> 65535
                                                                },
                                                    },
                                         },
                                 },
                    "Address" => {
                    			'Dst'  => {
                                            Range => {
                                                     Left => {
                                                                Dotted => '0.0.0.0',
                                                                Port => 5001
                                                                },
                                                     Right => {
                                                                Dotted=>'255.255.255.255',
                                                                Port => 5001
                                                                },
                                                    },
                                            },
                                       },
                  },
#         Count	=> 0,
#         InstanceCount => 0,
#         FirstInstance => 0,
            };
#$param->{'Filter'} = undef;
my $response = XMLRPC::Lite->proxy('http://10.199.32.63:2050/')
						   ->call('GetInstances',$param)
                           ->result;
print Dumper($response);