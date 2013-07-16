#!/usr/bin/perl
use strict;
use warnings;
use threads;
use Data::Dumper;
use XMLRPC::Lite;
use Readonly;
use WANScaler::Utils::Log;

use constant { 	TRUE => 1,
				FALSE => 0
             };

Readonly my $CIFS_TEST          => 0x01;
Readonly my $FTP_TEST           => 0x02;
Readonly my $HTTP_TEST          => 0x04;
Readonly my $IPERF_TEST         => 0x10;
Readonly my $TEST               => $IPERF_TEST;
Readonly my $CLIENT_LISTEN_PORT	=> 7050;
Readonly my $MAX_RPC_TIMEOUT	=> 3600;
Readonly my $CLIENT_FILE_NAME   => 'Clients.txt';

Readonly my $CONFIGURE_WANSCALER=> FALSE;
Readonly my $SEED_INITIALIZER 	=> 30;
Readonly my $MAX_RANDOM_VALUE 	=> 1000000;
Readonly my $SCALE				=> 1000000; # FOR MEGABIT
Readonly my $BYTE_TO_BIT 		=> 8;
Readonly my $LOG_DIR			=> ".\\Results\\" ; # MUST END WITH \\

# initialize the random number generator with the seed value;
srand($SEED_INITIALIZER);
print STDERR $TEST;  # I DONT know why, but if I do not print this CIFS test starts for one machine :-((

# Machine from where WS related commands can be thrown off... :-)
Readonly my %wanscaler => {
							server 			=> '10.199.32.111',
                            server_port 	=> 7075, # port to which this server is listening...
                            wanscaler 		=> '172.32.1.111',
                            wanscaler_port 	=> 2050,
                          };
Readonly my %wanscaler_client => {
							PARAMETER => {
#                            	'dbc.maxpendingperspindle' => 1,
#								'System.VirtualClients' => 100,
								'SlowSendRate'			=> '10 M/S',
								'SlowRecvRate'			=> '10 M/S',
#                                'UI.Softboost'			=> 'off'
							},
							restart_service	=> 1
                          };
Readonly my %cifs => {
                        share_name 			=> 'CIFS_Share0',
	                    read_file_path  	=> 'LargeFile45\\',                # ifgiven must end with \\
	                    read_file_name      => 'LargeFile.dat',
	                    ip_address          => {
											network_address => [172,32,2],
											host_address    => [30],
                                           },
	                    sessions            => 2,
	                    use_same_file       => 1,
                    };

Readonly my %ftp => {
                      server 		=> '172.32.2.41',
                      user_name   	=> 'Administrator',
	                  password      => 'ARS!jr',
	                  source_path   => '/', # Must terminate with /
                      get_file_name => 'LargeFile.dat',
	                  use_same_file => 1,
	                  sessions      => 2
                    };

Readonly my %http => {
                    server_address => '172.32.2.41',
                    server_port     => '80', # DEFAULT
                    uri             => 'index.html',
#                    use_same_file   => 1,
                    sessions        => 10
                    };

Readonly my %iperf => {
                   server 	=> '172.32.2.41',
                   'time'  	=> 120, # TIME has precedence over SIZE So comment it when using SIZE
#                   'size' 	=> 20000,
                   'random' => TRUE,
                   sessions => 20
                     };

# Create a log file
my $time = WANScaler::Utils::Log::get_time;
$time =~ s/://g;
my $log_file_name = $LOG_DIR. $time.' - Scalability.log';
my $log = WANScaler::Utils::Log->new($log_file_name);
my @client_ips = read_client_list($CLIENT_FILE_NAME);

if($CONFIGURE_WANSCALER == TRUE) {
	syswrite(\*STDOUT, $CONFIGURE_WANSCALER);
	foreach my $ip (@client_ips) {
		chomp($ip);
        syswrite(\*STDERR,$ip);
		set_wanscaler_client($ip, \%wanscaler_client);
	}
    exit(1);
}

#test(\%wanscaler);

$log->log_info('Test started');

my @cifs_threads ;
my @ftp_threads ;
my @http_threads ;
my @iperf_threads;
my @threads_table;

