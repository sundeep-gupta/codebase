# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2085 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/fC.al)"
sub fC {
 my($self, $ab) = @_;
 if($self->{allow_user_view}) {
 	return "$self->{cgi}?@{[$abmain::cZa]}cmd=vXz;pgno=0";
 }
 return $self->lMa($self->{aC},0,1);
}

# end of jW::fC
1;
