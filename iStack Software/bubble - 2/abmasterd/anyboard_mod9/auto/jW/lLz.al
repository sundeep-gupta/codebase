# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2451 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/lLz.al)"
sub lLz{
 my ($self) = @_;
 for(keys %locks) {
 if ($locks{$_}) {
 $self->pG($_);
 # abmain::pEa("lock $_ need unlock\n");
 }
 }
}

# end of jW::lLz
1;
