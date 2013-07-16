# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 1904 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/eNaA.al)"
sub eNaA{
	my ($year, $mon, $offset) = @_;
	my $monall = $year * 12 + $mon -1;
	my $mon2 = $monall + $offset;
	my $y2 = int ($mon2/12);
	my $m2 = $mon2 % 12+1;
	return sprintf("%d%02d01000000", $y2, $m2);
}

# end of sVa::eNaA
1;
