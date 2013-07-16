#!/usr/local/bin/perl
 
# file: torture.pl
# Torture test Web servers and scripts by sending them large arbitrary URLs
# and record the outcome.
 
use Time::HiRes 'time','sleep';
use IO::Socket;
use IO::Pipe;
use POSIX 'WNOHANG';
use Getopt::Std;

$USAGE = <<USAGE;
 Usage: $0 -[options] URL
    Torture-test Web servers and CGI scripts

  Options:
    -l <integer>  Max length of random URL to send       [0 bytes]
    -t <integer>  Number of times to run the test        [1]
    -c <integer>  Number of copies of program to run     [1]
    -d <float>    Mean delay between serial accesses     [0 sec]
    -P            Use POST method rather than GET method
    -p            Attach random data to path rather than query string
    -r            Send raw (non-escaped) data
USAGE
    ;
$VERSION = '1.05';
 
# process command line
getopts('l:t:c:d:Pprx') || die $USAGE;
 
# get parameters
$URL    = shift || die $USAGE;
$MAXLEN = $opt_l || 0;
$TIMES  = $opt_t || 1;
$COPIES = $opt_c || 1;
$DELAY  = $opt_d || 0;
$POST   = $opt_P || 0;
$PATH   = $opt_p || 0;
$RAW    = $opt_r || 0;


# cannot do both a post and a path at the same time
$POST = 0 if $PATH;

# the %ESCAPES global is used by the escape() function
for (0..255) { $ESCAPES{chr($_)} = sprintf("%%%02X", $_) }

# get the time
my $localtime = localtime();

print "** torture.pl version $VERSION starting at $localtime\n";

# first we run the dummy test, then we run it for real
my $dummy = do_stats(0);
my $real  = do_stats(1);

# adjust elapsed and transaction time to reflect overhead from test
$real->{elapsed}    -= $dummy->{elapsed};
$real->{trans_time} -= $dummy->{trans_time};

print_results($real);
print "** torture.pl version $VERSION ending at ",scalar localtime,"\n";
create_done();
exit 0;

sub do_stats {
    my $doit = shift;
    my $start = time();

    # open a pipe so that child processes can send results to parent.
    my $pipe = IO::Pipe->new || die "Can't pipe: $!";
    for (my $i=0; $i<$COPIES; $i++) {
	die "Can't fork: $!" unless defined (my $pid = fork());
	# if parent, continue spawning children
	next if $pid;  

	# otherwise we're a child, so we run the test once and exit
	$pipe->writer; select $pipe;
	run_test($doit);
	exit 0;
    }

    # otherwise, parent reads and tallies the results
    $SIG{CHLD} = sub { do {} while waitpid(-1,WNOHANG) > 0; };
    $pipe->reader;

    my $stats = tally_results($pipe);
    $stats->{elapsed} = time() - $start;
    return $stats;
}

# This subroutine is called to tally up the test results
# from all the children.
sub tally_results {
    my $pipe = shift;
    my (%STATUS,$TIME,$BYTES,$COUNT);
    while (<$pipe>) {
	chomp;
	my ($child,$time,$bytes,$code) = split("\t");
	$COUNT++;
	$STATUS{$code}++;
	$TIME  += $time;
	$BYTES += $bytes;
    }
    return { 
	count      => $COUNT,
	trans_time => $TIME,
	bytes      => $BYTES,
	status     => \%STATUS
    };
} 

sub run_test {
    my $doit = shift;
    for (1..$TIMES) {
 	sleep(rand $DELAY) if $DELAY;

	# create a string of random stuff
	my $garbage = random_string(rand $MAXLEN) if $MAXLEN > 0;
	$garbage    = escape($garbage) unless $RAW;

	my @parameters;
      CASE: {
	  if (length($garbage) == 0) {
	      @parameters = ($URL);
	      last CASE;
	  }
      
	  if ($POST) {
	      @parameters = ($URL,$garbage);
	      last CASE;
	  }

	  if ($PATH) {
	      chop($url) if substr($url,-1,1) eq '/';
	      @parameters = ("$URL/$garbage");
	      last CASE;
	  }
      
	  @parameters = ("$URL?$garbage");
      }
    
	my ($status,$message,$contents);
    
	my $start = time();

	($status,$message,$contents) = fetch(@parameters) if     $doit;
	($status,$message,$contents) = (200,'','')        unless $doit;

	my $elapsed = time() - $start;
	my $bytes = length($garbage) + length($contents);

	warn "$$: ",$message,"\n" if $status >= 500;
	print join("\t",$$,$elapsed,$bytes,$status),"\n";
    }
}

