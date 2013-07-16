# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 1836 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/yPa.al)"
sub yPa{
	my ($to_str, $kQz) = @_;

	for my $to (split /\s*,\s*|\n/, $to_str) {
		$to =~ s/^\s*//;
		$to =~ s/\s*$//;
		return 1 if lc($kQz) eq lc($to);
 }
	return;
}

# end of sVa::yPa
1;
