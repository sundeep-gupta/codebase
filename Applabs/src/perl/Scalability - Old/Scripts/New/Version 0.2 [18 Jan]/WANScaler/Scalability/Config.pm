package WANScaler::Scalability::Config;
use strict;
use Readonly;
use vars qw(@EXPORT @ISA);
require Exporter;
our @ISA = ('Exporter');


my @_const = qw( $CLIENT_LISTEN_PORT $MAX_RPC_TIMEOUT $CLIENT_FILE_NAME
                 $CIFS_TEST $FTP_TEST $HTTP_TEST $TEST %cifs %ftp %http);

Readonly my $CIFS_TEST 		=> 0x01;
Readonly my $FTP_TEST		=> 0x02;
Readonly my $HTTP_TEST		=> 0x04;
Readonly my $TEST			=> $CIFS_TEST | $FTP_TEST | $HTTP_TEST;
Readonly my $CLIENT_LISTEN_PORT => 7050;
Readonly my $MAX_RPC_TIMEOUT  	=> 3600;
Readonly my $CLIENT_FILE_NAME 	=> 'Clients.txt';


Readonly my %cifs => {
					share_name 		=> 'CIFS_Share0',
                    read_file_path  => '',		# if given must end with \\
                    read_file_name 	=> 'LargeFile.dat',
                    ip_address		=> { network_address => [172,32,2],
                    					 host_address 	=> [30],
				                        },
                    sessions		=> 3,
                    use_same_file 	=> 1,
                    };

Readonly my %ftp => {
					ip_address		=> [172,32,2,41],
                    user_name		=> 'Administrator',
                    password		=> 'ARS!jr',
                    source_path 	=> '/root/', # Must terminate with /
					get_file_name 	=> 'LargeFile.dat',
                    use_same_file 	=> 1,
                    sessions		=> 3
                    };

Readonly my %http => {
					server_address  => '172.32.2.42',
                    server_port		=> '80', # DEFAULT
                    document_root	=> '/',
                    uri				=> 'myfile.asp',
                    use_same_file	=> 1,
                    sessions		=> 3
					 };

our @EXPORT = qw($CLIENT_LISTEN_PORT);
1;