# Start the test here
my $i = 0;

foreach my $client_ip (@client_ips) {
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
    		syswrite(\*STDOUT,'Random Used');
            do {
            	$seed = rand;
				$seed = int ( $seed * $MAX_RANDOM_VALUE);
    	        syswrite(\*STDOUT,"\n $seed");
                sleep(1);
            } while ($seed <= 0);

        }
		$iperf_threads[$i] = threads->new(\&do_iperf, $client_ip, \%iperf, $seed);
        $log->log_info('IPERF test initiated for '. $client_ip);
        $threads_table[$iperf_threads[$i]->tid] = {type => 'IPERF',
													client_ip => $client_ip
			                                      };
    }
    #delay between creating threads as perl might fail to create
    # multiple threads on go [it failed many times for me so I keep this].
    sleep(1);
    $i++;
}

$i = 0;
my $val =0;
my $sum = 0;
wait_to_join_threads(\@threads_table,\@ftp_threads,\@cifs_threads,\@http_threads);
write_results($log,\@threads_table);
calculate_summary(\@threads_table);


sub calculate_summary {
	my $threads_table = shift;
	# TODO
	return undef;
}


sub wait_to_join_threads {
	my ($threads_table,$ftp_threads,$cifs_threads,$http_threads) = @_;
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
        #FORMAT HTTP RESULT HERE - TODO
#		my $formatted_result = format_http_results($http_result,\%http,$http_thread);
        $threads_table[$http_thread->tid]->{'RESULT'} = $http_result;
    }
    foreach my $iperf_thread (@iperf_threads) {
		my $tid = $iperf_thread->tid;
		$log->log_info('Waiting to join iperf thread '.$tid);
        my $iperf_result = $iperf_thread->join();
        $threads_table[$iperf_thread->tid]->{'RESULT'} = $iperf_result;
    }
}
sub format_http_results {
	my($http_result,$ip) = @_;
    my $result = undef;
    my $total = 0;
	foreach my $http (@$http_result) {
    	if($http->{'RESULT'}->{'PASS'}) {
        	my $http_res = $http->{'RESULT'}->{'PASS'};
			my $tp = ($http_res->{'TIME'} > 0) ? $http_res->{'SIZE'} / ( $http_res->{'TIME'} * $SCALE * $BYTE_TO_BIT) : 0;
            $total = $total+ $tp;
        	$result = $result. ( $result ? ','. sprintf("%.3f", $tp) : sprintf("%.3f", $tp) );
        }
    }
    my $ret = { 'Total' => $total,
    			'Instance' => $result,
                'IP'	=> $ip
                };
    syswrite(\*STDOUT, Dumper($ret));
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

sub do_ftp {
	my ($server_ip, $ftp_options) = @_;

	my $server_response= XMLRPC::Lite -> proxy('http://'.$server_ip.':'.$CLIENT_LISTEN_PORT.'/',timeout=>$MAX_RPC_TIMEOUT)
									  -> on_fault(sub {
														$log->log_error("Couldn't connect to http://$server_ip:$CLIENT_LISTEN_PORT/\n");
														threads->exit() if threads->can('exit');
										   })
									   -> call('WANScaler.Scalability.Library.start_ftp_sessions',$ftp_options)
									   -> result;
	return $server_response;

}



sub do_cifs {
	my ($server_ip,$cifs_options) = @_;
	my $server_response= XMLRPC::Lite-> proxy('http://'.$server_ip.':'.$CLIENT_LISTEN_PORT.'/',timeout=>$MAX_RPC_TIMEOUT)
									  -> on_fault(sub {
														$log->log_error("Couldn't connect to http://$server_ip:$CLIENT_LISTEN_PORT/\n");
														threads->exit() if threads->can('exit');
													   })
									  -> call('WANScaler.Scalability.Library.start_cifs_sessions',$cifs_options)
									  -> result;
	return $server_response;
}

sub do_http {
	my ($server_ip,$http_options) = @_;
	my $server_response= XMLRPC::Lite -> proxy('http://'.$server_ip.':'.$CLIENT_LISTEN_PORT.'/',timeout=>$MAX_RPC_TIMEOUT)
									  -> on_fault(sub {
														$log->log_error("Couldn't connect to http://$server_ip:$CLIENT_LISTEN_PORT/\n");
														threads->exit() if threads->can('exit');
													   })
									  -> call('WANScaler.Scalability.Library.start_http_sessions',$http_options)
									  -> result;
#   	my $formatted_result = format_http_results($server_response,$server_ip);
	return $server_response;
}



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



sub run {
	my ($command, $cmd_line_options) = @_;
	my $cmd_opt =  @$cmd_line_options[0];
	my @arr= `$command $cmd_opt 2>&1`;
	foreach my $line (@arr) {
		if ($line =~ /\s+0K[\s+\.]*\s+\d+%\s+(\d+\.?\d*)\s([KMG]?)B\/s/) {
			return $1*1024                if ($2 eq 'K');
			return $1*1024*1024       if ($2 eq 'M');
			return $1*1024*1024*1024 if ($2 eq 'G');
			return $1;
		}
	}
	return 'FAIL';
}

sub read_client_list {
    my $file_name = shift;
    open(FH, $file_name);
    my @list = <FH>;
    close(FH);
    foreach (@list) {
    	chomp;
    }
    return @list;
}

sub format_iperf_result {
    my $iperf_response = shift;
    my @response = split(/\n/,$iperf_response);
    my $ret =  {'TYPE' => 'IPERF','RESULT'=>{}};
    my $sum = 0;
    foreach (@response) {
        if( $_ =~ /^\[(\d+)\]/ ) {
           my $id = $1;
           if ($_ =~ /\s+(\d+\.?\d*)\s+Mbits\/sec/){
			   if ($1) {
					$ret->{'RESULT'}->{$id} = $1;
                    $sum = $sum + $1;
				}
            }
        } elsif ($_ =~ /SUM/ ){
            if ($_ =~ /\s+(\d+\.?\d*)\s+Mbits\/sec/){
               	$ret->{'TOTAL'} = $1 if $1;
           	}
        }
    }
    $ret->{'sum'} = $sum;
    return $ret;
}

sub o_format_iperf_result {
	my $iperf_response = shift;
    my @response = split(/\n/,$iperf_response);
    foreach (@response) {
        if( ($_ =~ /^\[\d+\]/ ) and ($_ =~ /\s+(\d+\.?\d*)\s+Mbits\/sec/)){
            $_ =~ /\s+(\d+\.?\d*)\s+Mbits\/sec/;
            return $1;
        }
    }
    return $iperf_response;
}
sub set_wanscaler_client {
	my $client_ip = shift;
	my $options = shift;
	my $server_response = XMLRPC::Lite-> proxy("http://".$client_ip.":".$CLIENT_LISTEN_PORT.'/',timeout=>$MAX_RPC_TIMEOUT)
									  -> on_fault(sub {
														print ("Couldn't connect to http://$client_ip:$CLIENT_LISTEN_PORT/\n");
						                              })
				                      -> call('WANScaler.Scalability.Library.set_wanscaler_client', $options)
				                      -> result;
print Dumper($server_response);
}


sub test {
	my $options = shift;
	my $server_response= XMLRPC::Lite-> proxy('http://'.'10.199.32.111'.':'.$CLIENT_LISTEN_PORT.'/',timeout=>$MAX_RPC_TIMEOUT)
				                      -> on_fault(sub {
														print ("Couldn't connect to http://10.199.32.111:$CLIENT_LISTEN_PORT/\n");
						                              })
				                      -> call('WANScaler.Scalability.Library.get_virtual_clients')
				                      -> result;
	print Dumper($server_response);
	exit 1;
}

sub reload {
	my $client_ip = shift;
	my $server_response = XMLRPC::Lite-> proxy("http://".$client_ip.":".$CLIENT_LISTEN_PORT.'/',timeout=>$MAX_RPC_TIMEOUT)
									  -> on_fault(sub {
														print ("Couldn't connect to http://$client_ip:$CLIENT_LISTEN_PORT/\n");
						                              })
				                      -> call('WANScaler.Scalability.Library.reload')
				                      -> result;
	print Dumper($server_response);
}