# return some random data of the requested length
sub random_string {
    my $length = shift;
    my $string = ' ' x $length;
    for (my $i=0;$i<$length;$i++) {substr($string,$i,1) = chr(rand(255)); }
    return $string;
}

# replacement for URI::escape
sub escape {
    my $s = shift;
    $s =~ s/([^;\/?:@&=+\$,A-Za-z0-9\-_.!~*\'()])/$ESCAPES{$1}/g;
    return $s;
}

# Quick & dirty http client
sub fetch {
    my ($url,$content,$content_type) = @_;
    $content_type ||= 'application/octet-stream' if $content;

    # parse out the URL in a simple fashion
    my ($nethost,$request) = $url =~ m!^http://([^/]+)(.*)!;
    $nethost = $nethost . ':80' unless $nethost=~/:\d+$/;

    my ($bare_nethost) = $nethost =~ /([^:]+)/;

    $request ||= '/';

    # try to make connection with remote host
    IO::Socket->input_record_separator("\r\n\r\n");
    my $h = IO::Socket::INET->new($nethost);
    return (503,'Connection refused') unless $h;

    # send the request
    if ($content) {
	$h->print ("POST $request HTTP/1.1\r\n");
	$h->print ("Host: $bare_nethost\r\n");
	$h->print ("Content-type: $content_type\r\n");
	$h->print ("Content-length: ",length($content),"\r\n\r\n");
	$h->print ($content);
    } else {
	$h->print ("GET $request HTTP/1.1\r\n");
	$h->print ("Host: $bare_nethost\r\n\r\n");
    }

    # read the header

    $header = $h->getline;
    my ($status_line,%fields) = split(/^([-\w]+):/m,$header);
    my ($status,$message) = $status_line =~ m!http/1\.\d+\s+(\d+)\s+(.*)$!i;
    return (400,"malformed header") unless $status;

    # read the document body, if any
    my ($data,$doc_body);
    do { $doc_body .= $data } while $h->read($data,1024);
    
    $h->close;
    return ($status,$message,$doc_body);
}

# print the results
sub print_results {
    my $s = shift;
    my $throughput       = sprintf "%3.2f",$s->{bytes}      / $s->{elapsed};
    my $resp_time        = sprintf "%3.2f",$s->{trans_time} / $s->{count};
    my $trans_rate       = sprintf "%3.2f",$s->{count}      / $s->{elapsed};
    my $concurrency      = sprintf "%3.1f",$s->{trans_time} / $s->{elapsed};
    my $elapsed          = sprintf "%3.3f",$s->{elapsed};
    
    $out_file_name = "tcp_unaccel.txt";
    if(defined($opt_c)){
        $out_file_name = "tcp_unaccel_${opt_c}.txt";
    }
    open(FILE,">$out_file_name");
    print FILE <<EOF;
Transactions:           $s->{count}
Elapsed time:           $elapsed sec
Bytes Transferred:      $s->{bytes} bytes
Response Time:          $resp_time sec
Transaction Rate:       $trans_rate trans/sec
Throughput:             $throughput bytes/sec
Concurrency:            $concurrency
EOF
    for my $code (sort {$a <=> $b} keys %{$s->{status}}) {
	print FILE "Status Code $code:        $s->{status}->{$code}\n";
    }
    close(FILE);

}


sub create_done {
    $done_file = defined($opt_c) ?"tcp_unaccel_done_${COPIES}.txt" :"tcp_unaccel_done.txt"  ;
    open(GOTOFILE,">$done_file");
    print GOTOFILE "done";
    close(GOTOFILE);
}
