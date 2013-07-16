# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/pAa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package pAa;

#line 93 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/pAa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/pAa/Host.al)"
sub Host
{
 my $me = shift;
	my $host = shift or return $me->{HOST};

 my $addr;
 
 if ($host =~ /^(\d+)\.(\d+)\.(\d+)\.(\d+)$/) {
		$addr = inet_aton($host);
 	        my $tmp = gethostbyaddr ($addr, AF_INET); 
 $me->{HOST}=$tmp || $host;
 } else {
		$addr = gethostbyname ($host) or
		$me->nIa("Could not gethostybyname: $host, $!") and return;
 $me->{HOST}= $host;
 }

 $me->{ADDR} = $addr;
 1;
} 

# end of pAa::Host
1;
