# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 4560 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/eMaA.al)"
sub eMaA {
	my ($self, $tags, $gV)  = @_;
	if(not $self->{_navbarhash}) {
		$self->bHa(0, $gV, 0);
	}
	for my $htag (@$tags) {
		my $v = $self->{$htag};
		$v = mTa($v, \@jW::gLa, $self->{_navbarhash});
		$self->{$htag} = $v;
	}
	
}

# end of jW::eMaA
1;
