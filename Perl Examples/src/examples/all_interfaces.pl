use strict;
use Data::Dumper;
use IO::Socket;
use Config;
require "net/if.ph";
require "sys/ioctl.ph";
require "sys/sockio.ph" unless defined &SIOCGIFCONF;
my $IFNAMSIZ = IFNAMSIZ();

my $sock = IO::Socket::INET->new('Proto' => 'udp');

print Dumper(&if_list($sock));

sub IFREQ_NAME { "Z$IFNAMSIZ x$IFNAMSIZ" } #name
sub if_list {

    my $sock = shift;
    my %sizeof = ('struct ifconf' => 2 * $Config{ptrsize},
                  'struct ifreq'  => 2 * IFNAMSIZ());
    my $ifreq_length = $sizeof{'struct ifreq'};
    my $buffer = "\0"x($ifreq_length*20);
    my $format = $Config{ptrsize} == 8 ? "ix4p" : "ip";
    my $ifclist = pack $format, length $buffer, $buffer;
    return unless ioctl($sock, SIOCGIFCONF(), $ifclist);
    my %interfaces;
    my $ifclen = unpack "i", $ifclist;
    for (my $start = 0; $start < $ifclen ; $start += $ifreq_length) {
        my $ifreq  = substr($buffer, $start, $ifreq_length);
        my $ifname = unpack(IFREQ_NAME, $ifreq);
        $interfaces{$ifname} = undef;
    }
    return sort keys %interfaces;
}
