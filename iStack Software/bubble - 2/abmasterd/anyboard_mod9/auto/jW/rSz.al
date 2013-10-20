# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 6574 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/rSz.al)"
sub rSz {
	my ($self, $oldage) = @_;
 $oldage = 600 if not $oldage;
 my $idx = $self->dGz();
	if( (stat($idx))[9] < time() - $oldage) {
abmain::hOa();
 abmain::hYa(); 
	       $self->cR();
	       $self->{iAa} = sub {(stat($idx))[9] < time() - $oldage};
	       $self->nU();
	}
}

# end of jW::rSz
1;
