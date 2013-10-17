use strict;
use WANScaler::XmlRpc::System;
use Data::Dumper;

my $xml = WANScaler::XmlRpc::System->new("http://10.199.32.31:2050/");
my $response = $xml->get_cpu_utilization;
printf "%.3f", $response;