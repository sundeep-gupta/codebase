# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/lB.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package lB;

#line 137 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/lB.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/lB/load.al)"
sub load {
 my ($self, $iS, $conver, $file)=@_;
 return $abmain::use_sql? $self->zQa($iS, $conver, $file): $self->zLa($iS, $conver, $file);
}

# end of lB::load
1;
