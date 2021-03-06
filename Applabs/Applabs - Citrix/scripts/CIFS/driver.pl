#!/usr/bin/perl -w
#!/usr/bin/perl
# ADDED WANSCALER LOGGING... Have to check...
#
# foreach if used in single liner, then my <var> does not work... WHY?
# TODO: SEPARATE DEBUG LOG STATEMENTS :-)

use strict;
use warnings;
use threads;
use Data::Dumper;
use XMLRPC::Lite;
#use Readonly;

# WANScaler Library
use WANScaler::Scalability::Config;
use WANScaler::XmlRpc::System;
use WANScaler::Utils::Log;

my $MAX_RPC_TRY = 3;


####################### VARIABLE DECALARATION ##################################
my (@cifs_threads, @ftp_threads, @http_threads,   $client_ip,@iperf_threads,
	@zperf_threads, @threads_table, @ws_client_threads, @ws_install_threads, $i);
################################################################################

########################### Create LOG File ####################################
my $time = WANScaler::Utils::Log::get_time; $time =~ s/://g;
mkdir($LOG_DIR) unless (-e $LOG_DIR);
#syswrite(\*STDOUT, $LOG_DIR." does not exist.\n"),exit(1) unless (-e $LOG_DIR);
my $log_file_name = $LOG_DIR. $time.' - Scalability.log';
my $log = WANScaler::Utils::Log->new($log_file_name);
################################################################################

#initialize the random number generator.
srand($SEED_INITIALIZER);

# read the list of machines on which test need to be done
my @client_ips = read_client_list($CLIENT_FILE_NAME);
#print 'Trying to call...';


##################### IF REBOOT IS INDICATED ##################################
if($REBOOT_ALL_CLIENTS == TRUE) {
    foreach $client_ip (@client_ips) {
	restart($client_ip);
    }
}

##################### INSTALL WANSCALER CLIENT #################################
if($INSTALL_WANSCALER_CLIENT == TRUE) {
    $i = 0;
    foreach $client_ip (@client_ips) {
	$ws_install_threads[$i] = threads->new(\&install_wanscaler_client,
					    $client_ip,
					   \%wanscaler_install);
	$log->log_info('Installation started for '. $client_ip);
    }
    # WAIT for Threads to return...
    foreach my $ws_thread (@ws_install_threads) {
    	my $response = $ws_thread->join;
    }
    exit(1);
}

###################  CONFIGURE WANSCALER  ######################################

# Check if WANScaler need to be configured...
if($CONFIGURE_WANSCALER == TRUE) {
	# Configure each WANScaler Client and Exit
	foreach my $ip (@client_ips) {
	    set_wanscaler_client($ip, \%wanscaler_client) ;
	}
	exit(1);
}
########################### START TESTS HERE ###################################

$log->log_info('Test started...');

# Start the test here
if($RESET_PERF_COUNTERS == TRUE) {
	# Configure each WANScaler Client and Exit
	foreach my $ip (@client_ips) {
	    my $server_response = do_rpc_call('WANScaler.Scalability.Library.reset_wanscaler_stats',$ip);
   }
}

