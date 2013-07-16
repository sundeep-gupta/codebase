package WANScaler::Scalability::CIFSLibrary;
use strict;
our @ISA = ('WANScaler::CIFSLibrary');
sub new {
  my $class = shift;
  my $options = shift;
  $self = {
	  START_IP 	=> \(@{$options->{ip_address}->{network_address}},
			      @{$options->{ip_address}->{host_address}}),
	  OPERATIONS 	=> $options->{operations}, # READ, WRITE, PARALLEL, RW, WR
	  
	  SESSIONS 	=> $options->{sessions},
	  READ	 	=> {
			    SRC_SHARE   => $options->{share},
			    SRC_DIR 	=> $options->{read_file_path},
			    SRC_FILES 	=> $options->{read_files},
			    WR_TO_DSK 	=> $options->{write_to_disk},
			    DST_DIR	=> $options->{read_dst_dir},
			   },
	  WRITE 	=>{
			   SRC_DIR	=> $options->
			  }
	  
	  };
  my $self = bless {options => $options}, $class;
  return $self;
}

sub run {
    #my ($self, $options) = @_;
    
    my @start_ip = (@{$options->{ip_address}->{network_address}},
                    @{$options->{ip_address}->{host_address}});
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
                               'index' 		  => $i
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
    my $write_file_name    	= $session_options->{'write_file_name'};     # TODO
    my $write_file_path    	= $session_options->{'write_file_path'};     # TODO
    my $browse_dir_name		= $session_options->{'browse_dir_name'};     # TODO
    my $share_path 	   	= $session_options->{'share_name'}; 		 # TODO
    my $index 			= $session_options->{'index'};

    my $avg_pause_time = undef;

#	local $log_prefix = $server_address."-".$share_path."-";
	my $time = undef;
    my $source_path = undef;
    my $file_size  = undef;;

    #initialize the random number generator
    srand($index+1);
    do {
    	my $result = {};
		# READ Operation
        if(!read_skip()) {
            $source_path = '\\\\'.$server_address.'\\'.$share_path.'\\'.$read_file_path ;
			syswrite(\*STDOUT,$source_path."\n");
            $file_size = -s $source_path.$read_file_name;
            syswrite(\*STDOUT,$file_size);
            $time = WANScaler::CIFSLibrary::copy_file($source_path,$read_file_name);    #if dest not specified copy to NUL:
            $result->{'TYPE'} = 'CIFS READ';
            if($time == 0 && $err_msg) {
                $result->{'RESULT'}= {'FAIL' => $err_msg};
            } else {
                $result->{'RESULT'} = { 'PASS' => {
                									'time' => $time,
                                                    'size' => $file_size,
                								  }
                					  };
            }
           return $result;
        } elsif (!write_skip()) {
            $source_path = ".\\" ;
            my $dest_path   = '\\\\'.$server_address.'\\'.$share_path.'\\'.$write_file_path ;
            $file_size = -s $source_path.$write_file_name;
            $time = WANScaler::CIFSLibrary::copy_file($source_path,$write_file_name,$dest_path);    #if dest not specifiedcopy to NUL:
            $result->{'TYPE'} = 'CIFS WRITE';
            if($time == 0 && $err_msg) {
                $result->{'RESULT'}= {'FAIL' => $err_msg};
            } else {
                $result->{'RESULT'} = { 'PASS' => {
                									'time' => $time,
                                                    'size' => $file_size,
                								  }
                					  };
            }

            return $result;
        } else {
            $time = browse_directory('\\\\'.$server_address.'\\'.$share_path.'\\'.$browse_dir_name);
            $result->{'TYPE'} = 'CIFS BROWSE';
            if($time == 0 && $err_msg) {
                $result->{'RESULT'}= {'FAIL' => $err_msg};
            } else {
                $result->{'RESULT'} = { 'PASS' => {
                									'time' => $time,
                								  }
                					  };
            }
 			return $result;
        }
    }
}
sub read_skip {
	return 0;	# SKIP NEVER;
	return int rand(2);
}
sub write_skip {
	return 1; # SKIP ALWAYS
	return int rand(2);
}


1;