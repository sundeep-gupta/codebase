
use WANScaler::XmlRpc::System;
use constant LOCALHOST => '10.199.32.63';
use constant XMLRPC_PORT => 2050;
use Data::Dumper;
use Readonly;
Readonly my $SAMPLE_INSTANCES => 60;

my $options = {'CPU' => 1};

	my $wanscaler		  = WANScaler::XmlRpc::System->new("http://".LOCALHOST.':'.XMLRPC_PORT."/RPC2");
    my $instances = undef;
    my $total = 0;
    my $i;
    my $cpu;
    for($i = 0;$i< $SAMPLE_INSTANCES;$i++) {
		$cpu				  = $wanscaler->get_cpu_utilization() if ($options->{'CPU'} == 1);
        $instances = $instances.($instances?','.$cpu:$cpu);
        $total = $total+$cpu;
        sleep(1);
    }


#	my $compression_ratio = $wanscaler->get_compression_ratio if ($options->{'COMPRESSION_RATIO'} == TRUE);
syswrite(\*STDOUT,Dumper($cpu));

    print Dumper( {'CPU'=>{'Instances' => $instances,
    				 'Average' => $total/$SAMPLE_INSTANCES
    				}
           });
