# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/pAa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package pAa;

#line 134 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/pAa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/pAa/Count.al)"
sub Count
{
	my $me = shift;
	my $c = shift;
	if (defined $c and length($c) > 0) {
		$me->{COUNT} = $c;
	} else {
		return $me->{COUNT};
	}
 
} 

# end of pAa::Count
1;
