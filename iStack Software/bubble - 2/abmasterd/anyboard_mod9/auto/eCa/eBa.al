# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package eCa;

#line 102 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/eCa/eBa.al)"
sub eBa {
	my ($hash,$array, $regexp) = @_;
	my $w;
	for $w(keys %$hash) {
		push @$array,$w if $w =~ $regexp;
	}
}

# end of eCa::eBa
1;
