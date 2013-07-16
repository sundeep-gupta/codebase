 use Socket  ;   #defines PF_INET and SOCK_STREAM
use Data::Dumper;
use IO::Socket::INET;
use IO::Socket;
my $socket = IO::Socket::INET->new(Proto=>'udp') or die "Error creating socket $!";
my @ifs = $socket->if_list;
print @ifs;
print "\n";
exit;

print ((getprotobyname('tcp'))[2]);
print '-' x 20;
socket(SOCKET,AF_INET,SOCK_STREAM,0);
ioctl(SOCKET, SIOCGLIFFLAGS, $ifconf);
print $!;
print Dumper($ifconf);