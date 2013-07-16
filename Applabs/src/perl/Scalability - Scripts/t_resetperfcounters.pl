use Data::Dumper;
use WANScaler::XmlRpc::System;
$ip = '10.199.32.31';
my $ws = WANScaler::XmlRpc::System->new('http://'.$ip.':2050/');
            print Dumper($ws);
my $ret = $ws->get_recv_compression_ratio();

print Dumper($ret);
$ret = $ws->get_send_compression_ratio();
print Dumper($ret);
my $ret = $ws->call('ResetPerfCounters');
my $ret = $ws->get_recv_compression_ratio();

print Dumper($ret);
$ret = $ws->get_send_compression_ratio();
print Dumper($ret);