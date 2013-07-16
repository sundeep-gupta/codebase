# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/pAa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package pAa;

#line 411 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/pAa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/pAa/pGa.al)"
sub pGa {
 my $me = shift;
	my $gP = shift || return;

	my $s = $me->Socket;
	print $s "DELE $gP",  $me->EOL;
	$_ = <$s>;
	$me->nIa($_);
	/^\+OK / && return 1;
	return 0;
}

1;

1;
# end of pAa::pGa
