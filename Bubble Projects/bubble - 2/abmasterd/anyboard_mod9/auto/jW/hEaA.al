# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1662 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/hEaA.al)"
sub hEaA{
 my($self, $input) = @_;
 $self->cR();
 $self->bI();
 abmain::vA();
 abmain::error('inval', "You must check the confirmation box") if not $input->{kIz};
 require WWWB2AB;
 my $ok = WWWB2AB::convert_wwwforum(abmain::kZz($input->{w3bbasedir}, "messages"), $self->{eD});
 $self->nU(1) if $ok;
}

# end of jW::hEaA
1;
