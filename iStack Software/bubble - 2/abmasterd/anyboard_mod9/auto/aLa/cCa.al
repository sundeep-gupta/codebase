# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package aLa;

#line 1408 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/aLa/cCa.al)"
sub cCa {
 my($self, $cL) = @_;
 $cL =~ /(.*)/; $cL =$1;
 open (lW, "> $cL") or return $self->aGa('sys', "On writing $cL: $!") ;

 my $cJa=$self->genDefMime();
 $cJa->aNa(\*lW);
 close lW;
 chmod 0600, $cL;
}

# end of aLa::cCa
1;
