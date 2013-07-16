package WANScaler::IPerfLibrary;
use Readonly ;
use strict;
use warnings;
use Data::Dumper;
Readonly my $IPERF_SEND => 'iperf';
Readonly my $IPERF_RECV => 'zperf';
Readonly my $MAX_SEED_VALUE => 1000000;
## IPERF_SEND
sub iperf_send  {
	my ($self,$options,$seed) = @_;
    my $iperf_cmd 	= "$IPERF_SEND -c ".$options->{'server'};
 	$iperf_cmd 		= $iperf_cmd.' -p '.$options->{'port'} if $options->{'port'};
    $iperf_cmd 		= $iperf_cmd.' -f m ' ;
    if( $options->{'time'}) {
	    $iperf_cmd 	= $iperf_cmd.' -t '.$options->{'time'};
    } elsif ($options->{'size'}) {
	    $iperf_cmd 	= $iperf_cmd.' -n '.$options->{'size'} ;
    }
    $iperf_cmd 		= $iperf_cmd.' -X '.$seed if ( $options->{'random'} == 1 and $seed);
    $iperf_cmd 		= $iperf_cmd.' -P '.$options->{'sessions'} if $options->{'sessions'};
    my $result = `$iperf_cmd`;
    $result = format_send_result($result);
    return $result;
}

############################ FORMATTER OF IPERF RESULT #########################
sub format_send_result {
    my $iperf_response = shift;
    my @response = split(/\n/,$iperf_response);
	my $instances = undef;
	my $total = 0;
    foreach (@response) {
        if( $_ =~ /^\[(\d+)\]/ ) {
           my $id = $1;
           if ($_ =~ /\s+(\d+\.?\d*)\s+Mbits\/sec/){
			   if ($1) {
   		        	$instances = $instances. ( $instances ? ','.$1 : $1 );
				}
            }
        } elsif ($_ =~ /SUM/ ){
            if ($_ =~ /\s+(\d+\.?\d*)\s+Mbits\/sec/){
               	$total = $1 if $1;
           	}
        }
    }
    my $ret = { 'Total' 	=> $total,
    			'Instance'  => $instances
                };
    return $ret;
}

####################################### IPERF_RECV #############################
sub iperf_recv {
	my ($self,$options,$seed) = @_;
	my $iperf_threads;
    my $i;

	$iperf_threads = threads->new(\&__iperf_recv, $options);
   	my $i_ret = $iperf_threads->join;
	return &format_recv_result($i_ret);

}
sub __iperf_recv {
	my $options  = shift;
	my $recv_cmd = "$IPERF_RECV ";
    my $random = rand;
    $random = int ($random * $MAX_SEED_VALUE);

    $recv_cmd = $recv_cmd." -p ".$options->{port} if $options->{'port'};
    $recv_cmd = $recv_cmd." -d ".$options->{'time'}." -i ".$options->{'time'} if $options->{'time'};
    $recv_cmd = $recv_cmd." -P ".$options->{'sessions'} if $options->{'sessions'};
    $recv_cmd = $recv_cmd." ".$options->{server};
    $recv_cmd = $recv_cmd.":RANDOM.SEED=".$random if $options->{random};
	$recv_cmd = $recv_cmd.":ZERO " unless $options->{random};
    $recv_cmd = $recv_cmd." NULL";

#	syswrite(\*STDOUT,$recv_cmd);
	my $result = `$recv_cmd`;
    return $result;
}
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