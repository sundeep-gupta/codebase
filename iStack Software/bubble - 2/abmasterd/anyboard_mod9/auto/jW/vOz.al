# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 7942 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/vOz.al)"
sub vOz {
 my ($self) = @_;
 my $pf =abmain::kZz($self->nDz('qUz'), $self->{pollidxfile}||"index.html");
 $self->rPz() if (-z $pf || not -f $pf);
 my $purl =$self->lMa(abmain::kZz("polls", $self->{pollidxfile}||"index.html"));
 sVa::hCaA "Location: $purl\n\n";
}

# end of jW::vOz
1;
