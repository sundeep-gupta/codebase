# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2796 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/sFa.al)"
sub sFa{
	my ($to_str, $kQz) = @_;
	for my $to (split /\s*,\s*/, $to_str) {
		return 1 if lc($kQz) eq lc($to);
 }
	return;
}

# end of jW::sFa
1;
