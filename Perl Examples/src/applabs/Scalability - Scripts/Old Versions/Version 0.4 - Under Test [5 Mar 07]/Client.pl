#!/usr/bin/perl
# ADDED WANSCALER LOGGING... Have to check...
#
# foreach if used in single liner, then my <var> does not work... WHY?
# TODO: SEPARATE DEBUG LOG STATEMENTS :-)

use strict;        #
use warnings;
use threads;
use Data::Dumper;
use XMLRPC::Lite;
use Readonly;

# WANScaler Library
use WANScaler::Utils::Log;
use WANScaler::Scalability::Config;
use WANScaler::XmlRpc::System;

#initialize the random number generator.
srand($SEED_INITIALIZER);
#print $TEST;
syswrite(\*STDOUT,$TEST);
#exit(1);
# Create a log file
my $time = WANScaler::Utils::Log::get_time; $time =~ s/://g;
my $log_file_name = $LOG_DIR. $time.' - Scalability.log';
my $log = WANScaler::Utils::Log->new($log_file_name);

# read the list of machines on which test need to be done
my @client_ips = read_client_list($CLIENT_FILE_NAME);

# Check if WANScaler need to be configured...
#my $ip;
if($CONFIGURE_WANSCALER == TRUE) {
	# Configure each WANScaler Client and Exit
	foreach my $ip (@client_ips) {
    set_wanscaler_client($ip, \%wanscaler_client) ;
    }
    exit(1);
}

$log->log_info('Test started');

my (@cifs_threads, @ftp_threads, @http_threads,
	@iperf_threads, @threads_table, @ws_client_threads);

