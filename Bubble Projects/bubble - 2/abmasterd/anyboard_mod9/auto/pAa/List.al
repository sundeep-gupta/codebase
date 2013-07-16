# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/pAa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package pAa;

#line 330 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/pAa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/pAa/List.al)"
sub List {
 my $me = shift;
	my $gP = shift || '';

	my $s = $me->Socket;
	$me->Alive() or return;

	my @retarray = ();

	$me->Debug() and carp "POP3: List $gP";
	$gP = " $gP" if $gP ne "";
	print $s "LIST$gP", $me->EOL;
	$_ = <$s>;
	/^\+OK/ or $me->nIa("$_") and return;
	if ($gP) {
		$_ =~ s/^\+OK\s*//;
		return $_;
	}
	while(<$s>) {
		/^\.\s*$/ and last;
		/^0\s+messag/ and last;
		chop;
		push(@retarray, $_);
	}
	return @retarray;
}

# end of pAa::List
1;
