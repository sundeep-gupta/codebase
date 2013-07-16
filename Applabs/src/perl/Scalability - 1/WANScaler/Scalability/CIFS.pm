package WANScaler::Scalability::CIFS;
use strict;
use WANScaler::Scalability::Config;
use WANScaler::CIFSLibrary;
use Data::Dumper;
our @ISA = ('WANScaler::CIFSLibrary');


#our %cifs = (
#            ip_address          => [172,32,2,42],
#            share_name 		=> 'Share',
#	    'read'		=> {
#				    src_file_path  	=> 'LargeFile45',
#				    src_files		=> '*.*',
#				    sessions 		=> 10,
#				   },
#	    'write'		=> {
#				    src_file_path 	=> 'Folder',
#				    src_files		=> '*.*',
#				    sessions 		=> 10
#				   },
#	    data_type 		=> 1 # COMPRESSIBLE -> 1 UNCOMPRESSIBLE -> 0
#            );

sub new {
  my $class = shift;
  my $options = shift;
  my $self = bless $options, $class;
  return $self;
}

sub run {
    my ($self) = @_;
    syswrite(\*STDOUT,'Running CIFS Test...');
    my $sessions = max($self->{'read'}->{'sessions'},
		       $self->{'write'}->{'sessions'});
    my @read_threads;
    my @write_threads;
    for(my $i = 0; $i < $sessions; $i++ ) {
        if ( ($self->{operation} & $CIFS_READ) == $CIFS_READ
	    and $self->{'read'}->{'sessions'} > $i) {
	    my $read_options = $self->get_read_options(($self->{'data_type'} == $UNCOMPRESSIBLE) ?
						$i : undef); # create read options from options...
	    $read_threads[$i] = threads->new(\&cifs_read, $self, $read_options);
	}
        if ( ($self->{operation} & $CIFS_WRITE) == $CIFS_WRITE
	    and $self->{'write'}->{'sessions'} > $i) {
	    my $write_options = $self->get_write_options( ($self->{'data_type'} == $UNCOMPRESSIBLE) ?
							 $i : undef);
;
	    $write_threads[$i] = threads->new(\&cifs_write, $self, $write_options);
	}
        $self->{ip_address} = add_ip_address($self->{ip_address},1);  
    }
     $self->{'read_sessions'} = [@read_threads];
     $self->{write_sessions} = [@write_threads];
}


sub get_read_options {
    my $self = shift;
    my $index = shift;
    my $read_options = {};
    $read_options->{'src_file_path'} = combine_path ( &to_ip( $self->{'ip_address'} ),
						      $self->{'share_name'},
						      $self->{'read'}->{'src_file_path'},
						      $index);
    $self->{'read'}->{src_file_path} =~ s/\\+$//;
    $read_options->{'src_files'}     = $self->{'read'}->{'src_files'};
    return $read_options;
}

sub get_write_options {
    my $self = shift;
    my $index = shift;
    my $write_options = {};
    $write_options->{'dst_file_path'} = combine_path ( &to_ip($self->{'ip_address'}),
						      $self->{'share_name'},
						      $self->{'write'}->{'dst_file_path'},
						      $index);
    $self->{'write'}->{src_file_path} =~ s/\\+$//;
    $write_options->{'src_file_path'} = $self->{'write'}->{'src_file_path'}.$index."\\";
    $write_options->{'src_files'}     = $self->{'write'}->{'src_files'};
    return $write_options;
}
sub to_ip {
  my $ip_addr = shift;
  return (join(".",@$ip_addr));
}

sub combine_path {
  my($ip,$share,$path,$index) = @_;
  $share =~ s/^\\+//; $share =~ s/\\+$//;
  $path =~  s/^\\+//; $path =~  s/\\+$//;
  return '\\\\'.$ip.'\\'.$share.'\\'.$path.$index;
  
}

sub max {
    my $max = shift;
    foreach my $element (@_) {
	$max = (defined $element and defined $max and $element > $max) ? $element : $max;
    }
    return $max;
}

sub add_ip_address {
    my ($ip_addr,$increment) = @_;
    my @ip_addr = @$ip_addr;
    for (my $i=0;$i<$increment;$i++) {
	(++$ip_addr[3] > $MAX_OCTET_VALUE) and
	( $ip_addr[3] = $MIN_OCTET_VALUE and ++$ip_addr[2] > $MAX_OCTET_VALUE) and
	( $ip_addr[2] = $MIN_OCTET_VALUE and ++$ip_addr[1] > $MAX_OCTET_VALUE) and
	( $ip_addr[1] = $MIN_OCTET_VALUE and ++$ip_addr[0] > $MAX_OCTET_VALUE);
    }
    return \@ip_addr;
}

sub get_results {
    my $self = shift;
    my @results = ();
    if($self->{read_sessions}) {
	foreach my $thread (@{$self->{'read_sessions'}}) {
		my $ret = $thread->join();
		$results[$#results+1]  = $ret;
	}
    }
    if($self->{write_sessions}) {
	foreach my $thread (@{$self->{'write_sessions'}}) {
		my $ret = $thread->join();
		$results[$#results+1]  = $ret;
	}
    }
    return \@results;
}

sub cifs_write {
    my $self = shift ; #package
    my $params = shift;
    my $result = {};
    if (ref ($params->{src_files}) eq 'ARRAY') {
      	foreach my $file (@{$params->{'src_files'}}) {
	    my $file_size = -s $params->{'src_file_path'}.$file;
            my $time = copy_file($params->{'src_file_path'},
						      $file,
						      $params->{'dst_file_path'},
						      $file);
            if($time == 0 && $err_msg) {
                $result->{$file}= {'FAIL' => $err_msg};
            } else {
                $result->{$file} = { 'PASS' => {
                				  'time' => $time,
                                                  'size' => $file_size,
                			        }
                		    };
            }
	}
    } elsif ($params->{src_files} and $params->{src_files} eq 'ALL') {

	$result = copy_directory($params->{'src_file_path'},
					       $params->{'dst_file_path'});
    }
    return $result;
}

sub cifs_read {
    my $self = shift ; 
    my $params = shift;
    my $result = {};
    if (ref ($params->{src_files}) eq 'ARRAY') {
	foreach my $file (@{$params->{'src_files'}}) {
	    my $file_size = -s $params->{'src_file_path'}.$file;
	    
            my $time = copy_file($params->{'src_file_path'},
						      $file
						      );
            if($time == 0 && $err_msg) {
                $result->{$file}= {'FAIL' => $err_msg};
            } else {
                $result->{$file} = { 'PASS' => {
                				  'time' => $time,
                                                  'size' => $file_size,
                			        }
                		    };
            }
	}
    } elsif ($params->{src_files} and $params->{src_files} eq 'ALL') {
	$result = copy_directory($params->{'src_file_path'});
    }
    return $result;
}
1;