# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1568 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/iKz.al)"
sub iKz {
 my ($self, $name) = @_;
 if($self->{moders}->{$name}) {
 abmain::error("inval", "Moderator $name exists already");
 }
 $self->{moders}->{$name} = ["", "", "", ""];
 $self->hL();
}

# end of jW::iKz
1;
