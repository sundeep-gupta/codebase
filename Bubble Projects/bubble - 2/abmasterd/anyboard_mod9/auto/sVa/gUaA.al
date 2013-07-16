# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 896 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/gUaA.al)"
sub gUaA($) {
	my $s = shift;
	my $res = <$s>;
	if ($res =~ s/^(\d\d\d)-/$1 /) {
		my $nextline = <$s>;
		while ($nextline =~ s/^\d\d\d-//) {
			$res .= $nextline;
			$nextline = <$s>;
		}
		$nextline =~ s/^\d\d\d //;
		$res .= $nextline;
	}
	$Mail::Sender::LastResponse = $res;
	return $res;
}

# end of sVa::gUaA
1;
