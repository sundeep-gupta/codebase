use IO::Socket;
use Carp;
use Getopt::Std;
use threads;
use XMLRPC::Lite;
use Frontier::Client;
use Data::Dumper;

use constant PORT => 7000;

my $iperf_time = 240;
my $iperf_session = 1;
my $iperf_server = '172.32.2.42';
my $sessions = 40;
my $server = 111;
my $passthrough = 0;

open(FH,"newservers.txt");
my @servers = <FH>;
close(FH);
my @thr;
for($i=0;$i<$sessions;$i++) {
#	my $ret = set_passthrough($servers[$i],$passthrough);
#	print Dumper($ret->{'Value'});
    sleep(1) ;
	print $i%2;
	$iperf_server =  ( $i-(int(($i/2))*2) == 1)?'172.32.2.41':'172.32.2.42';
#	syswrite(\*STDOUT,$servers[$i]);
    $thr[$i] = threads->new(\&tcp_generate,$servers[$i],$iperf_server,$iperf_time,$iperf_session, $i+1 );

}
my %ret = ();
    open(FH,'>'.$sessions.' - results.txt');
	syswrite(\*STDOUT,'Waiting for test to complete...');
   my $sum = 0;
   my $j = 0;
foreach $i (@thr) {
    $ret{$i->tid} = $i->join;
	chomp( $servers[$j]);
    syswrite(\*FH,"\n\r".$i->tid." - $servers[$j++] - ".$ret{$i->tid});
    $sum += $ret{$i->tid} if $ret{$i->tid} ;
}
	syswrite(\*FH,"\r\n Total - $sum");
    close(FH);
    syswrite(\*STDOUT,'Done');

sub tcp_generate {
 ($server,$iperf_server,$iperf_time,$iperf_session,$seed) = @_;
    my $iperf_response = '';
    # Create a new socket
    my $sock = new IO::Socket::INET (
                                 PeerAddr => $server,
                                 PeerPort => PORT,
                                 Proto => 'tcp',
                                );
    # Send messages in chunks
    if(readline($sock) == "Yes\n") {
#    	syswrite(\*STDOUT,"$server - iperf -c $iperf_server -t $iperf_time -P $iperf_session -f m \n");
       	syswrite($sock,"100 - iperf -c $iperf_server -t $iperf_time -P $iperf_session -f m \n");
#       	syswrite($sock,"100 - copy \\\\10.199.32.112\\Build\\iperf.exe C:\\Windows\\iperf.exe /y\n");
        my $ret;

        while(($ret = sysread($sock,$_,80)) > 0) {
   			$iperf_response = $iperf_response.$_;
            last if $_ =~ /Done sending to client/;
#	       	syswrite(\*STDOUT,$_);

      }
    } else {
    	syswrite(\*STDOUT,$server."- i didn't get Yes\n");
    }
	syswrite(\*STDOUT,"Closed $server\n");
    close($sock);
#    return $iperf_response;
    my @response = split(/\n/,$iperf_response);
    foreach (@response) {
    	if($iperf_session == 1) {
	    	if( ($_ =~ /^\[\d+\]/ ) and ($_ =~ /\s+(\d+\.?\d*)\s+Mbits\/sec/)){
    	        $_ =~ /\s+(\d+\.?\d*)\s+Mbits\/sec/;
        	    return $1;
	        }
        } else {
   	    	if( ($_ =~ /^\[\s*SUM\s*\]/ ) and ($_ =~ /\s+(\d+\.?\d*)\s+Mbits\/sec/)){
    	        $_ =~ /\s+(\d+\.?\d*)\s+Mbits\/sec/;
        	    return $1;
	        }

        }
    }
    return $iperf_response;
}

sub set_passthrough {
my $ip = shift;
my $passthrough = shift;
my $Response = XMLRPC::Lite->proxy("http://$ip:2050/RPC2")
		->call('Set', {Class => "PARAMETER", Attribute => "Passthrough" ,Value=>$passthrough})
		->result;
return $Response;

}