# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 8637 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/oGa.al)"
sub oGa {
 my ($self, $vH) = @_;
 return if $vH->{to} || not $vH->{aK} == $vH->{fI};
 my $f = $self->nDz('lastmsg');
 $vH->store($self, $f);
}

# end of jW::oGa
1;
