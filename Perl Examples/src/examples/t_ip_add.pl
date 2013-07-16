use constant MIN_OCTET_VALUE => 1;
use constant MAX_OCTET_VALUE => 254;
$ip_addr = [172,254,254,253];
#$ip_addr = add_ip_address($ip_addr, $ARGV[0]);

$" = '.';
print "@{$ip_addr}";

@arr = (1,2,2); @arr3 = (3,3,43);
foreach $i (@arr,@arr3) {
	print $i;
}

$a = undef;
$b = 'a';
print "$b$a";

sub add_ip_address {
    my ($ip_addr,$increment) = @_;
    my @ip_addr = @$ip_addr;
    for (my $i=0;$i<$increment;$i++) {
	(++$ip_addr[3] > MAX_OCTET_VALUE) and
	( $ip_addr[3] = MIN_OCTET_VALUE and ++$ip_addr[2] > MAX_OCTET_VALUE) and
	( $ip_addr[2] = MIN_OCTET_VALUE and ++$ip_addr[1] > MAX_OCTET_VALUE) and
	( $ip_addr[1] = MIN_OCTET_VALUE and ++$ip_addr[0] > MAX_OCTET_VALUE);
    }
    return \@ip_addr;
}