$i = 0;
my $cifs_index = 0;
foreach $client_ip (@client_ips) {
    $log->log_info('Starting the test for '.$client_ip);
    my $cifs = \%cifs;
    if(($TEST & $CIFS_TEST) == $CIFS_TEST) {
    	my $max_sessions =  max($cifs->{'read'}->{'sessions'},
			        $cifs->{'write'}->{'sessions'});
        # Changed on 7821 -- START
    	if ($cifs->{'data_type'} == $UNCOMPRESSIBLE) {
        	$cifs->{share_start} = $cifs_index*$max_session +
                			 $cifs->{share_start};
        }
	# Changed on 7821 -- END

#	print 'CIFS TEST';
	$cifs_threads[$i] = threads->new(\&do_cifs, $client_ip, \%cifs);
        $log->log_info('CIFS test initiated for '. $client_ip);
        $threads_table[$cifs_threads[$i]->tid] = {
						    type => 'CIFS',
						    client_ip => $client_ip,
						  };
	$cifs->{'ip_address'} = add_ip_address($cifs->{'ip_address'},
					      $max # Changed on 7821
					      );
	$cifs_index++;
    }

    if(($TEST & $FTP_TEST) == $FTP_TEST) {
	$ftp_threads[$i] = threads->new(\&do_ftp, $client_ip, \%ftp);
        $log->log_info('FTP test initiated for '. $client_ip);
        $threads_table[$ftp_threads[$i]->tid] = {
						type => 'FTP',
						client_ip => $client_ip
                                                };
    }

    if(($TEST & $HTTP_TEST) == $HTTP_TEST) {
	$http_threads[$i] = threads->new(\&do_http, $client_ip, \%http);
        $log->log_info('HTTP test initiated for '. $client_ip);
        $threads_table[$http_threads[$i]->tid] = {
						  type => 'HTTP',
						  client_ip => $client_ip
                                                 };
    }
    if(($TEST & $IPERF_TEST) == $IPERF_TEST) {
    	my $seed = undef;
	my %iperf_temp = (
			 'time' 	=> $iperf{'time'},
                         'size' 	=> $iperf{'size'},
                         'random' 	=> $iperf{'random'},
                         'direction'	=> $iperf{'direction'},
                         'sessions'	=> $iperf{'sessions'}
                         );
        $iperf_temp{'server'} = @{$iperf{'servers'}}[ int ($i / (scalar @{$iperf{'ports'} }))];
	$iperf_temp{'port'} = @{$iperf{'ports'}}[$i % (scalar @{$iperf{'ports'}})];

    	if($iperf{'random'} == 1) {
            do {
            	$seed = rand;
				$seed = int ( $seed * $MAX_RANDOM_VALUE);
    	        $log->log_info("Seed value used is : $seed");
                sleep(3);
            } while ($seed <= 0);

        }

	$iperf_threads[$i] = threads->new(\&do_iperf, $client_ip, \%iperf_temp, $seed);
        $log->log_info('IPERF test initiated for '. $client_ip);
        $threads_table[$iperf_threads[$i]->tid] = {
						    type => 'IPERF',
						    client_ip => $client_ip
						   };
    }

    if(($TEST & $ZPERF_TEST) == $ZPERF_TEST) {
    	my $seed = undef;
	my %zperf_temp = (
			 'time' 	=> $zperf{'time'},
                         'size' 	=> $zperf{'size'},
                         'random' 	=> $zperf{'random'},
                         'direction'	=> $zperf{'direction'},
                         'sessions'	=> $zperf{'sessions'}
                         );
        $zperf_temp{'server'} = @{$zperf{'servers'}}[ int ($i / (scalar @{$zperf{'ports'} }))];
	$zperf_temp{'port'} = @{$zperf{'ports'}}[$i % (scalar @{$zperf{'ports'}})];

    	if($zperf{'random'} == 1) {
            do {
            	$seed = rand;
		$seed = int ( $seed * $MAX_RANDOM_VALUE);
    	        $log->log_info("Seed value used is : $seed");
                sleep(3);
            } while ($seed <= 0);
        }
	$zperf_threads[$i] = threads->new(\&do_zperf, $client_ip, \%zperf_temp, $seed);
        $log->log_info('ZPERF test initiated for '. $client_ip);
        $threads_table[$zperf_threads[$i]->tid] = { type => 'ZPERF',
						    client_ip => $client_ip
			                           };
    }
    #delay between creating threads as perl might fail to create
    # multiple threads on go [it failed many times for me so I keep this].
    sleep(1);
    $i++;
}


