package WANScaler::Stress::Config;
use strict;
use Readonly;
use vars qw(@EXPORT @ISA);
require Exporter;
our @ISA = ('Exporter');

use constant { 	TRUE => 1,
				FALSE => 0
             };
################# CONSTNATS THAT RARELY REQUIRE CONFIGURATION ##################

Readonly our $CLIENT_LISTEN_PORT   		=> 7050;
Readonly our $MAX_RPC_TIMEOUT	   		=> 7200;
#Readonly our $CLIENT_FILE_NAME   		=> 'Clients.txt';
Readonly our $CLIENT_IP 				=> '10.199.32.40';
Readonly our $CIFS_TEST          		=> 0x01;
Readonly our $FTP_TEST        		   	=> 0x02;
Readonly our $HTTP_TEST        	  		=> 0x04;
Readonly our $IPERF_TEST        	 	=> 0x10;
Readonly our $SEED_INITIALIZER 			=> 30;
Readonly our $MAX_RANDOM_VALUE 			=> 1000000;
Readonly our $SCALE			   			=> 1000000; # FOR MEGABIT
Readonly our $BYTE_TO_BIT 	   			=> 8;
Readonly our $LOG_DIR		   			=> ".\\Results\\" ; # MUST END WITH \\

###################### CONFIGURABLE CONSTANTS ##################################
Readonly our $TEST               		=> $IPERF_TEST;
Readonly our $INSTALL_WANSCALER_CLIENT	=> TRUE;
Readonly our $CONFIGURE_WANSCALER		=> FALSE;
Readonly our $CAPTURE_CLIENT_METRICS 	=> FALSE;

# Machine from where WS related commands can be thrown off... :-)
Readonly our %wanscaler => {
							server 			=> '10.199.32.111',
                            server_port 	=> 7075, # port to which this server is listening...
                            wanscaler 		=> '172.32.1.111',
                            wanscaler_port 	=> 2050,
                          };

# CONFIG for WANScaler Client
Readonly our %wanscaler_client => {
							PARAMETER => {
#                            	'dbc.maxpendingperspindle' => 1,
#								'System.VirtualClients' => 100,
								'SlowSendRate'			=> '10 M/S',
								'SlowRecvRate'			=> '10 M/S',
#                                'UI.Softboost'			=> 'off'
							},

							restart_service	=> 1
                          };

# GIVE METRICS THAT NEED TO BE CAPTURED AT RUNTIME...
Readonly our %ws_stat => {
						CPU => TRUE,
#                        COMPRESSION_RATIO => TRUE
					};
Readonly our %cifs => {
	                    ip_address          => {
											network_address => [172,32,2],
											host_address    => [30],
                                           },
                        share_name 			=> 'CIFS_Share0',
	                    read_file_path  	=> 'LargeFile45\\',                # ifgiven must end with \\
	                    read_file_name      => 'LargeFile.dat',

	                    sessions            => 2,
	                    use_same_file       => 1,
                    };

Readonly our %ftp => {
                      server 		=> '172.32.2.41',
                      username   	=> 'Administrator',
	                  password      => 'ARS!jr',
	                  src_path   => '/', # Must terminate with /
                      get_file_name => 'page.html',
	                  use_same_file => 1,
	                  sessions      => 2,
                      'time'		=> 2
                    };

Readonly our %http => {
                    server_address => '172.32.2.41',
                    server_port     => '80', # DEFAULT
                    uri             => 'index.html',
#                    use_same_file   => 1,
                    sessions        => 2,
                    'time' 			=> 2
                    };

Readonly our %iperf => {
                   server 	=> '172.32.2.42',
                   'time'  	=> 3600, # TIME has precedence over SIZE So comment it when using SIZE
#                   'size' 	=> 20000,
                   'random' => FALSE,
                   sessions => 75
                     };
Readonly our %wanscaler_install => {
                   build 		 => '0.0.0-721',
                   type			 => 'release',
                   server		 => '10.200.2.103',
                   path			 => '/msi',
                   filename		 =>'WANScalerClientWin32-type-build.msi',
				};


my @_const = qw( $CIFS_TEST
                 $FTP_TEST
                 $HTTP_TEST
                 $IPERF_TEST
                 $TEST
                 $CLIENT_LISTEN_PORT
				 $MAX_RPC_TIMEOUT
                 $CLIENT_IP
                 $CONFIGURE_WANSCALER
                 $SEED_INITIALIZER
                 $MAX_RANDOM_VALUE
                 $CAPTURE_CLIENT_METRICS
                 $SCALE
                 $INSTALL_WANSCALER_CLIENT
                 $BYTE_TO_BIT
                 $LOG_DIR
                 %wanscaler
                 %wanscaler_client
                 %ws_stat
                 %cifs
                 %ftp
                 %http
                 %iperf
                 %wanscaler_install
                 TRUE
                 FALSE
                );
our @EXPORT = @_const;
1;