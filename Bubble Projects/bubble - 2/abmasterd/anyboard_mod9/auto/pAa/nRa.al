# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/pAa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package pAa;

#line 401 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/pAa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/pAa/nRa.al)"
sub nRa {
 my $me = shift;
	
	my $s = $me->Socket;
	print $s "RSET", $me->EOL;
	$_ = <$s>;
	/\+OK .*$/ and return 1;
	return 0;
}

# end of pAa::nRa
1;
