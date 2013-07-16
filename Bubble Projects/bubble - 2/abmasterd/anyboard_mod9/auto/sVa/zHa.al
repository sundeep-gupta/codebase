# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 1847 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/zHa.al)"
sub zHa{
	my ($str, $base, $prefix) = @_;
	$str =~ s/^$prefix//;
	if($base ne "") {
		if($str =~ /^$base/) {
			$str =~ s/^$base//;
			return ($base, $str);
		}
		
	}
	$str=~ m!(.*/)([^\/]+)$!;
	return ($1, $2);

}

# end of sVa::zHa
1;
