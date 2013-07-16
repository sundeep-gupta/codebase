package WANScaler::IPerfLibrary;
use Readonly ;
use strict;
use warnings;
use Data::Dumper;
Readonly my $IPERF_SEND => 'iperf';

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
    	syswrite(\*STDOUT,$iperf_cmd);
    my $result = `$iperf_cmd`;

   # $result = format_send_result($result);
    return $result;
}
#syswrite(\*STDOUT,$iperf_cmd);

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


## IPERF_SEND_RECV

## FORMAT RESULTS


1;