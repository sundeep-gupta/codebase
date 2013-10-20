# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package aLa;

#line 712 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/aLa/set_opt_fields.al)"
sub set_opt_fields{
	my ($self, $fields) = @_;
	my $aJa = $self->{zKz};
	if($fields) {
		for(@$fields) {
			$aJa->{_opt_fields}->{$_} =1;
		}
	}
}

# end of aLa::set_opt_fields
1;
