# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/pAa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package pAa;

#line 357 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/pAa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/pAa/mHa.al)"
sub mHa{
 my $me = shift;
	my $gP = shift || '';

	my $s = $me->Socket;
	$me->Alive() or return;

	my @retarray = ();

	$me->Debug() and carp "POP3: UIDL $gP";
	my $num2 ="";
 $num2 = " $gP" if $gP ne "";
	print $s "UIDL$num2", $me->EOL;
	$_ = <$s>;
	/^\+OK/ or $me->nIa("$_") and return;
	if ($gP) {
		$_ =~ s/^\+OK\s*\d+\s+//;
		$_ =~ s/\s*$//;
		return {$gP=>$_};
	}
 my $uids= {};
	while(<$s>) {
		/^\.\s*$/ and last;
		/^0\s+messag/ and last;
		$_ =~ s/\s*$//;
		my ($cG, $gJz) = split /\s+/, $_;
		if($cG) {
			$uids->{$cG} = $gJz;
		}
	}
	return $uids;
}

# end of pAa::mHa
1;
