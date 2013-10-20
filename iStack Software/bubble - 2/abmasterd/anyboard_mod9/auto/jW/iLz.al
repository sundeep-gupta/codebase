# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1576 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/iLz.al)"
sub iLz {
 my ($self, $name) = @_;
 if(not $self->{moders}->{$name}) {
 abmain::error("inval", "Moderator $name does not exist");
 }
 delete $self->{moders}->{$name}; 
 $self->hL();
}

# end of jW::iLz
1;
