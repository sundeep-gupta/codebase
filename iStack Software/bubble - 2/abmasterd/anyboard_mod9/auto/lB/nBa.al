# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/lB.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package lB;

#line 89 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/lB.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/lB/nBa.al)"
sub nBa {
 my ($self, $iS)=@_;
 $self->{body} = $iS->gB($self->{fI});
 $self->{kRa} = $abmain::VERSION||8;
 $self->store($iS);

}

# end of lB::nBa
1;
