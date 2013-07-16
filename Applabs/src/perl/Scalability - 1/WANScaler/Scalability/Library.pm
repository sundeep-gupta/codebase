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
use WANScaler::IPerfLibrary;
use WANScaler::ZPerfLibrary;
use WANScaler::XmlRpc;
use WANScaler::XmlRpc::System;
use WANScaler::Scalability::CIFS;
use WANScaler::Scalability::Config; # USES ONLY CONSTANTS TRUE OR FALSE and RECV,SEND,SEND_RECV;


# Use random number generator to get next operation to do...
#

use constant LOCALHOST 		=> 'localhost';
use constant XMLRPC_PORT 	=> 2050;
use constant WS_SERVICE_NAME 	=> 'wanscalerclient';
Readonly my  $SLEEP_BEFORE_STAT => 10;
Readonly my  $SAMPLE_INSTANCES 	=> 60;

############################# CIFS RELATED FUNCTIONS ###########################

sub start_cifs_sessions {
    my ($self, $options) = @_;
    my $cifs_connection = WANScaler::Scalability::CIFS->new($options);
    $cifs_connection->run() if $cifs_connection;
    my $results = $cifs_connection->get_results();
    return $results;
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
    my $method = ($options->{'direction'} == SEND) ? 'iperf_send':'iperf_recv';
    my $result = WANScaler::IPerfLibrary->$method($options);
    return $result;
}
###################### ZPERF RElATED METHODS ###################################
sub start_zperf_sessions  {
	my ($self,$options,$seed) = @_;
    my $method = ($options->{'direction'} == RECV) ? 'zperf_recv':'zperf_send';
    my $result = WANScaler::ZPerfLibrary->$method($options);
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
}

sub reset_wanscaler_stats {
	my $wanscaler = WANScaler::XmlRpc->new("http://".LOCALHOST.":".XMLRPC_PORT."/RPC2");
	return    ($wanscaler) ? $wanscaler->reset_perf_counters() : undef;
}

sub get_static_wanscaler_stats {
	my ($self,$parameters) = @_;
    my @params = @$parameters;
	my $results=  {};
    my $wanscaler = WANScaler::XmlRpc::System->new("http://".LOCALHOST.":".XMLRPC_PORT."/RPC2");
	foreach my $param (@params) {
    	if($param eq 'CompressionRatioSend') {
	       	syswrite(\*STDOUT,"Compression Send\n");
	        $results->{$param} =   ($wanscaler) ? $wanscaler->get_send_compression_ratio() : undef;
    	}
        if ($param eq 'CompressionRatioRecv') {
        	syswrite(\*STDOUT,"Compression Recieve\n");
        	$results->{$param} =   ($wanscaler) ? $wanscaler->get_recv_compression_ratio() :  $results->{$param};
    	}

    }
    print Dumper($results);
    return $results;
}
################### GET WANSCALER CLIENT PARAMETERS ############################
sub get_wanscaler_stats {
	my ($self,$options)   = @_;

	my $cpu_thread = threads->create(\&__get_cpu_stat, $options);
    my $connection_thread = threads->create(\&__get_connection_stat, $options);

    my $cpu_result 			= $cpu_thread->join();
    my $connection_result 	= $connection_thread->join();

    print Dumper( [$cpu_result,$connection_result]);

    print " hi sirisa ";

    return [$cpu_result,$connection_result];
}

sub __get_cpu_stat {
	my $options = shift;
	sleep($SLEEP_BEFORE_STAT);
    my $wanscaler		  = WANScaler::XmlRpc::System->new("http://".LOCALHOST.':'.XMLRPC_PORT."/RPC2");
    my $instances = undef;
    my $total = 0;
    my $i;
    my $cpu;
    for($i = 0;$i< $options->{'instances'};$i++) {
		$cpu   	   	= $wanscaler->get_cpu_utilization() if ($options->{'CPU'} == 1);
        $instances 	= $instances.($instances?', '.$cpu:$cpu);
        $total 		= $total+$cpu;
        sleep(1);
    }
    syswrite(\*STDOUT,Dumper($cpu));
    #syswrite(\*STDOUT,$iperf_cmd);
    return {'CPU'=>{'Instances' => $instances,
    				 'Average' 	=> sprintf "%.3f", ($total/$options->{'instances'})
    				}

           };
}


sub __get_connection_stat {
	my $options = shift;
    return undef;

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
    unlink $options->{'filename'};
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
