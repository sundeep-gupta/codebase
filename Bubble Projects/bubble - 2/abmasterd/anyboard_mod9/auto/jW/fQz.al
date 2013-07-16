# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2146 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/fQz.al)"
sub fQz {
 my($self) = @_;
 if ($self->{passd}) {
 $self->{passd} =~ s#/?$#/#;
 return $self->{passd};
 }
 return $self->{bUz}? $self->nDz('passdir') : $abmain::oC;
}

# end of jW::fQz
1;
