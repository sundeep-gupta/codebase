# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dZz.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package dZz;

#line 42 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dZz.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/dZz/hEa.al)"
sub hEa{
	my ($self, $fhash, $fields) = @_;
	$fields = [keys %$fhash] if not $fields;
	for(@$fields) {
		$self->zNz($_, $fhash->{$_});
	}
}

# end of dZz::hEa
1;
