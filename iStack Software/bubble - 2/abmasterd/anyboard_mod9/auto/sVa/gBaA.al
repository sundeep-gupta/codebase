# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 2364 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/gBaA.al)"
sub gBaA {
	my ($str) = @_;
 my @gHz = split "\n", $str;
	my %cats = ();
 for(@gHz) {
		my ($k, $v) = split '=', $_, 2;
		$k =~ s/^\s*//;
		$k =~ s/\s*$//;
		$v =~ s/^\s*//;
		$v =~ s/\s*$//;
		next if $k eq "" && $v eq "";
		$k = '__null__' if $k eq "";
		$cats{$k} = $v;
 }
	return %cats;
}

# end of sVa::gBaA
1;
