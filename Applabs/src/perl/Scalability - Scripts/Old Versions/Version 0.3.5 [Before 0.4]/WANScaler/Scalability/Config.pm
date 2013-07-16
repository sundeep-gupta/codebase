package WANScaler::Scalability::Config;
use strict;
use Readonly;
use vars qw(@EXPORT @ISA);
require Exporter;
our @ISA = ('Exporter');

use constant { 	TRUE => 1,
				FALSE => 0
             };

Readonly our $CIFS_TEST          => 0x01;
Readonly our $FTP_TEST           => 0x02;
Readonly our $HTTP_TEST          => 0x04;
Readonly our $IPERF_TEST         => 0x10;
Readonly our $TEST               => 0x00;
Readonly our $CLIENT_LISTEN_PORT	=> 7050;
Readonly our $MAX_RPC_TIMEOUT	=> 3600;
Readonly our $CLIENT_FILE_NAME   => 'Clients.txt';
Readonly our $CONFIGURE_WANSCALER=> FALSE;
Readonly our $SEED_INITIALIZER 	=> 30;
Readonly our $MAX_RANDOM_VALUE 	=> 1000000;
Readonly our $SCALE				=> 1000000; # FOR MEGABIT
Readonly our $BYTE_TO_BIT 		=> 8;
Readonly our $LOG_DIR			=> ".\\Results\\" ; # MUST END WITH \\

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
								'SlowSendRate'			=> '100 M/S',
								'SlowRecvRate'			=> '100 M/S',
#                                'UI.Softboost'			=> 'off'
							},

							restart_service	=> 1
                          };
Readonly our %cifs => {
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
                   server 	=> '172.32.2.41',
                   'time'  	=> 120, # TIME has precedence over SIZE So comment it when using SIZE
#                   'size' 	=> 20000,
                   'random' => TRUE,
                   sessions => 5
                     };


my @_const = qw( $CIFS_TEST
                 $FTP_TEST
                 $HTTP_TEST
                 $IPERF_TEST
                 $TEST
                 $CLIENT_LISTEN_PORT
				 $MAX_RPC_TIMEOUT
                 $CLIENT_FILE_NAME
                 $CONFIGURE_WANSCALER
                 $SEED_INITIALIZER
                 $MAX_RANDOM_VALUE
                 $SCALE
                 $BYTE_TO_BIT
                 $LOG_DIR
                 %wanscaler
                 %wanscaler_client
                 %cifs
                 %ftp
                 %http
                 %iperf
                 TRUE
                 FALSE
                );
our @EXPORT = @_const;
1;