#################### READ WS Metrics HERE #####################
if ($CAPTURE_CLIENT_METRICS == TRUE) {
       	$i = 0;
	foreach $client_ip (@client_ips) {
		$ws_client_threads[$i] = threads->new(\&do_ws_client_stat,$client_ip,\%ws_stat);
	    $log->log_info("Started thread for reading stats from $client_ip");
    	$threads_table[$ws_client_threads[$i]->tid] = { type => 'Client',	'client_ip' => $client_ip
				                                      };
		$i++;
	}
}

$i = 0;
my $val =0;
my $sum = 0;
syswrite(\*STDOUT,'Waiting for tests to complete...');
wait_to_join_threads(\@threads_table,
		    \@ftp_threads,
                     \@cifs_threads,
                     \@http_threads,
                     \@ws_client_threads);
write_results($log,\@threads_table);
syswrite(\*STDOUT,"\nCalculating Throughput...\n");
#calculate_summary($log,\@threads_table); #TODO ## IN PROGRESS [2nd April 07]

if($CAPTURE_CLIENT_METRICS == TRUE) {
	# Configure each WANScaler Client and Exit
	foreach my $ip (@client_ips) {
    	my $wanscaler = WANScaler::XmlRpc::System->new("http://$ip:2050/");
        my $result = {'IP' => $ip};
        if($wanscaler) {
        	$result->{'CompressionRatioSend'} = $wanscaler->get_recv_compression_ratio();
            $result->{'CompressionRatioRecv'} = $wanscaler->get_send_compression_ratio();
        }
	#    my $server_response = do_rpc_call('WANScaler.Scalability.Library.get_static_wanscaler_stats',$ip,\@static_ws_stat);
		$log->log_result(Dumper($result));
        print Dumper($result);
   }
}
if(($TEST & $ZPERF_TEST) == $ZPERF_TEST) {
    syswrite(\*STDOUT,"\nCalculating Throughput...\n");
    calculate_summary_Zperf($log, \@threads_table); #TODO ## IN PROGRESS [2nd April 07]
} elsif(($TEST & $IPERF_TEST) == $IPERF_TEST) {
    syswrite(\*STDOUT,"\nCalculating Throughput...\n");
    calculate_summary_Iperf($log, \@threads_table); #TODO ## IN PROGRESS [2nd April 07]
}

if(($TEST & $CIFS_TEST) == $CIFS_TEST) {
    syswrite(\*STDOUT,"\nCalculating Throughput...\n");
    calculate_summary_Cifs($log, \@threads_table); #TODO ## IN PROGRESS [2nd April 07]
}



# ---------------------------------------------------------------------------- #
#                     METHODS THAT START THE TESTS                             #
# ---------------------------------------------------------------------------- #

sub max {
    my $max = shift;
    foreach my $element (@_) {
	$max = (defined $element and defined $max and $element > $max) ? $element : $max;
    }
    return $max;
}

sub add_ip_address {
    my ($ip_addr,$increment) = @_;
    #print $ip_addr,$increment,"Hi";
    my @ip_addr = @$ip_addr;
    for (my $i=0;$i<$increment;$i++) {
	my $tmp =  ( (++$ip_addr[3] > $MAX_OCTET_VALUE) and
	( $ip_addr[3] = $MIN_OCTET_VALUE and ++$ip_addr[2] > $MAX_OCTET_VALUE) and
	( $ip_addr[2] = $MIN_OCTET_VALUE and ++$ip_addr[1] > $MAX_OCTET_VALUE) and
	( $ip_addr[1] = $MIN_OCTET_VALUE and ++$ip_addr[0] > $MAX_OCTET_VALUE)) ;
    }
    return \@ip_addr;
}
######################## STARTER FOR FTP TEST ################################
sub do_rpc_call {
    my $method = shift;
    my $server_ip = shift;
    my $rpc = XMLRPC::Lite->proxy('http://'.$server_ip.':'.$CLIENT_LISTEN_PORT.'/',timeout=>$MAX_RPC_TIMEOUT)
 						  -> on_fault(sub {
                                            $log->log_error("Couldn't connect to http://$server_ip:$CLIENT_LISTEN_PORT/\n");
                                            threads->exit() if threads->can('exit');
									   });
    my $count = 0;
    my $result;
    my $response = undef;

    while ($response or $count < $MAX_RPC_TRY){
#	    syswrite(\*STDOUT,"Calling ".$method. "\n"),
        $response = $rpc->call($method,@_) if $rpc;
        last if $response;
        $count++;
        $log->log_error("Method call, $method on $server_ip failed ($count)");
    }
    return ($response?$response->result: undef);
}
sub do_ftp {
    my ($server_ip, $ftp_options) = @_;
    my $server_response = do_rpc_call('WANScaler.Scalability.Library.start_ftp_sessions',
    					    		  $server_ip,
                                      $ftp_options);
    $server_response = format_results($server_response);
	return $server_response;

}