# Start the test here
my $i = 0;
my $client_ip;
foreach $client_ip (@client_ips) {
    $log->log_info('Starting the test for '.$client_ip);
    if(($TEST & $CIFS_TEST) == $CIFS_TEST) {
		$cifs_threads[$i] = threads->new(\&do_cifs, $client_ip, \%cifs);
        $log->log_info('CIFS test initiated for '. $client_ip);
        $threads_table[$cifs_threads[$i]->tid] = {	type => 'CIFS',
													client_ip => $client_ip
							                       };
    }

    if(($TEST & $FTP_TEST) == $FTP_TEST) {
		$ftp_threads[$i] = threads->new(\&do_ftp, $client_ip, \%ftp);
        $log->log_info('FTP test initiated for '. $client_ip);
        $threads_table[$ftp_threads[$i]->tid] = {type => 'FTP',
												 client_ip => $client_ip
                                                };
    }

    if(($TEST & $HTTP_TEST) == $HTTP_TEST) {
		$http_threads[$i] = threads->new(\&do_http, $client_ip, \%http);
        $log->log_info('HTTP test initiated for '. $client_ip);
        $threads_table[$http_threads[$i]->tid] = {type => 'HTTP',
													client_ip => $client_ip
                                                 };
    }
    if(($TEST & $IPERF_TEST) == $IPERF_TEST) {
    	my $seed = undef;
    	if($iperf{'random'} == 1) {
            do {
            	$seed = rand;
				$seed = int ( $seed * $MAX_RANDOM_VALUE);
    	        $log->log_info("Seed value used is : $seed");
                sleep(1);
            } while ($seed <= 0);

        }
		$iperf_threads[$i] = threads->new(\&do_iperf, $client_ip, \%iperf, $seed);
        $log->log_info('IPERF test initiated for '. $client_ip);
        $threads_table[$iperf_threads[$i]->tid] = { type => 'IPERF',
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
    	$threads_table[$ws_client_threads[$i]->tid] ={ type => 'Client',	'client_ip' => $client_ip
				                                      };
		$i++;
	}
}

#my $ws = WANScaler::Scalability::Library->get_wanscaler_stats(\%ws_stat);
#print Dumper($ws);
$i = 0;
my $val =0;
my $sum = 0;
wait_to_join_threads(\@threads_table,
					 \@ftp_threads,
                     \@cifs_threads,
                     \@http_threads,
                     \@ws_client_threads);
write_results($log,\@threads_table);
calculate_summary(\@threads_table); #TODO

# ---------------------------------------------------------------------------- #
#                     METHODS THAT START THE TESTS                             #
# ---------------------------------------------------------------------------- #

######################## STARTER FOR FTP TEST ################################
sub do_ftp {
	my ($server_ip, $ftp_options) = @_;

	my $server_response= XMLRPC::Lite -> proxy('http://'.$server_ip.':'.$CLIENT_LISTEN_PORT.'/',timeout=>$MAX_RPC_TIMEOUT)
									  -> on_fault(sub {
														$log->log_error("Couldn't connect to http://$server_ip:$CLIENT_LISTEN_PORT/\n");
														threads->exit() if threads->can('exit');
										   })
									   -> call('WANScaler.Scalability.Library.start_ftp_sessions',$ftp_options)
									   -> result;
    $server_response = format_results($server_response);
	return $server_response;

}

######################## STARTER FOR CIFS TEST ################################
sub do_cifs {
	my ($server_ip,$cifs_options) = @_;
	my $server_response= XMLRPC::Lite-> proxy('http://'.$server_ip.':'.$CLIENT_LISTEN_PORT.'/',timeout=>$MAX_RPC_TIMEOUT)
									  -> on_fault(sub {
														$log->log_error("Couldn't connect to http://$server_ip:$CLIENT_LISTEN_PORT/\n");
														threads->exit() if threads->can('exit');
													   })
									  -> call('WANScaler.Scalability.Library.start_cifs_sessions',$cifs_options)
									  -> result;
    $server_response = format_results($server_response);
	return $server_response;
}

######################## STARTER FOR HTTP TEST ################################
sub do_http {
	my ($server_ip,$http_options) = @_;
	my $server_response= XMLRPC::Lite -> proxy('http://'.$server_ip.':'.$CLIENT_LISTEN_PORT.'/',timeout=>$MAX_RPC_TIMEOUT)
									  -> on_fault(sub {
														$log->log_error("Couldn't connect to http://$server_ip:$CLIENT_LISTEN_PORT/\n");
														threads->exit() if threads->can('exit');
													   })
									  -> call('WANScaler.Scalability.Library.start_http_sessions',$http_options)
									  -> result;
    $server_response = format_results($server_response);
	return $server_response;
}

######################## STARTER FOR IPERF TEST ################################
sub do_iperf {
	my ($server_ip,$iperf_options,$seed) = @_;
	my $server_response= XMLRPC::Lite-> proxy('http://'.$server_ip.':'.$CLIENT_LISTEN_PORT.'/',timeout=>$MAX_RPC_TIMEOUT)
									  -> on_fault(sub {
														$log->log_error("Couldn't connect to http://$server_ip:$CLIENT_LISTEN_PORT/\n");
														threads->exit() if threads->can('exit');
													   })
									  -> call('WANScaler.Scalability.Library.start_iperf_sessions',$iperf_options,$seed)
									  -> result;
	print Dumper($server_response);
	my $formatted = format_iperf_result($server_response);
    $formatted->{'IP'} =$server_ip;
	return $formatted;

}

################## GET THE WANSCALER CLIENT STATISTICS #########################
sub do_ws_client_stat {
	my ($server_ip, $wanscaler_stat) = @_;
    print Dumper($wanscaler_stat);
    my $server_response = XMLRPC::Lite-> proxy('http://'.$server_ip.':'.$CLIENT_LISTEN_PORT.'/',timeout=>$MAX_RPC_TIMEOUT)
    					  			  -> on_fault( sub {
                                      					$log->log_error("Couldn't connect to http://$server_ip:$CLIENT_LISTEN_PORT/\n");
														threads->exit() if threads->can('exit');
                                      			   })
                                      -> call('WANScaler.Scalability.Library.get_wanscaler_stats',$wanscaler_stat)
                                     -> result;
    return $server_response;
}

################### SET THE WANSCALER PARAMETERS AT CIENT MACHINE ##############
sub set_wanscaler_client {
	my $client_ip = shift;
	my $options = shift;
	my $server_response = XMLRPC::Lite-> proxy("http://".$client_ip.":".$CLIENT_LISTEN_PORT.'/',timeout=>$MAX_RPC_TIMEOUT)
									  -> on_fault(sub {
														print ("Couldn't connect to http://$client_ip:$CLIENT_LISTEN_PORT/\n");
						                              })
				                      -> call('WANScaler.Scalability.Library.set_wanscaler_client', $options)
				                      -> result;
	return $server_response;
}
####################################################################################################################

# ---------------------------------------------------------------------------- #
#                      RESULTS RELATED METHOD [LOGGING}                        #
# ---------------------------------------------------------------------------- #

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
    syswrite(\*STDOUT, Dumper($ret));
    return $ret;
}

