# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 9722 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/fQaA.al)"
sub fQaA {
	my ($self) = @_;
	$self->eYaA();
	for(@jW::org_info_tags) {
		$self->{_navbarhash}->{$_} = $self->{_org_info_hash}->{$_};
	}
}

# end of jW::fQaA
1;
