package WANScaler::Scalability::Config;
use strict;
#use Readonly;
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

our $CLIENT_LISTEN_PORT   		= 7050;
our $MAX_RPC_TIMEOUT	   		= 3600;
our $CLIENT_FILE_NAME   		= 'Clients.txt';
our $CIFS_TEST          		= 0x01;
our $FTP_TEST        		   	= 0x02;
our $HTTP_TEST        	  		= 0x04;
our $IPERF_TEST        	       		= 0x10;
our $ZPERF_TEST        	 		= 0x20;
our $SEED_INITIALIZER 			= 30;
our $MAX_RANDOM_VALUE 			= 1000000;
our $SCALE			   	= 1000000; # FOR MEGABIT
our $BYTE_TO_BIT 	   		= 8;
our $LOG_DIR		   		= ".\\Results\\" ; # MUST END WITH \\
our $MAX_OCTET_VALUE			= 250;
our $MIN_OCTET_VALUE			= 1;

####################### CIFS OPERATION CONSTANTS ###############################
our $CIFS_READ				= 0x01;
our $CIFS_WRITE				= 0x02;

###################### DATA TYPE CONSTANTS ####################################
our $UNCOMPRESSIBLE			= 0x01;
our $COMPRESSIBLE                       = 0x02;

###################### CONFIGURABLE CONSTANTS ##################################
our $TEST               	= $CIFS_TEST;
our $REBOOT_ALL_CLIENTS		= FALSE;
our $INSTALL_WANSCALER_CLIENT	= FALSE;
our $CONFIGURE_WANSCALER	= FALSE;
our $CAPTURE_CLIENT_METRICS 	= TRUE;
our $RESET_PERF_COUNTERS	= TRUE;

# CONFIG for WANScaler Client
our %wanscaler_client = (
			PARAMETER => {
                       #    	'Dbc.MaxPendingPerSpindle' 	=> 1,
  	               	#'System.VirtualClients' 	=> 50,
  	 	   #	 	'PacketPoolSize' 		=> 250000000,
                    #     	'Tcp.ActiveEndpoints'		=> 10000000,
   	     	      	 #  	'XmlRpc.OnlyFromLocalhost' => 'off',
				'SlowSendRate'				=> '5 M/S',
				'SlowRecvRate'				=> '5 M/S',
            #                    'UI.Softboost'				=> 'off'
				},
    			restart_service	=> 1
                       );

# GIVE METRICS THAT NEED TO BE CAPTURED AT RUNTIME...
our %ws_stat = (
		CPU 		=> TRUE,
                instances 	=> 30,
		);

#Readonly our $server_ip => '10.199.32.41';

#readonly our %ws_appliance_stat =>{
                           #   'appliane_ip'   => '10.199.32.63',
                           #    CPU  => TRUE,
                            #   instances 	=> 30,

                             #  };


our @static_ws_stat = ('CompressionRatioSend','CompressionRatioRecv');

our %cifs = (
		ip_address          => [172,32,2,65],
		share_name 		=> 'CIFS_Share0',
           	'share_start'		 => 0 ,   # Changed on 7821

		operation 		=> $CIFS_READ ,
		share_per_machine   => TRUE,
		#
		# No destination file name as we are assuming it to be same
		#
		'read'		=> {
					src_file_path  	=> 'LargeFile45',
				 src_files		=> 'ALL', # or array reference
				  #	src_files 	=> ['LargeFile.dat'],
					sessions 		=> 2,
#					read_to_null	=> TRUE,
                                        #ALWAYS WILL BE COPIED TO NUL.
				       },
		'write'		=> {
					src_file_path 	=> 'D:\\Scalability\\',
					src_files	=> ['Scalability.zip'],
					sessions 	=> 1,
					dst_file_path	=> 'test',
				       },
		data_type 		=> $UNCOMPRESSIBLE # COMPRESSIBLE -> 1 UNCOMPRESSIBLE -> 0
            );
our %ftp = (
            server 		=> '172.32.2.41',
            user_name   	=> 'Administrator',
	    password      	=> 'ARS!jr',
	    source_path 	=> '/', # Must terminate with /
            get_file_name	=> 'LargeFile.dat',
	    use_same_file 	=> 1,
	    sessions     	 => 100
                    );

 our %http = (
                    server_address => '172.32.2.41',
                    server_port     => '80', # DEFAULT
                    uri             => 'index.html',
                    use_same_file   => 1,
                    sessions        => 10,
                    );

 our %iperf = (
                   servers 		=> ['172.32.2.41'],
                   ports		=> [5001,5002,5003,5004,5005,5006,5007,5008,5009,5010],
                   'time'  		=> 180, # TIME has precedence over SIZE So comment it when using SIZE
#                   'size' 		=> 20000,
                   'random' 	=> FALSE,
                   'direction' 	=> SEND,
                   sessions		=> 50,
                     );


  our %zperf = (
                   servers 		=> ['172.32.2.41'],
                   ports		=> [6001,6002,6003,6004,6005,6006,6007,6008,6009,6010],
                   'time'  		=> 180, # TIME has precedence over SIZE So comment it when using SIZE
#                   'size' 		=> 20000,
                   'random' 	=> FALSE,
                   'direction' 	=> RECV,
                   sessions		=> 50,
                     );


 our %wanscaler_install = (
                   build 		 => '4.2.13-1',
                   type			 => 'release',
                   server		 => '10.200.2.103',
                   path			 => '/msi',
                   filename		 =>'WANScalerClientWin32-type-build.msi',
				);


my @_const = qw( $CIFS_TEST
                 $FTP_TEST
                 $HTTP_TEST
                 $IPERF_TEST
                 $ZPERF_TEST
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
                 %zperf
                 %wanscaler_install
                 TRUE
                 FALSE
                 SEND
                 RECV
                 SEND_RECV
                 @static_ws_stat
		 $MIN_OCTET_VALUE
		 $MAX_OCTET_VALUE
                 $COMPRESSIBLE
                 $UNCOMPRESSIBLE
                 $CIFS_READ
                 $CIFS_WRITE
                );
our @EXPORT = @_const;
1;