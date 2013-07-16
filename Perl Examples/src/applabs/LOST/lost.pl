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
use Config::Auto;
use threads;

my $lost_config = Config::Auto::parse();
my %iperf = (
		 'servers' 	=> $lost_config->{'IPERF_SERVERS'},
         'ports'	=> $lost_config->{'IPERF_PORTS'},
         'sessions' => $lost_config->{'IPERF_SESSIONS'},
         'time' 	=> $lost_config->{'IPERF_TIME'},
         'random' 	=>($lost_config->{'IPERF_RANDOM'} =~ /YES/i)? TRUE: FALSE
		 );
my %zperf = (
		 'servers' 	=> $lost_config->{'ZPERF_SERVERS'},
         'ports'	=> $lost_config->{'ZPERF_PORTS'},
         'sessions' => $lost_config->{'ZPERF_SESSIONS'},
         'time' 	=> $lost_config->{'ZPERF_TIME'},
         'random' 	=>($lost_config->{'ZPERF_RANDOM'} =~ /YES/i)? TRUE: FALSE
		 );
my %http = (
		'server' => $lost_config->{'HTTP_SERVER'},
        'uri' 	 => $lost_config->{'HTTP_URI'},
        'sessions' => $lost_config->{'HTTP_SESSIONS'},
		);
my %ftp = (
		'server' => $lost_config->{'FTP_SERVER'},
        'username' => $lost_config->{'FTP_USERNAME'},
        'password' => $lost_config->{'FTP_PASSWD'},
        'binary' => ($lost_config->{'FTP_BINARY_MODE'} =~ /YES/i)? TRUE : FALSE,
        'get_file' => ($lost_config->{'FTP_GET'} and ($lost_config->{'FTP_GET'} =~ /YES/i) and $lost_config->{'FTP_GETFILE'}) ? $lost_config->{'FTP_GETFILE'} : undef,
        'put_file' => ($lost_config->{'FTP_PUT'} and ($lost_config->{'FTP_PUT'} =~ /YES/i) and $lost_config->{'FTP_PUTFILE'}) ? $lost_config->{'FTP_GETFILE'} : undef,
        'browse' => ($lost_config->{'FTP_BROWSE'} and $lost_config->{'FTP_BROWSE'} =~ /YES/i )? TRUE : FALSE,
        'sessions'=>$lost_config->{'FTP_SESSIONS'}
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
		WANScaler::LOSTLibrary->start_http_sessions(\%http);
        syswrite(\*STDOUT,"Restarting the sessions again...\n");
    }
}

sub start_ftp_in_loop {
	my ($options) = @_;
    while(1) {
    	print Dumper(\%ftp);
		WANScaler::LOSTLibrary->start_ftp_sessions(\%ftp)  ;
        syswrite(\*STDOUT,"Restarting FTP sessions again...\n");
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
    	    	$iperf_threads[$i] = threads->new(\&iperf_send,$iperf,$seed);
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
sub iperf_send {
	my ($iperf_options,$seed) = @_;
	while(1) {
    	syswrite(\*STDOUT,"Starting...\n");
    	WANScaler::IPerfLibrary->iperf_send($iperf_options,$seed);
        syswrite(\*STDOUT,"Restarting the sessions again...\n");
    }
}

sub start_zperf_in_loop {
	my ($options) = @_;
    my (@zperf_threads);
    while(1) {
       my @zperf_servers = @{$options->{'servers'}};
       my $i = 0;
    	foreach my $server (@zperf_servers) {
	    	foreach my $port (@{$options->{'ports'}}) {
       			my $zperf = {
						'server' => $server,
                        'port' => $port,
                        'sessions' => $options->{'sessions'},
                        'random' =>$options->{'random'},
                        'time' => $options->{'time'},
            			};
                my $seed = int rand MAX_RANDOM;
    	    	$zperf_threads[$i] = threads->new(\&zperf_recv,$zperf,$seed);
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
sub zperf_recv {
	my ($zperf_options,$seed) = @_;
	while(1) {
    	syswrite(\*STDOUT,"Starting...\n");
    	WANScaler::IPerfLibrary->iperf_recv($zperf_options,$seed);
        syswrite(\*STDOUT,"Restarting the sessions again...\n");
    }
}