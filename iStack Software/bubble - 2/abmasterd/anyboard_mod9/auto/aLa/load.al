# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package aLa;

#line 1314 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/aLa/load.al)"
sub load{
 my($self, $cL, $init, $hashref) = @_;
 if($self->tGa('usedb')) {
	$self->zQa($cL, $init, $hashref);
 }else {
	$self->zLa($cL, $init, $hashref);
 }
}

# end of aLa::load
1;
