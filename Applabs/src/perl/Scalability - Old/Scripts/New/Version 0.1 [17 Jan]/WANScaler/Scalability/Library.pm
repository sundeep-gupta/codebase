#!/usr/bin/perl
package WANScaler::Scalability::Library;
use strict;
#use warnings;
use threads;
use Data::Dumper;
use WANScaler::CIFSLibrary;
use WANScaler::FTPLibrary;
use WANScaler::HTTPLibrary;
# Use random number generator to get next operation to do...
#
use constant MAX_OCTET_VALUE => 240;
use constant MIN_OCTET_VALUE => 5;

sub start_cifs_sessions {
	my ($self, $options) = @_;
    my @start_ip = (@{$options->{ip_address}->{network_address}}, @{$options->{ip_address}->{host_address}});
	my @cifs_threads;

	for(my $i = 0;$i < $options->{sessions}; $i++ ) {

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
	my $i = 0;
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
    my $share_path 	   		= $session_options->{'share_name'}; 		 # TODO
    my $index 				= $session_options->{'index'};

    my $avg_pause_time = undef;

#	local $log_prefix = $server_address."-".$share_path."-";
	my $time = undef;

    #initialize the random number generator
    srand($index+1);
    do {
    	my $result = {};
		# READ Operation
        if(!read_skip()) {
            my $source_path = '\\\\'.$server_address.'\\'.$share_path.'\\'.$read_file_path ;
			syswrite(\*STDOUT,$source_path."\n");
            my $file_size = -s $source_path.$read_file_name;
            syswrite(\*STDOUT,$file_size);
            my $time = WANScaler::CIFSLibrary::copy_file($source_path,$read_file_name);    #if dest not specified copy to NUL:
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
            print Dumper($result);
           return $result;
        } elsif (!write_skip()) {
            my $source_path = ".\\" ;
            my $dest_path   = '\\\\'.$server_address.'\\'.$share_path.'\\'.$write_file_path ;
            my $file_size = -s $source_path.$write_file_name;
            my $time = WANScaler::CIFSLibrary::copy_file($source_path,$write_file_name,$dest_path);    #if dest not specifiedcopy to NUL:
            $result->{'TYPE'} => 'CIFS WRITE';
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
            $result->{'TYPE'} => 'CIFS BROWSE';
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

sub start_ftp_sessions {
	shift;
	my ($options) = @_ ;
    	my @ftp_threads;
    	for(my $i = 0;$i < $options->{sessions}; $i++ ) {
	        $ftp_threads[$i] = threads->new(\&ftp_session, $options,$i);
	    }
	    my $i = 0;
	    my @results;
	    foreach my $thread (@ftp_threads) {
	        my $ret = $thread->join();
	        $results[$i]  = $ret;
	        $i++;

	    }
	    return \@results;
}

sub ftp_session {
    my $options = shift;
    my $index = shift;
    srand($index);
	open(FH,'>TEst.txt');
	close(FH);
    my $ftp = WANScaler::FTPLibrary->new($options->{'server'});
    $ftp->login($options->{'username'},$options->{'password'});
	$ftp->chdir($options->{'src_path'});
    my $file_size = $ftp->size($options->{get_file_name});

	my $result = {};
	if(!ftp_get_skip()) {

	   my $time = 0;
       $time = $ftp->get($options->{'get_file_name'},'NUL');
       $result->{'TYPE'} = 'FTP GET';
        if($time == 0 && $ftp_err) {
            $result->{'RESULT'}= {'FAIL' => $ftp_err};
        } else {
            $result->{'RESULT'} = { 'PASS' => {
                                                'time' => $time,
                                                'size' => $file_size,
                                              }
                                  };
        }

    } elsif (!ftp_put_skip()) {
	    my $time = 0;
	    $time = $ftp->put($options->{'put_file_name'});
	    $result->{'TYPE'} = 'FTP PUT';
        if($time == 0 && $ftp_err) {
            $result->{'RESULT'}= {'FAIL' => $ftp_err};
        } else {
            $result->{'RESULT'} = { 'PASS' => {
                                                'time' => $time,
                                                'size' => $file_size,
                                              }
                                  };
        }
    } else {
	    my $time = 0;
	    $time = $ftp->ls();
	    $result->{'TYPE'} = 'FTP BROWSE';
        if($time == 0 && $ftp_err) {
            $result->{'RESULT'}= {'FAIL' => $ftp_err};
        } else {
            $result->{'RESULT'} = { 'PASS' => {
                                                'time' => $time,
                                                'size' => $file_size,
                                              }
                                  };
        }
    }
    $ftp->close();
    return $result;
}

sub ftp_get_skip {
	return 0;	# DEFAULTING TO NO SKIP
	return int rand(2);
}
sub ftp_put_skip {
	return int rand(2);
}

sub start_http_sessions {
	my ($self,$options) = @_;
    my @http_threads;
    for(my $i = 0;$i < $options->{'sessions'};$i++) {
	      my $url = 'http://'.$options->{'server_address'};
	      $url.=':'.$options->{'server_port'} if $options->{'server_port'};
	      $url.='/'.$options->{'uri'};
          $http_threads[$i] = threads->new(\&http_session,$url);
    }
    my @results;
    my $i = 0;
    foreach my $thread (@http_threads) {
        my $ret = $thread->join();
        $results[$i]  = $ret;
        $i++;
    }
    return \@results
}
sub http_session {
	my $url = shift;
	my $ret =  WANScaler::HTTPLibrary->get($url);
    my $result = {'TYPE' => 'HTTP GET'};
    if( !($result) or $http_err) {
        $result->{'RESULT'}= {'FAIL' => $http_err};
    } else {
        $result->{'RESULT'} = { 'PASS' => $ret};
    }
    return $result;
}
sub start_iperf_sessions  {
	my ($self,$options) = @_;
    my $iperf_cmd = 'iperf -c '.$options->{'server'};
    my $iperf_cmd = $iperf_cmd.' -f M ' ;
    my $iperf_cmd = $iperf_cmd.' -t '.$options->{'time'} if $options->{'time'};
    my $iperf_cmd = $iperf_cmd.' -P '.$options->{'sessions'} if $options->{'sessions'};
    my $result = `$iperf_cmd 2>err.txt`;
    if (-e "err.txt") {
    	open(FH, "err.txt");
        my @err = <FH>;
        close(FH);
        print join('',@err);
        unlink "err.txt";
    }
print $iperf_cmd;
print Dumper($result);
    return $result;

}
sub test {
	print 'Hi';
	return 'test';
}
1;

