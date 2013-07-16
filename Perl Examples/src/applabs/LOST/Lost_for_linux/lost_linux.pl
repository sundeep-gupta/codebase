use strict;
use Data::Dumper;

use WANScaler::HTTPLibrary;
use WANScaler::FTPLibrary;
use WANScaler::IPerfLibrary;
use WANScaler::LOSTLibrary;

use constant TRUE => 1;
use constant FALSE => 0;
use constant SLEEP_TIME => 1; # in seconds
use constant SEED => 20;
use constant MAX_RANDOM => 1000000;

use threads;

my $lost_config = {
				'IPERF_TEST' => 'YES',
                'FTP_TEST' => 'NO',
                'ZPERF_TEST' => 'NO',
                'HTTP_TEST' => 'NO',
                'CIFS_TEST' => 'NO',
				};

my %iperf = (
		 'servers' 	=> [172.16.2.34,172.16.2.34],
         'ports'	=> [5001,1002],
         'sessions' => 10,
         'time' 	=> 30,
         'random' 	=> FALSE
		 );
my %zperf = (
		 'servers' 	=> [172.16.2.34,172.16.2.34],
         'ports'	=>  [5001,1002],
         'sessions' => 10,
         'time' 	=> 30,
         'random' 	=> FALSE
		 );
my %http = (
		'server' => '172.16.2.34',
        'uri' 	 => 'unique',
        'sessions' => 10,
		);
my %ftp = (
		'server' => '172.16.2.34',
        'username' => 'root',
        'password' => 'ARS!jr',
        'binary' =>  FALSE,
        'get_file' => 'abc.txt',
        'put_file' => undef,
        'browse' =>  FALSE
		);
print Dumper(\%ftp);
srand(SEED);
my $iperf_test = threads->new(\&start_iperf_in_loop, \%iperf) if ($lost_config->{'IPERF_TEST'} =~ /YES/i);
my $zperf_test = threads->new(\&start_zperf_in_loop, \%zperf) if ($lost_config->{'ZPERF_TEST'} =~ /YES/i);
my $http_test  = threads->new(\&start_http_in_loop, \%http)   if ($lost_config->{'HTTP_TEST'} =~ /YES/i);
my $ftp_test   = threads->new(\&start_ftp_in_loop, \%ftp) 	  if ($lost_config->{'FTP_TEST'} =~ /YES/i);
$zperf_test->join if ($lost_config->{'ZPERF_TEST'} =~ /YES/i);
$iperf_test->join if ($lost_config->{'IPERF_TEST'} =~ /YES/i);
$ftp_test->join if ($lost_config->{'FTP_TEST'} =~ /YES/i);
$http_test->join if ($lost_config->{'HTTP_TEST'} =~ /YES/i);
print "Done\n";

sub start_http_in_loop {
	my ($options) = @_;
    while(1) {
		my $http_thread = threads->new(\&WANScaler::LOSTLibrary::start_http_sessions, undef, \%http);
        $http_thread->join;
    }
}

sub start_ftp_in_loop {
	my ($options) = @_;
    while(1) {
		my $ftp_thread = threads->new(\&WANScaler::LOSTLibrary::start_ftp_sessions, undef, \%ftp)  ;
        $ftp_thread->join;
    }
}

sub start_iperf_in_loop {
	my ( $options) = @_;
    my (@iperf_threads);
    while(1) {
       my @iperf_servers = @{$options->{'servers'}};
       my $i = 0;
    	foreach my $server (@iperf_servers) {
	    	foreach my $port (@{$options->{'ports'}}) {
       			my $iperf = {
						'server' => $server,
                        'port' => $port,
                        'sessions' => $options->{'sessions'},
                        'random' =>$options->{'random'},
                        'time' => $options->{'time'},
            			};
                my $seed = int rand MAX_RANDOM;
    	    	$iperf_threads[$i] = threads->new(\&WANScaler::IPerfLibrary::iperf_send, undef,$iperf,$seed);
        	    sleep( int rand(SLEEP_TIME) );
                $i++;
	        }
        }
        foreach my $iperf_thread (@iperf_threads) {
        	$iperf_thread->join;
            print "\n Joined";
        }
     }
	return;
}

sub start_zperf_in_loop {
	my ($options) = @_;
    my (@zperf_threads);
    while(1) {
       my @zperf_servers = @{$options->{'servers'}};
       my $i = 0;
    	foreach my $server (@zperf_servers) {
	    	foreach my $port (@{$options->{'ports'}}) {
       			my $iperf = {
						'server' => $server,
                        'port' => $port,
                        'sessions' => $options->{'sessions'},
                        'random' =>$options->{'random'},
                        'time' => $options->{'time'},
            			};
                my $seed = int rand MAX_RANDOM;
    	    	$zperf_threads[$i] = threads->new(\&WANScaler::IPerfLibrary::iperf_recv, undef,$iperf,$seed);
        	    sleep( int rand(SLEEP_TIME) );
                $i++;
	        }
        }
        foreach my $zperf_thread (@zperf_threads) {
        	$zperf_thread->join;
            print "\n Joined";
        }
     }
	return;
}