use strict;
use Data::Dumper;

use WANScaler::HTTPLibrary;
use WANScaler::FTPLibrary;
use WANScaler::IPerfLibrary;

use constant TRUE => 1;
use constant FALSE => 0;
use constant SLEEP_TIME => 5; # in seconds
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
        'browse' => ($lost_config->{'FTP_BROWSE'} and $lost_config->{'FTP_BROWSE'} =~ /YES/i )? TRUE : FALSE
		);
print Dumper(\%ftp);
my $iperf_test = threads->new(\&start_iperf_in_loop, undef,\%iperf) if ($lost_config->{'IPERF_TEST'} =~ /YES/i);
$iperf_test->join;
print "Done\n";

sub start_iperf_in_loop {
	my ($package, $options) = @_;
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
    	    	$iperf_threads[$i] = threads->new(\&WANScaler::IPerfLibrary::iperf_send, undef,$iperf);
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