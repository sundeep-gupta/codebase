package WANScaler::IPerfLibrary;

use strict;
use warnings;
use Data::Dumper;
my $IPERF_SEND = 'iperf';
my $IPERF_RECV = 'zperf';
my $MAX_SEED_VALUE = 1000000;
## IPERF_SEND
sub iperf_send  {
	my ($self,$options,$seed) = @_;
    print Dumper($options);
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
    syswrite(\*STDOUT,$iperf_cmd."\n");
    my $result  = `$iperf_cmd`;
   return &format_send_result($result);
#    return $result;
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
	my @iperf_threads;
    my $i;
    for(my $i = 0; $i < $options->{'sessions'} ; $i++) {
		$iperf_threads[$i] = threads->new(\&__iperf_recv, $options);
    }
    my $result = {};
    foreach my $thread (@iperf_threads) {
    	my @i_ret = $thread->join;
        $result->{$thread->tid} = [ @i_ret];
    }
#    print Dumper($result);
    my $instances = undef;
    my $total = 0;
    foreach my $res (keys %$result) {
    	my @arr = $result->{$res};
    	$instances = (defined($instances))? ( ( $result->{$res}[0] ) ? $instances.', '.$result->{$res}[0]
        													:  $instances.', 0' )
        						 :( $result->{$res}[0] ? $result->{$res}[0] : '0');
        $total = $total+$result->{$res}[0] if $result->{$res}[0] ;
    }
#        syswrite(\*STDOUT,$instances."\n");
    return {'Total'=> sprintf ("%0.3f",( $total * 8 )/ ($options->{'time'} * 1000000) ),
    		'Instances' => $instances
            };
}
sub __iperf_recv {
	my $options  = shift;
	my $recv_cmd = "$IPERF_RECV ";
    my $random = rand;
    $random = int ($random * $MAX_SEED_VALUE);

    $recv_cmd = $recv_cmd." -p ".$options->{port} if $options->{'port'};
    $recv_cmd = $recv_cmd." -d ".$options->{'time'}." -i ".$options->{'time'} if $options->{'time'};
    $recv_cmd = $recv_cmd." ".$options->{server};
    $recv_cmd = $recv_cmd.":RANDOM.SEED=".$random if $options->{random};
	$recv_cmd = $recv_cmd.":ZERO " unless $options->{random};
    $recv_cmd = $recv_cmd." NULL";

#	syswrite(\*STDOUT,$recv_cmd);
	my $result = `$recv_cmd`;
#    syswrite(\*STDOUT,$result);
    my @result = &format_recv_result($result);
    return $result[0] unless wantarray;
    return @result;
}
sub format_recv_result {
	my $raw = shift;
	return ($1,$2)if ( ($raw =~ /bytes=(\d+),\s+rate=(\d+.?\d*)/) and $1 and $2) ;
    return undef;
}
## IPERF_SEND_RECV

## FORMAT RESULTS


1;