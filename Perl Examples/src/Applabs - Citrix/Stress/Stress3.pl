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
my $log_file_name = $LOG_DIR. $time.' - Stress3.log';
my $log = WANScaler::Utils::Log->new($log_file_name);
################################################################################

######################### TEST CASE 0001 #######################################
###################  CONFIGURE WANSCALER  ######################################

# Check if WANScaler need to be configured...
set_wanscaler_client($CLIENT_IP, \%wanscaler_client) if($CONFIGURE_WANSCALER == TRUE);


# 1. Run the Iperf for 10 sessions...for more than 1 hour
# 2. Bandwidth of 1.5 Mbps

my $seed = undef;
my $ftp_thread = threads->new(\&do_ftp, $CLIENT_IP, \%ftp);
$log->log_info('FTP test initiated for '. $CLIENT_IP);
syswrite(\*STDOUT,'Waiting for tests to complete...');
my $result = $ftp_thread->join;
$log->log_info('FTP Operation is :'.Dumper($result));


sub do_ftp {
	my ($server_ip,$ftp_options) = @_;
	my $server_response= XMLRPC::Lite-> proxy('http://'.$server_ip.':'.$CLIENT_LISTEN_PORT.'/',timeout=>$MAX_RPC_TIMEOUT)
									  -> on_fault(sub {
														$log->log_error("Couldn't connect to http://$server_ip:$CLIENT_LISTEN_PORT/\n");
														threads->exit() if threads->can('exit');
													   })
									  -> call('WANScaler.Stress.Library.stress_ftp',$ftp_options)
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
