# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/pAa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package pAa;

#line 317 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/pAa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/pAa/oMa.al)"
sub oMa {
	my $me = shift;
	my $s = $me->Socket;

	$me->Debug() and carp "POP3: oMa";
	print $s "STAT", $me->EOL;
	$_ = <$s>;
	/^\+OK/ or $me->nIa("STAT failed: $_") and return 0;
	/^\+OK (\d+) (\d+)/ and $me->Count($1), $me->Size($2);

 return $me->Count();
}

# end of pAa::oMa
1;
