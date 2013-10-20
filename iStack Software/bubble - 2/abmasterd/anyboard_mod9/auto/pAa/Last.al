# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/pAa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package pAa;

#line 390 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/pAa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/pAa/Last.al)"
sub Last {
 my $me = shift;
	
	my $s = $me->Socket;
	
	print $s "LAST", $me->EOL;
	$_ = <$s>;
	
	/\+OK (\d+)\s*$/ and return $1;
}

# end of pAa::Last
1;
