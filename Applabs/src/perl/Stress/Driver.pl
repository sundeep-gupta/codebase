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
use Readonly;

# WANScaler Library
use WANScaler::Utils::Log;
use WANScaler::Stress::Config;
use WANScaler::XmlRpc::System;

####################### VARIABLE DECALARATION ##################################
my (@cifs_threads, @ftp_threads, @http_threads,   $client_ip,
	@iperf_threads, @threads_table, @ws_client_threads, @ws_install_threads, $i);
################################################################################

########################### Create LOG File ####################################
my $time = WANScaler::Utils::Log::get_time; $time =~ s/://g;
my $log_file_name = $LOG_DIR. $time.' - Stress.log';
my $log = WANScaler::Utils::Log->new($log_file_name);
################################################################################

######################### TEST CASE 0001 #######################################
###################  CONFIGURE WANSCALER  ######################################

# Check if WANScaler need to be configured...
set_wanscaler_client($CLIENT_IP, \%wanscaler_client) if($CONFIGURE_WANSCALER == TRUE);


# 1. Run the Iperf for 10 sessions...for more than 1 hour
# 2. Bandwidth of 1.5 Mbps

my $seed = undef;
if($iperf{'random'} == 1) {
    do {
        $seed = rand;
        $seed = int($seed * $MAX_RANDOM_VALUE);
        $log->log_info("Seed value used is : $seed");
        sleep(1);
    } while ($seed <= 0);

}
my $iperf_thread = threads->new(\&do_iperf, $CLIENT_IP, \%iperf, $seed);
$log->log_info('IPERF test initiated for '. $CLIENT_IP);
$threads_table[$iperf_thread->tid] = { type => 'IPERF',
                                            client_ip => $CLIENT_IP
                                          };

$i = 0;
my $val =0;
my $sum = 0;
syswrite(\*STDOUT,'Waiting for tests to complete...');

wait_to_join_threads(\@threads_table,[$iperf_thread]);
write_results($log,\@threads_table);


sub do_iperf {
	my ($server_ip,$iperf_options,$seed) = @_;
	my $server_response= XMLRPC::Lite-> proxy('http://'.$server_ip.':'.$CLIENT_LISTEN_PORT.'/',timeout=>$MAX_RPC_TIMEOUT)
									  -> on_fault(sub {
														$log->log_error("Couldn't connect to http://$server_ip:$CLIENT_LISTEN_PORT/\n");
														threads->exit() if threads->can('exit');
													   })
									  -> call('WANScaler.Scalability.Library.start_iperf_sessions',$iperf_options,$seed)
									  -> result;
#	print Dumper($server_response);
	my $formatted = format_iperf_result($server_response);
    $formatted->{'IP'} =$server_ip;
	return $formatted;

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
	my ($threads_table,$iperf_threads) = @_;
    foreach my $iperf_thread (@$iperf_threads) {
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