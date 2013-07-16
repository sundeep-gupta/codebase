#!/usr/local/bin/perl
 
# file: torture.pl
# Torture test Web servers and scripts by sending them large arbitrary URLs
# and record the outcome.
 
use Time::HiRes 'time','sleep';
use IO::Socket;
use IO::Pipe;
use POSIX 'WNOHANG';
use Getopt::Std;
use LWP::Simple;
use POSIX ":sys_wait_h";

use constant NO_MULTI_SESSION;

$USAGE = <<USAGE;
 Usage: $0 -[options] URL
    Torture-test Web servers and CGI scripts

  Options:
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
getopts('t:c:') || die $USAGE;

# get parameters
$URL    = shift || die $USAGE;
$TIMES  = $opt_t || 1;
$COPIES = $opt_c || 1;
$DELAY  = $opt_d || 0;
$POST   = $opt_P || 0;
$PATH   = $opt_p || 0;
$RAW    = $opt_r || 0;


## get the time
my $localtime = localtime();

print "** torture.pl version $VERSION starting at $localtime\n";
if($COPIES >1) {
   print "Here...";
    _run_multi($URL);
}else {
    print "in NO MULTI";
    _run($URL, NO_MULTI_SESSION);
}

print "** torture.pl version $VERSION ending at ",scalar localtime,"\n";
create_done();
exit 0;



sub _run_multi {
    $url = shift;
    for($i = 0;$i<$COPIES;$i++) {
       #  print ("Started $i...\n");
	die "Can't fork: $!" unless defined (my $pid = fork());
	# if parent, continue spawning children
	next if $pid;

	# otherwise we're a child, so we run the test once and exit
        _run($url, $i);
	exit 0;
    }
    # Wait till all child process gets killed... :)
   do {
       $kid = waitpid(-1,WNOHANG) ;
       sleep(1);
#       print $kid."\n";
    }until $kid == -1;
    
    # Calculate the Time and size values...
    $time = 0;
    $size = 0;
    for($i = 0;$i<$COPIES;$i++ ){
        open(FILE,"<HTTP_$i".".txt");
        @arr  = <FILE>;
        close(FILE);
        chomp($arr[0]);chomp($arr[1]);
        $time += $arr[0];
        $size += $arr[1];
        unlink("HTTP_$i".".txt");
    }
    open(FILE, "HTTP.txt");
    print FILE "$time\n$size";
    close(FILE);
}
sub _run {
     my $url = shift;
     my $iteration = shift;
$t = 0;
$tot_size = 0;
     for ($i = 0;$i<$TIMES;$i++) {
         @t1 = time;
         $content = get("$url");
#         print length($content)."\n";
         die "Couldn't get it!" unless defined $content;
         @t2 = time;
         $t = $t+@t2[0]-@t1[0] + (@t2[1]-@t1[1])/1000000;
         $tot_size = $tot_size+length($content);
     }
     $fileName = $iteration == NO_MULTI_SESSION?"HTTP.txt":"HTTP_$iteration".".txt";
     open(FILE,">$fileName");
     print FILE $t."\n".$tot_size;
     close(FILE);
     print "Process $iteration transferred $tot_size bytes in $t time\n";
}

sub create_done {
    $done_file = defined($opt_c) && $COPIES >1 ?"tcp_unaccel_done_${COPIES}.txt" :"tcp_unaccel_done.txt"  ;
    open(GOTOFILE,">$done_file");
    print GOTOFILE "done";
    close(GOTOFILE);
}
