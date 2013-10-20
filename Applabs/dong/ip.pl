#!/tools/bin/perl

=head1 NAME

ip: 
tests a multitude of ip packet types.

=head1 SYNOPSIS

/tools/bin/perl ip 10.0.111.11

=head1 DESCRIPTION

=head2 Overview

ip is a frontend to nemesis, a command line Unix packet injection engine
available from www.packetfactory.net.

 
IP Packet Injection -=- The NEMESIS Project Version 1.4beta3 (Build 22)
 
IP Usage:
  ip [-v (verbose)] [options]
 
IP Options:
  -S <Source IP address>
  -D <Destination IP address>
  -I <IP ID>
  -p <IP protocol number>
  -T <IP TTL>
  -t <IP TOS>
  -F <IP fragmentation options>
     -F[D],[M],[R],[offset]
  -O <IP options file>
  -P <Payload file>
 
Data Link Options:
  -d <Ethernet device name>
  -H <Source MAC address>
  -M <Destination MAC address>


=head2 Test Category

The  test spews out individual ip packets ranging over a wide variety of
flags, settings and higher level protocols.

=head1 ENVIRONMENT

This test will run on most Unix variants. It is built on top of the libnet packet injection 
suite, which is currently unavailable for windows. 

The test runs off the commnand line and needs no special environment settings.

=head1 BUGS

This suite consists of over 74k individual tests. It takes a great deal of time to complete.

=head1 FILES

/tools/nemesis/ip

/tools/nemesis/run_ip

=head1 SEE ALSO

http://www.packetfactory.net

=head1 Authors

steve latif
Dong (3/05) modify to skip the IP # test

=head1 COPYRIGHT


=cut 


#use Test::More  qw(no_plan); # the number of tests
use Test::More  tests => 74007 ; # the number of tests
#use Test::More  tests => 8472 ; # less the case of ID# 
#use lib '/tools/lib/perl5/site_perl/5.8.4';
use Carp ;
use Getopt::Std ;
#use Net::RawIP qw ( :pcap) ;


####################
getopt ("c s") ;
if (  !$opt_s  || !$opt_c) {
  print "usage: ip.pl -c <local host> -s <remote host>  \n" ;
  exit 1 ;
}
my $host = $opt_s ;
chomp ($host ) ;
my $client = $opt_c;
chomp ($client);
####################

is(nemesis_scan($host , " -S $client  " ) , 1, "NEMESIS ip: simple packet") ;


foreach my $t ( 1 .. 127 ) {
  is(nemesis_scan($host , " -S $client -p $t") , 1, "NEMESIS ip: simple packet, Protocol number : $t" ) ;
}


foreach my $t ( 1 .. 127 ) {
  is(nemesis_scan($host , " -S $client -T $t") , 1, "NEMESIS ip: simple packet, TTL : $t" ) ;
}

foreach my $t ( 1 .. 127 ) {
  is(nemesis_scan($host , " -S $client -t $t") , 1, "NEMESIS ip: simple packet, TOS : $t" ) ;
}

foreach my $t ( 1 .. 8090 ) {
  is(nemesis_scan($host , " -S $client -F $t") , 1, "NEMESIS ip: simple packet, Fragmentation offset : $t" ) ;
}

foreach my $t ( 1 .. 65535 ) {
  is(nemesis_scan($host , " -S $client -I $t") , 1, "NEMESIS ip: simple packet, IP id: $t" ) ;
}

#--------------------------------------------------------------
sub nemesis_scan
  {
    my $host = shift ;
    my $args = shift ;
    my $invoke = "/tools/bin/nemesis ip  $args -D $host -v" ;
    my $ip = `$invoke` ;
    my $ping  = `ping -c 1 $host ` ;
    if ( ( $ip =~ /.*Wrote.*/gxms) && ( $ping =~/.*1\W+received.*/gxms)  ) {
      return 1 ;
    } else { return  0 ; }
  }

