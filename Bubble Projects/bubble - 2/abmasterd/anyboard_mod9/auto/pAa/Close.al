# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/pAa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package pAa;

#line 163 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/pAa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/pAa/Close.al)"
sub Close
{
	my $me = shift;
 my $s;
	if ($me->Alive()) {
		$s = $me->{SOCK};
		print $s "QUIT", $me->EOL;
		shutdown($me->{SOCK}, 2) or $me->nIa("shutdown failed: $!") and return 0;
		close $me->{SOCK};
		$me->State('DEAD');
	}
	1;
} 

# end of pAa::Close
1;
