# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1584 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/mR.al)"
sub mR {
 my($self) = @_;
 $self->bI();

 my @jS= split '-', $abmain::gJ{by};
 if($abmain::gJ{xcfgfs}) {
 	my @xcfgs= split '-', $abmain::gJ{xcfgfs};
 	for(@xcfgs) {
 		$self->{xcfgfs}->{$_}=1;
 	}
 }
 for(@jS) {
 next if not $_;
 my $fU= $abmain::eO{$_};
 $self->iA($fU->[1]) ;
 }
 $self->lP();
 $abmain::tz_offset = $self->{tz_offset};
}

# end of jW::mR
1;
