package Library::Iperf;
use strict;
use warnings;
use lib qw(../../);
use WANScaler::Library::Logger;
use Data::Dumper;
BEGIN {
	push(@INC, '../../');
}
use POSIX ":sys_wait_h";

#    $options = {
#            'Bidirection' => 1,
#            'Uncompressible' => SEED,
#            'Connections' => 1,
#            'Time' => 15,
#            'Port' => 5001,
#            'Bytes' => 3000,
#       };
#my $iperf = run_iperf('localhost',$options);
#print Dumper($iperf);

# Bytes unimplimented...
sub run_iperf {
	my ($server, $options) = @_;

    #return if server address is missing
    my $return = {'Result'=> 'FAIL','Reason' => 'Server address missing'};
    return $return unless $server;

    my $iperf_cmd = 'iperf';
	my $iperf_options = '';
    $iperf_options .= " -c ".$server;
    $iperf_options .= " -p ". int $options->{'Port'} if $options->{'Port'};
    $iperf_options .= " -t ". int $options->{'Time'} if $options->{'Time'};
    $iperf_options .= " -X ". int $options->{'Uncompressible'} if $options->{'Uncompressible'};
    $iperf_options .= " -P ". int $options->{'Connections'} if $options->{'Connections'};
    $iperf_options .= " -n ". int $options->{'Bytes'} if ($options->{'Bytes'} and not $options->{'Time'});
    $iperf_options .= " -d " if $options->{'Bidirection'};
    my @iperf_ret = __run_iperf($iperf_cmd,$iperf_options);

    $return = parse_iperf_result(@iperf_ret);
    return $return;
}
sub __run_iperf {

	my $iperf = shift;
    my $options = shift;
    my @result = `$iperf $options 2>&1`;
    return @result;
}

sub parse_iperf_result {
    my %res = ();
	my @conn_ids;
    local $_ ;
	foreach  $_ ( @_ ) {
       $res{'Connections'}{$1} ={} if ((/^\[(\d+)\]\s+/) and (not exists $res{'Connections'}{$1}));
       if ($1) {
       		if(not exists($res{'Connections'}{$1})) {
            	$res{'Connections'}{$1} = {};
            } else {
           	my $key = $1;
            	/\s+\d+\.?\d+-\s*(\d+\.?\d+)\s+sec\s+(\d+\.?\d+)\s+MBytes\s+(\d+\.?\d+)\s+Mbits\/sec/;
                $res{'Connections'}{$key}{'Time'} = $1;
                $res{'Connections'}{$key}{'Bytes'} = $2;
                $res{'Connections'}{$key}{'Bandwidth'} = $3;
            }
       } else {
       		chomp($_);
            if(/^\[(SUM)\]\s+/) {
            	/\s+\d+\.?\d+-\s*(\d+\.?\d+)\s+sec\s+(\d+\.?\d+)\s+MBytes\s+(\d+\.?\d+)\s+Mbits\/sec/;
                $res{'Time'} = $1;
                $res{'Bytes'} = $2;
                $res{'Bandwidth'} = $3;
            }
       }
    }
    if(%res == ()){
    	$res{'Result'} = 'FAIL';
        $res{'Reason'} =  join(' ',@_);
    } else {
    	$res{'Result'} = 'PASS';
    }
    return \%res;
}
1;