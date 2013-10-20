# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package aLa;

#line 688 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/aLa/rUa.al)"
sub rUa {
	my ($self, $k) = @_;
	if(not $k) {
		delete $self->{_vokeys};
	}else {
		delete $self->{_vokeys}->{$k};
	}
}

# end of aLa::rUa
1;
