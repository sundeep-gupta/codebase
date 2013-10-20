# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package dDa;

#line 122 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/dDa/dUaA.al)"
sub dUaA {
	my ($ab_path) = @_;
	if($ab_path =~ m!/\.\./!) {
		$ab_path =~ s!^/\.\.$!!;
		$ab_path =~ s!/[^/]+/\.\./!/!;
		return dUaA($ab_path);
	}
	return $ab_path;
}

# end of dDa::dUaA
1;
