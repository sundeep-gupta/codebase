package IO::Interface;

use strict;
use Carp 'croak';
use Config;

use vars qw (@EXPORT @EXPORT_OK @ISA %EXPORT_TAGS $VERSION %sizeof);

require Exporter;

my @functions = qw(if_addr if_broadcast if_netmask if_dstaddr if_hwaddr if_flags if_list);
my @flags     = qw(IFF_ALLMULTI IFF_AUTOMEDIA IFF_BROADCAST IFF_DEBUG IFF_LOOPBACK IFF_MASTER IFF_MULTICAST IFF_NOARP IFF_NOTRAILERS IFF_POINTOPOINT IFF_PORTSEL IFF_PROMISC IFF_RUNNING IFF_SLAVE IFF_UP);
%EXPORT_TAGS = (
		'all' => [@functions, @flags],
        'functions' => \@functions,
        'flags'  => \@flags,
);

@EXPORT_OK = ( @{$EXPORT_TAGS{'all'}});

@EXPORT = qw();

@ISA = qw(Exporter);

$VERSION = '0.01';

require Socket;
Socket->import('inet_ntoa');
require 'net/if.ph';
require 'sys/ioctl.ph';
require 'sys/sockio.ph' unless defined &SIOCGIFCONF;
%sizeof = {'struct ifconf' => 2 * $Config{ptrsize},
           'struct ifreq'  => 2 * IFNAMSIZ()};


my IFNAMSIZ = IFNAMSIZ();
my $IFHWADDRLEN = defined &IFHWADDRLEN ? IFHWADDRLEN() :6;
sub IFREQ_NAME { "Z$IFNAMSIZ x$IFNAMSIZ" } # name
sub IFREQ_ADDR { "Z$IFNAMSIZ s x2 a4"    } # retrieve IP Address
sub IFREQ_ETHER {"Z$IFNAMSIZ s C$IFHWADDRLEN" } 
sub IFREQ_FLAG { "Z$IFNAMSIZ s"}

{
  no strict 'refs'
  * {"IO\:\:Socket\:\:$_"} = \&$_ foreach @functions;
}

1;