######################## STARTER FOR CIFS TEST ################################
sub do_cifs {
    my ($server_ip, $cifs_options, $index) = @_;
    my $server_response = do_rpc_call('WANScaler.Scalability.Library.start_cifs_sessions',
 				    $server_ip,
                                    $cifs_options
				    );
    #$server_response = format_results($server_response);
	return $server_response;
}

######################## STARTER FOR HTTP TEST ################################
sub do_http {
	my ($server_ip,$http_options) = @_;
    my $server_response = do_rpc_call('WANScaler.Scalability.Library.start_http_sessions',
    					    		  $server_ip,
                                      $http_options);
    $server_response = format_results($server_response);
	return $server_response;
}

######################## STARTER FOR IPERF TEST ################################
sub do_iperf {
	my ($server_ip,$iperf_options,$seed) = @_;
    my $server_response = do_rpc_call('WANScaler.Scalability.Library.start_iperf_sessions',
    					    		  $server_ip,
                                      $iperf_options,
                                      $seed);


#my $formatted = format_iperf_result($server_response);
    $server_response->{'IP'} = $server_ip;
    syswrite(\*STDOUT,Dumper( $server_response));
	return $server_response;

}
######################## STARTER FOR IPERF TEST ################################
sub do_zperf {
	my ($server_ip,$zperf_options,$seed) = @_;
    my $server_response = do_rpc_call('WANScaler.Scalability.Library.start_zperf_sessions',
    					    		  $server_ip,
                                      $zperf_options,
                                      $seed);


  #	my $formatted = format_zperf_result($server_response);
    $server_response->{'IP'} = $server_ip;
    syswrite(\*STDOUT,Dumper( $server_response));
	return $server_response;

}

################## GET THE WANSCALER CLIENT STATISTICS #########################
sub do_ws_client_stat {
	my ($server_ip, $wanscaler_stat) = @_;
    my $server_response = do_rpc_call('WANScaler.Scalability.Library.get_wanscaler_stats',
    					    		  $server_ip,
                                      $wanscaler_stat);
   # @{$server_response}[ scalar @{$server_response}] = {'IP' => $server_ip};
    syswrite(\*STDOUT,Dumper( $server_response));

    return $server_response;
}

################### SET THE WANSCALER PARAMETERS AT CIENT MACHINE ##############
sub set_wanscaler_client {
	my $client_ip = shift;
	my $options = shift;
    my $server_response = do_rpc_call('WANScaler.Scalability.Library.set_wanscaler_client',
    					    		  $client_ip,
                                      $options);
	return $server_response;
}
########################## INSTALL WANSCALER CLIENT ############################
sub install_wanscaler_client {
	my $client_ip = shift;
	my $options  = shift;
    my $server_response = do_rpc_call('WANScaler.Scalability.Library.install_wanscaler_client',
    					    		  $client_ip,
                                      $options);
    my $result = format_install_result($server_response);

    $log->log_info('Installation '.(($result)?'Successful':'Failed'));
    return unless $server_response;
    syswrite(\*STDOUT,'Now Rebooting...');
	$server_response = restart($client_ip);
    return $server_response;
}
sub restart {
	my $client_ip = shift;
    my $server_response = do_rpc_call('WANScaler.Scalability.Library.restart',
    					    		  $client_ip);
    return $server_response;

}

