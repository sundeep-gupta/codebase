# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1475 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/cOz.al)"
sub cOz{
 my($self, $cL, $sec, $negate) = @_;
 $sec = "All" if not $sec;
 $cL = $self->nCa() if !$cL;
 my @eE;
 for(values %abmain::qJa) {
 if(!$negate) {
 	next if $sec ne "All" && $_->[0] ne $sec;
 }else {
 	next if ($sec eq "All" || $_->[0] eq $sec);
 }
 push @eE, $_->[1];
 }
 $self->cJ($cL, @eE);
 $self->lP();

 $self->hack_headers();
}

# end of jW::cOz
1;