############################ FORMATTER OF IPERF RESULT #########################
sub format_iperf_result {
    my $iperf_response = shift;
    my @response = split(/\n/,$iperf_response);
#    my $ret =  {'RESULT'=>{}};
	my $instances = undef;
#    my $sum = 0;
	my $total = 0;

    foreach (@response) {
        if( $_ =~ /^\[(\d+)\]/ ) {
           my $id = $1;
           if ($_ =~ /\s+(\d+\.?\d*)\s+Mbits\/sec/){
			   if ($1) {
   		        	$instances = $instances. ( $instances ? ','.$1 : $1 );
#					$ret->{'RESULT'}->{$id} = $1;
#                    $sum = $sum + $1;
				}
            }
        } elsif ($_ =~ /SUM/ ){
            if ($_ =~ /\s+(\d+\.?\d*)\s+Mbits\/sec/){
               	$total = $1 if $1;
           	}
        }
    }
#    $ret->{'sum'} = $sum;
    my $ret = { 'Total' 	=> $total,
    			'Instance'  => $instances
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

sub calculate_summary {
	my $threads_table = shift;
	# TODO
	return undef;
}

# ---------------------------------------------------------------------------- #
#                      OTHER METHODS USED IN ABOVE SCRIPT                      #
# ---------------------------------------------------------------------------- #

sub wait_to_join_threads {
	my ($threads_table,$ftp_threads,$cifs_threads,$http_threads,$ws_client_threads) = @_;
    foreach my $ws_client_thread (@ws_client_threads) {
    	my $tid = $ws_client_thread->tid;
        $log->log_info('Waiting to get metrics from',$threads_table[$ws_client_thread->tid]->{'client_ip'});
        my $ws_client_result = $ws_client_thread->join;
        $threads_table[$ws_client_thread->tid]->{'RESULT'} = $ws_client_result;
    }

    foreach my $ftp_thread (@ftp_threads) {
		my $tid = $ftp_thread->tid;
		$log->log_info('Waiting to join ftp thread '.$tid);
		my $ftp_result = $ftp_thread->join();
		$threads_table[$ftp_thread->tid]->{'RESULT'} = $ftp_result;
    }

	foreach my $cifs_thread (@cifs_threads) {
		my $tid = $cifs_thread->tid;
		$log->log_info('Waiting to join cifs thread '.$tid);
		my $cifs_result = $cifs_thread->join();
		$threads_table[$cifs_thread->tid]->{'RESULT'} = $cifs_result;
    }

    foreach my $http_thread (@http_threads) {
		my $tid = $http_thread->tid;
		$log->log_info('Waiting to join http thread '.$tid);
        my $http_result = $http_thread->join();
        $threads_table[$http_thread->tid]->{'RESULT'} = $http_result;
    }
    foreach my $iperf_thread (@iperf_threads) {
		my $tid = $iperf_thread->tid;
		$log->log_info('Waiting to join iperf thread '.$tid);
        my $iperf_result = $iperf_thread->join();
        $threads_table[$iperf_thread->tid]->{'RESULT'} = $iperf_result;
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