# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 5449 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/eFaA.al)"
sub eFaA{
	my ($tostr) = @_;
	my $h = {};
	for my $to1 (split /\s*,\s*/, $tostr) {
		next if $to1 !~ /\S/;
		$h->{$to1} = 1;
	}
	return $h;
}

# end of jW::eFaA
1;
