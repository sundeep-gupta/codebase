# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 8400 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/nVa.al)"
sub nVa{
	my ($str) = @_;
	my @uids = split /\n+|\|/, $str;
	my %ighash=();
	for(@uids) {
		abmain::jJz(\$_);
		next if not $_;
		$ighash{lc($_)} = 1;
	}
	return %ighash;
}

# end of jW::nVa
1;
