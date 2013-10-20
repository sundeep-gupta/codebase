# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1493 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/cNz.al)"
sub cNz{
 my($self, $cL) = @_;
 $cL = $self->nCa() if !$cL;
 my @eE;
 for(values %abmain::gRz) {
 push @eE, $_->[1];
 }
 $self->cJ($cL, @eE, \@abmain::bO, \@abmain::vC);
}

# end of jW::cNz
1;
