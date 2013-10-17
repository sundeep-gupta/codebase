use strict;
use warnings;
use WANScaler::CIFSLibrary;
use constant MAX_OCTET_VALUE => 250;
use constant MIN_OCTET_VALUE => 5;

################# Start N READ Sessions of CIFS ###############################
sub start_cifs_in_loop {
	my ($package, $options) = @_;
    while(1) {
    	my $cifs_thread = threads->new(&start_multi_cifs,$options);
        $cifs_thread->join();
    }
	return;
}

sub start_cifs_sessions {
	my ($self, $options) = @_;
    my @start_ip = (@{$options->{ip_address}->{network_address}}, @{$options->{ip_address}->{host_address}});
	my @cifs_threads;
	my $i = 0;
	for($i = 0;$i < $options->{sessions}; $i++ ) {
        my $ip_address = $start_ip[0].'.'.$start_ip[1].'.'.$start_ip[2].'.'.$start_ip[3];
        if($start_ip[4] >= MAX_OCTET_VALUE) {
            $start_ip[3] = MIN_OCTET_VALUE;
            $start_ip[2] = $start_ip[2]++;
        } else {
            $start_ip[3]++;
        }

        my $session_options = {share_name 	  => $options->{share_name},
        					   read_file_name => $options->{read_file_name},
                               read_file_path => $options->{read_file_path},
                               server_address => $ip_address,
                               };
        $cifs_threads[$i] = threads->new(\&cifs_session, $session_options);
    }
	$i = 0;
	my @results;
	foreach my $thread (@cifs_threads) {
		my $ret = $thread->join();
		$results[$i]  = $ret;
		$i++;
	}
	return \@results;
}

sub cifs_session {
	my $session_options = shift;
    my $server_address 		= $session_options->{'server_address'};
    my $read_file_path 		= $session_options->{'read_file_path'};
    my $read_file_name 		= $session_options->{'read_file_name'};
    my $share_path 			= $session_options->{'share_name'};

	my $time = undef;
    my $source_path = undef;
    my $file_size  = undef;;

    #initialize the random number generator
   	my $result = {};
    $source_path = '\\\\'.$server_address.'\\'.$share_path.'\\'.$read_file_path ;
    syswrite(\*STDOUT,$source_path."\n");
    $file_size = -s $source_path.$read_file_name;
    syswrite(\*STDOUT,$file_size);
    $time = WANScaler::CIFSLibrary::copy_file($source_path,$read_file_name);    #if dest not specified copy to NUL:
    if($time == 0 && $err_msg) {
		syswrite(\*STDOUT,"CIFS Read Failed $err_msg\n");
    } else {
  		syswrite(\*STDOUT,"CIFS Read successful : $time \n");
    }
}