sub stop_wanscaler_service {
   	my $client_ip = shift;
    my $server_response = do_rpc_call('WANScaler.Scalability.Library.stop_wanscaler_service',
    					    		  $client_ip);
    return $server_response;

}

sub start_wanscaler_service {
   	my $client_ip = shift;
    my $server_response = do_rpc_call('WANScaler.Scalability.Library.start_wanscaler_service',
    					    		  $client_ip);
    return $server_response;

}

####################################################################################################################

# ---------------------------------------------------------------------------- #
#                      RESULTS RELATED METHOD [LOGGING}                        #
# ---------------------------------------------------------------------------- #

# returns undef if installation failed
sub format_install_result {
	my $result = shift;
    #TODO : Code that decides if the result is pass or fail
    return $result;
}
sub format_results {
	my($result,$ip) = @_;
    my $instances = undef;
    my $total = 0;
	foreach my $inst (@$result) {
    	if($inst->{'RESULT'}->{'PASS'}) {
        	my $res = $inst->{'RESULT'}->{'PASS'};
			my $throughput = ($res->{'time'} > 0) ? $res->{'size'} / ( $res->{'time'} * $SCALE * $BYTE_TO_BIT) : 0;
            $total = $total+ $throughput;
        	$instances = $instances. ( $instances ? ','. sprintf("%.3f", $throughput) : sprintf("%.3f", $throughput) );
        }
    }
    my $ret = { 'Total' 	=> $total,
    			'Instance'  => $instances,
                'IP'		=> $ip
                };
    return $ret;
}



sub write_results {
	my ($log, $test_table) = @_;
	foreach my $test (@$test_table) {
		next unless $test;
		unless ( exists($test->{'RESULT'})) {
			$log->log_result('FAIL - No result');
			next;
		}
		$log->log_result(Dumper($test->{'RESULT'})); # TODO
	}
}
sub calculate_summary_Iperf {
	my $log = shift;

	my $threads_table = shift;
    my $iperf_sum = 0;


	foreach my $test (@$threads_table) {
		next if ( $test->{'type'} and ($test->{'type'} ne 'IPERF'));
        $iperf_sum = $iperf_sum + $test->{'RESULT'}->{'Total'} if ($test->{'RESULT'}
        													   and $test->{'RESULT'}->{'Total'});

     #   print $iperf_sum;
    }
    $log->log_result('Throughput of Iperf is : '.$iperf_sum);
   # syswrite(\*STDOUT,"\nCalculating Throughput...\n");
    syswrite(\*STDOUT,'Throughput of Iperf is : '.$iperf_sum);

	return undef;
}


sub calculate_summary_Zperf {
	my $log = shift;

	my $threads_table = shift;
    my $zperf_sum = 0;


	foreach my $test (@$threads_table) {
		next if ( $test->{'type'} and ($test->{'type'} ne 'ZPERF'));
        $zperf_sum = $zperf_sum + $test->{'RESULT'}->{'Total'} if ($test->{'RESULT'}
        													   and $test->{'RESULT'}->{'Total'});


    }
    $log->log_result('Throughput of Zperf is : '.$zperf_sum);
    #syswrite(\*STDOUT,"\nCalculating Throughput...\n");
    syswrite(\*STDOUT,'Throughput of Zperf is : '.$zperf_sum);

	return undef;

}

