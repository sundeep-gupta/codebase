#!/usr/bin/perl
package WANScaler::Scalability::Library;
use strict;
use warnings;
use threads;
use Data::Dumper;
use Win32::Service;
use Win32::ShutDown;
use Readonly;

use WANScaler::CIFSLibrary;
use WANScaler::FTPLibrary;
use WANScaler::MSILibrary;
use WANScaler::HTTPLibrary;
use WANScaler::XmlRpc;
use WANScaler::XmlRpc::System;
use WANScaler::Scalability::Config; # USES ONLY CONSTANTS TRUE OR FALSE

# Use random number generator to get next operation to do...
#
use constant MAX_OCTET_VALUE => 240;
use constant MIN_OCTET_VALUE => 5;
use constant LOCALHOST => 'localhost';
use constant XMLRPC_PORT => 2050;
use constant WS_SERVICE_NAME => 'wanscalerclient';
Readonly my  $SLEEP_BEFORE_STAT => 2;
Readonly my  $SAMPLE_INSTANCES => 60;

############################# CIFS RELATED FUNCTIONS ###########################

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
    my $share_path 	   		= $session_options->{'share_name'}; 		 # TODO
    my $index 				= $session_options->{'index'};

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
#            print Dumper($result);
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

############################### FTP RELATED FUNCTIONS #########################

sub start_ftp_sessions {
	shift;
	my ($options) = @_ ;
    	my @ftp_threads;
        my $i;
    	for($i = 0;$i < $options->{sessions}; $i++ ) {
	        $ftp_threads[$i] = threads->new(\&ftp_session, $options,$i);
	    }
	    $i = 0;
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
	my $time = undef;
	my $result = {};
	if(!ftp_get_skip()) {

		$time = 0;
       $time = $ftp->get($options->{'get_file_name'},'NUL');
       $result->{'TYPE'} = 'FTP GET';
        if($time == 0 && $ftp_err) {
            $result->{'RESULT'}= {'FAIL'  => $ftp_err};
        } else {
            $result->{'RESULT'} = {'PASS' => {
                                                'time' => $time,
                                                'size' => $file_size,
                                              }
                                  };
        }

    } elsif (!ftp_put_skip()) {
	    $time = 0;
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
	    $time = 0;
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


############################### HTTP RELATED METHODS ###########################

sub start_http_sessions {
	my ($self,$options) = @_;
    my @http_threads;
    my $i ;
    for($i = 0;$i < $options->{'sessions'};$i++) {
	      my $url = 'http://'.$options->{'server_address'};
	      $url.=':'.$options->{'server_port'} if $options->{'server_port'};
	      $url.='/'.$options->{'uri'};
          $http_threads[$i] = threads->new(\&http_session,$url);
    }
    my @results;
 	$i = 0;
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


####################### IPERF RELATED METHODS ##################################
sub start_iperf_sessions  {
	my ($self,$options,$seed) = @_;
    my $iperf_cmd = 'iperf -c '.$options->{'server'};
    $iperf_cmd = $iperf_cmd.' -f m ' ;
    if( $options->{'time'}) {
	    $iperf_cmd = $iperf_cmd.' -t '.$options->{'time'};
    } elsif ($options->{'size'}) {
	    $iperf_cmd = $iperf_cmd.' -n '.$options->{'size'} ;
    }
    $iperf_cmd = $iperf_cmd.' -X '.$seed if ( $options->{'random'} == 1 and $seed);
    $iperf_cmd = $iperf_cmd.' -P '.$options->{'sessions'} if $options->{'sessions'};
#syswrite(\*STDOUT,Dumper($options));
#syswrite(\*STDOUT,$seed);
#syswrite(\*STDOUT, $iperf_cmd);
    my $result = `$iperf_cmd 2>err.txt`;
    if (-e "err.txt") {
    	open(FH, "err.txt");
        my @err = <FH>;
        close(FH);
        $result = $result. join('',@err);
        unlink "err.txt";
    }
    return $result;
}

######################## SET WANSCALER CLIENT ##################################

sub set_wanscaler_client {
	my ($self,$options) = @_;
	my $wanscaler = WANScaler::XmlRpc->new("http://".LOCALHOST.':'.XMLRPC_PORT."/RPC2");
	if ($options->{PARAMETER}) {
		my $parameters = $options->{PARAMETER};
		foreach my $param (keys %$parameters) {
			syswrite(\*STDOUT, $param."\n");
			$wanscaler->set_parameter($param, $parameters->{$param});
		}
	}
#	if($options->{restart_service} == 1) {
#		stop_wanscaler_service();
#		start_wanscaler_service();
#	}
}

################### GET WANSCALER CLIENT PARAMETERS ############################
sub get_wanscaler_stats {
	my ($self,$options)   = @_;
	sleep($SLEEP_BEFORE_STAT);
	my $wanscaler		  = WANScaler::XmlRpc::System->new("http://".LOCALHOST.':'.XMLRPC_PORT."/RPC2");
    my $instances = undef;
    my $total = 0;
    my $i;
    my $cpu;
    for($i = 0;$i< $SAMPLE_INSTANCES;$i++) {
		$cpu				  = $wanscaler->get_cpu_utilization() if ($options->{'CPU'} == 1);
        $instances = $instances.($instances?','.$cpu:$cpu);
        $total = $total+$cpu;
        sleep(1);
    }


#	my $compression_ratio = $wanscaler->get_compression_ratio if ($options->{'COMPRESSION_RATIO'} == TRUE);
syswrite(\*STDOUT,Dumper($cpu));
    return {'CPU'=>{'Instances' => $instances,
    				 'Average' => $total/$SAMPLE_INSTANCES
    				}
           };
}

####################### INSTALL THE WANSCALER CLIENT ###########################
sub install_wanscaler_client  {
	my ($self,$options) = @_;
    my $ftp = WANScaler::FTPLibrary->new(    $options->{'server'});
    $ftp->login;
    $ftp->binary;
    $ftp->passive;
	$ftp->chdir($options->{'path'});
    $options->{'filename'} =~ s/type/$options->{'type'}/;
    $options->{'filename'} =~ s/build/$options->{'build'}/;
    syswrite (\*STDOUT, "Getting file: ".$options->{'filename'});
    my $time = $ftp->get($options->{'filename'});
    return 'Install Failed: Coulnd not download build' unless $time;
	syswrite(\*STDOUT,'Starting Installation');
    my $res = WANScaler::MSILibrary->install($options->{'filename'});
    syswrite(\*STDOUT,'Installation done');
    return $res;
#	return ($res)? 'WANScaler Client installed successfully. Waiting for reboot'
#    			 : 'WANScaler Client installation failed';
}
####################### METHODS TO START & STOP SERVICE ########################
############################# MIGHT FAIL  :-D ##################################

sub start_wanscaler_service {
	my $status = {};
    my @response = `net start wanscalerclient`;
    return \@response;
}

sub stop_wanscaler_service {
	my $status = {};
    my @response = `net stop wanscalerclient`;
	return \@response;
}

sub restart {
	syswrite(\*STDOUT, 'Got instruction for Restart');
	if(fork == 0) {
		syswrite(\*STDOUT, 'Restarting...');
        Win32::ShutDown::ForceReStart();
    } else {
	    return 'Done';
    }
}
#################### USED TO TEST IF SERVER IS OK ##############################
sub test {
	print 'Hi';
	return 'test';
}

1;