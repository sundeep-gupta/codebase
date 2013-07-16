package WANScaler::ZPerfLibrary;
use Readonly ;
use strict;
use warnings;
use Data::Dumper;
Readonly my $ZPERF_RECV => 'zperf';
Readonly my $MAX_SEED_VALUE => 1000000;
## IPERF_SEND




####################################### ZPERF ##################################
sub zperf_recv {
	my ($self,$options,$seed) = @_;
	my $zperf_threads;
    my $i;

	$zperf_threads = threads->new(\&__zperf_recv, $options);
   	my $i_ret = $zperf_threads->join;
	return &format_recv_result($i_ret);

}
sub __zperf_recv {
	my $options  = shift;
	my $recv_cmd = "$ZPERF_RECV ";
    my $random = rand;
    $random = int ($random * $MAX_SEED_VALUE);

    $recv_cmd = $recv_cmd." -p ".$options->{port} if $options->{'port'};
    $recv_cmd = $recv_cmd." -d ".$options->{'time'}." -i ".$options->{'time'} if $options->{'time'};
    $recv_cmd = $recv_cmd." -P ".$options->{'sessions'} if $options->{'sessions'};
    $recv_cmd = $recv_cmd." ".$options->{server};
    $recv_cmd = $recv_cmd.":RANDOM.SEED=".$random if $options->{random};
	$recv_cmd = $recv_cmd.":ZERO " unless $options->{random};
    $recv_cmd = $recv_cmd." NULL";

	syswrite(\*STDOUT,$recv_cmd);
	my $result = `$recv_cmd`;
    return $result;
}
######################## FORMATTING ZPERF RESULTS ########################################
sub format_recv_result {
	my $raw = shift;
    my @lines = split("\n",$raw);
    my $total = 0;
    my $instances = undef;
    foreach my $line (@lines) {
		if ( ($line =~ /bytes=(\d+),\s+rate=(\d+.?\d*)/) and $1 and $2) {
        	$total = $total + $2;
            $instances = ($instances) ? $instances.", ".$2 :
            						    $instances.$2;
        }
    }
    return {
    		'Total'=>$total,
    		'Instances'=>$instances
            };
}
## IPERF_SEND_RECV

## FORMAT RESULTS


1;