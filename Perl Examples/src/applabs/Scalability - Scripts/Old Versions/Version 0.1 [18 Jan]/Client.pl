#!/usr/bin/perl
#PREDEFINED Libraries
#use lib qw(..);
#use strict;
use threads;
use Data::Dumper;
use XMLRPC::Lite;
use IPC::Open3;
use POSIX ":sys_wait_h";
use Readonly;

# WANScaler Library
#use WANScaler::Scalability::Config;
use WANScaler::Utils::Log;
#require 'TestLibrary.pl';

Readonly my $CIFS_TEST              => 0x01;
Readonly my $FTP_TEST               => 0x02;
Readonly my $HTTP_TEST              => 0x04;
Readonly my $IPERF_TEST             => 0x10;
Readonly my $TEST                   => $IPERF_TEST;
Readonly my $CLIENT_LISTEN_PORT 	=> 7050;
Readonly my $MAX_RPC_TIMEOUT       	=> 3600;
Readonly my $CLIENT_FILE_NAME       => 'Clients.txt';

print $TEST;

# Machine from where WS related commands can be thrown off... :-)

Readonly my %wanscaler => {
							server 	   	  	 => '10.199.32.111',
                	        server_port 	 => 7075, # port to which this serveris listening...
                            wanscaler		 => '172.32.1.111',
                            wanscaler_port 	 => 2050,
                          };
Readonly my %cifs => {
                            share_name 	   => 'CIFS_Share0',
		                    read_file_path => 'LargeFile45\\',                # if given must end with \\
		                    read_file_name => 'LargeFile.dat',
		                    ip_address     => { network_address => [172,32,2],
												host_address    => [30],
                                              },
			                sessions               => 2,
                            use_same_file       => 1,
                     };
Readonly my %ftp => {
                            server 		   => '172.32.2.41',
		                    user_name      => 'Administrator',
		                    password       => 'ARS!jr',
		                    source_path    => '/root/', # Must terminate with /
                            get_file_name  => 'LargeFile.dat',
		                    use_same_file  => 1,
		                    sessions       => 2
                    };

Readonly my %http => {
                            server_address => '172.32.2.42',
		                    server_port    => '80', # DEFAULT
		                    uri            => 'index.html',
		                    use_same_file  => 1,
		                    sessions       => 2
                     };
Readonly my %iperf => {
                            server   => '172.32.2.41',
                            'time'   => 100,
		                    sessions => 1
                      };

# Create a log file

my $log_file_name = time.' - Scalability.log';
my $log = WANScaler::Utils::Log->new($log_file_name);

#test(\%wanscaler);
my @client_ips = read_client_list($CLIENT_FILE_NAME);

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
        $threads_table[$cifs_threads[$i]->tid] = {
        										  type => 'CIFS',
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
		$iperf_threads[$i] = threads->new(\&do_iperf, $client_ip,\%iperf);
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
        $threads_table[$http_thread->tid]->{'RESULT'} = $http_result;
    }
    foreach my $iperf_thread (@iperf_threads) {
        my $tid = $iperf_thread->tid;
        $log->log_info('Waiting to join iperf thread '.$tid);
        my $iperf_result = $iperf_thread->join();
        $threads_table[$iperf_thread->tid]->{'RESULT'} = $iperf_result;
    }
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
    my $server_response= XMLRPC::Lite->proxy('http://'.$server_ip.':'.$CLIENT_LISTEN_PORT.'/',timeout=>$MAX_RPC_TIMEOUT)
                                     -> on_fault(sub {
														$log->log_error("Couldn't connect to http://$server_ip:$CLIENT_LISTEN_PORT/\n");
						                                threads->exit() if threads->can('exit');
						                              }
                                     		    )
				                      -> call('WANScaler.Scalability.Library.start_ftp_sessions',$ftp_options)
				                      -> result;
    return $server_response;
}

sub do_cifs {
    my ($server_ip,$cifs_options) = @_;
    my $server_response= XMLRPC::Lite -> proxy('http://'.$server_ip.':'.$CLIENT_LISTEN_PORT.'/',timeout=>$MAX_RPC_TIMEOUT)
                                      -> on_fault(sub {
                                                        $log->log_error("Couldn't connect to
                                                        http://$server_ip:$CLIENT_LISTEN_PORT/\n");
                                                        threads->exit() if threads->can('exit');
                                                       }
                                                 )
                                      -> call('WANScaler.Scalability.Library.start_cifs_sessions',$cifs_options)
                                      -> result;
    return $server_response;
}
sub do_http {
    my ($server_ip,$http_options) = @_;
    my $server_response= XMLRPC::Lite-> proxy('http://'.$server_ip.':'.$CLIENT_LISTEN_PORT.'/',timeout=>$MAX_RPC_TIMEOUT)
				                     -> on_fault(sub {
	                                                    $log->log_error("Couldn't connect to
	                                                    http://$server_ip:$CLIENT_LISTEN_PORT/\n");
						                                threads->exit() if threads->can('exit');
	                                               }
	                                        )
				                      -> call('WANScaler.Scalability.Library.start_http_sessions',$http_options)
				                      -> result;

    return $server_response;

}
sub do_iperf {
	my ($server_ip,$iperf_options) = @_;
	my $server_response= XMLRPC::Lite -> proxy('http://'.$server_ip.':'.$CLIENT_LISTEN_PORT.'/',timeout=>$MAX_RPC_TIMEOUT)
				                      -> on_fault(sub {
	                                                    $log->log_error("Couldn't connect to
	                                                    http://$server_ip:$CLIENT_LISTEN_PORT/\n");
						                                threads->exit() if threads->can('exit');
						                               }
                                      			)
				                      -> call('WANScaler.Scalability.Library.start_iperf_sessions',$iperf_options)
				                      -> result;
	print Dumper($server_response);
    my $formatted = format_iperf_result($server_response);
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
    return @list;
}

sub format_iperf_result {
    my $iperf_response = shift;
    my @response = split(/\n/,$iperf_response);
    my $ret =  {'TYPE' => 'IPERF','RESULT'=>{}};
    foreach (@response) {
        if( $_ =~ /^\[(\d+)\]/ ) {
			my $id = $1;
            if ($_ =~ /\s+(\d+\.?\d*)\s+Mbits\/sec/){
                if ($1) {
                    $ret->{'RESULT'}->{$id} = $1;
                }
    	    }
        }
    }
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

sub test {
    my $options = shift;
    my $server_response= XMLRPC::Lite -> proxy('http://'.'10.199.32.111'.':'.$CLIENT_LISTEN_PORT.'/',timeout=>$MAX_RPC_TIMEOUT)
				                      -> on_fault(sub {
														print ("Couldn't connect to http://10.199.32.111:$CLIENT_LISTEN_PORT/\n");
						                               }
                                      			)
				                      -> call('WANScaler.Scalability.Library.get_virtual_clients')
				                      -> result;
print Dumper($server_response);
exit 1;
}

