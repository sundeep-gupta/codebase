# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dZz.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package dZz;

#line 221 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dZz.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/dZz/pLa.al)"
sub pLa{
	my $sub = shift;
	my $pat = '=\?[^\?]+\?(.)\?([^\?]*)(\?=)?';
	$sub =~ s{$pat}{lc($1) eq 'q' ? oZa($2) : fIa($2)}ge;
 return $sub;
} 

# end of dZz::pLa
1;
