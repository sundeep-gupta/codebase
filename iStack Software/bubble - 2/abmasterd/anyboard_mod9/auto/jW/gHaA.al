# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1629 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/gHaA.al)"
sub gHaA{
 my($self, $input) = @_;
 $self->cR();
 $self->bI();
 abmain::vA();
 my @opts = split("\0", $input->{_baseopts});
 $self->{core_opts} = join (" ", @opts);
 $self->hL();
 abmain::cTz("Options saved");
}

# end of jW::gHaA
1;
