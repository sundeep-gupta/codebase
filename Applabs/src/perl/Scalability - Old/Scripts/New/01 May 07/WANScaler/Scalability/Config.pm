package WANScaler::Scalability::Config;
use strict;
use Readonly;
use vars qw(@EXPORT @ISA);
require Exporter;
our @ISA = ('Exporter');

use constant { 	TRUE 		=> 1,
				FALSE 		=> 0,
                SEND 		=> 1,
                RECV		=> 2,
                SEND_RECV 	=> 3
             };
################# CONSTNATS THAT RARELY REQUIRE CONFIGURATION ##################

Readonly our $CLIENT_LISTEN_PORT   		=> 7050;
Readonly our $MAX_RPC_TIMEOUT	   		=> 3600;
Readonly our $CLIENT_FILE_NAME   		=> 'Clients.txt';
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
Readonly our $REBOOT_ALL_CLIENTS		=> FALSE;
Readonly our $INSTALL_WANSCALER_CLIENT	=> FALSE;
Readonly our $CONFIGURE_WANSCALER		=> FALSE;
Readonly our $CAPTURE_CLIENT_METRICS 	=> TRUE;
Readonly our $RESET_PERF_COUNTERS		=> TRUE;


# CONFIG for WANScaler Client
Readonly our %wanscaler_client => {
							PARAMETER => {
  #                          	'Dbc.MaxPendingPerSpindle' 	=> 1,
   #								'System.VirtualClients' 	=> 100,
   #	 							'PacketPoolSize' 			=> 250000000,
   #                            'Tcp.ActiveEndpoints'		=> 10000000,
   #	     				   	 	'XmlRpc.OnlyFromLocalhost' => 'off',
							  	'SlowSendRate'				=> '50 K/S',
							    'SlowRecvRate'				=> '50 K/S',
   #                           'UI.Softboost'				=> 'off'
							},

							restart_service	=> 1
                          };

# GIVE METRICS THAT NEED TO BE CAPTURED AT RUNTIME...
Readonly our %ws_stat => {
						CPU 		=> TRUE,
                        instances 	=> 30,
					};
Readonly our @static_ws_stat => ('CompressionRatioSend','CompressionRatioRecv');

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
                      user_name   	=> 'Administrator',
	                  password      => 'ARS!jr',
	                  source_path   => '/', # Must terminate with /
                      get_file_name => 'LargeFile.dat',
	                  use_same_file => 1,
	                  sessions      => 2
                    };

Readonly our %http => {
                    server_address => '172.32.2.41',
                    server_port     => '80', # DEFAULT
                    uri             => 'index.html',
#                    use_same_file   => 1,
                    sessions        => 10
                    };

Readonly our %iperf => {
                   servers 		=> ['172.32.2.41','172.32.2.42'],
                   ports		=> [6001,6002,6003,6004,6005],
                   'time'  		=> 180, # TIME has precedence over SIZE So comment it when using SIZE
#                   'size' 		=> 20000,
                   'random' 	=> FALSE,
                   'direction' 	=> RECV,
                   sessions		=> 50,
                     };
Readonly our %wanscaler_install => {
                   build 		 => '4.1.2.0',
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
                 $CLIENT_FILE_NAME
                 $REBOOT_ALL_CLIENTS
                 $CONFIGURE_WANSCALER
                 $SEED_INITIALIZER
                 $MAX_RANDOM_VALUE
                 $CAPTURE_CLIENT_METRICS
                 $RESET_PERF_COUNTERS
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
                 SEND
                 RECV
                 SEND_RECV
                 @static_ws_stat
                );
our @EXPORT = @_const;
1;