sub calculate_summary_Cifs {
	my $log = shift;

	my $threads_table = shift;
    my $cifs_sum = 0;


	foreach my $test (@$threads_table) {
		next if ( $test->{'type'} and ($test->{'type'} ne 'CIFS'));
		print Dumper($test);
        $cifs_sum = $cifs_sum + $test->{'RESULT'}->{'Total'} if ($test->{'RESULT'}
        													   and $test->{'RESULT'}->{'Total'});


    }
    $log->log_result('Throughput of Cifs is : '.$cifs_sum);
    #syswrite(\*STDOUT,"\nCalculating Throughput...\n");
    syswrite(\*STDOUT,'Throughput of Cifs is : '.$cifs_sum);

	return undef;

}



# ---------------------------------------------------------------------------- #
#                      OTHER METHODS USED IN ABOVE SCRIPT                      #
# ---------------------------------------------------------------------------- #

sub wait_to_join_threads {
	my ($threads_table,$ftp_threads,$cifs_threads,$http_threads,$ws_client_threads) = @_;
    my $tid;


    foreach my $ftp_thread (@ftp_threads) {
		$tid = $ftp_thread->tid;
		$log->log_info('Waiting to join ftp thread '.$tid);
		my $ftp_result = $ftp_thread->join();
		$threads_table[$ftp_thread->tid]->{'RESULT'} = $ftp_result;
    }

	foreach my $cifs_thread (@cifs_threads) {
		$tid = $cifs_thread->tid;
		$log->log_info('Waiting to join cifs thread '.$tid);
		my $cifs_result = $cifs_thread->join();
#		print Dumper($cifs_result);
		$threads_table[$cifs_thread->tid]->{'RESULT'} = $cifs_result;
    }

    foreach my $http_thread (@http_threads) {
		$tid = $http_thread->tid;
		$log->log_info('Waiting to join http thread '.$tid);
        my $http_result = $http_thread->join();
        $threads_table[$http_thread->tid]->{'RESULT'} = $http_result;
    }
        foreach my $iperf_thread (@iperf_threads) {
		$tid = $iperf_thread->tid;
		$log->log_info('Waiting to join iperf thread '.$tid);
        my $iperf_result = $iperf_thread->join();
        $threads_table[$iperf_thread->tid]->{'RESULT'} = $iperf_result;
    }
    foreach my $zperf_thread (@zperf_threads) {
		$tid = $zperf_thread->tid;
		$log->log_info('Waiting to join zperf thread '.$tid);
        my $zperf_result = $zperf_thread->join();
        $threads_table[$zperf_thread->tid]->{'RESULT'} = $zperf_result;
    }
    foreach my $ws_client_thread (@ws_client_threads) {
    	$tid = $ws_client_thread->tid;
        $log->log_info('Waiting to get metrics from '.$threads_table[$ws_client_thread->tid]->{'client_ip'},$threads_table[$ws_client_thread->tid]->{'client_ip'});
        my $ws_client_result = $ws_client_thread->join;
        $threads_table[$ws_client_thread->tid]->{'RESULT'} = $ws_client_result;
#		$threads_table[$ws_client_thread->tid]->{'RESULT'}->{'IP'} = $threads_table[$ws_client_thread->tid]->{'client_ip'};
    }
}


######################### READ THE CLIENTS LIST ################################
sub read_client_list {
    my $file_name = shift;
    open(FH, $file_name);
    my @list = <FH>;
    close(FH);
    chomp foreach (@list);
    return @list;
}

######################## DOES NOT DO ANYTHING USEFUL ###########################
sub test {
	my $options = shift;
	my $server_response= XMLRPC::Lite-> proxy('http://'.'10.199.32.111'.':'.$CLIENT_LISTEN_PORT.'/',timeout=>$MAX_RPC_TIMEOUT)
				                      -> on_fault(sub {
								    print ("Couldn't connect to http://10.199.32.111:$CLIENT_LISTEN_PORT/\n");
						                              })
				                      -> call('WANScaler.Scalability.Library.test')
				                      -> result;
	print Dumper($server_response);
	exit 1;
    }