# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/lB.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package lB;

#line 73 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/lB.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/lB/pOa.al)"
sub pOa {
	my ($self, $numgen, $jE, $aK, $cat) = @_;
 my $istop = $self->{fI} == $self->{aK};
	$self->{fI} = &$numgen();
 if ($aK==0) {
 	$self->{aK} = $self->{fI};
	}else {
 	$self->{aK} = $aK;
	}
 $self->{jE} = $jE;
 $self->{scat} = $cat if defined $cat; 
 my $chld;
	for $chld (@{$self->{bE}}) {
		$chld->pOa($numgen, $self->{fI}, $self->{aK}, $cat);
	}
}

# end of lB::pOa
1;
