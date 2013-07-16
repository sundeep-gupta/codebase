# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/bAa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package bAa;

#line 354 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/bAa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/bAa/zPz.al)"
sub zPz{
	my $str = shift;
	my @gHz= split "\n", $str;
	my @a;
	for(@gHz) {
		my @pair= sVa::oPa($_);
		push @a, @pair if @pair;
	}
	return @a;
}

1;

1;
# end of bAa::zPz
