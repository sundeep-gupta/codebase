# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 7805 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/gSa.al)"
sub gSa {
 my ($self, $cG, $fpos, $val) = @_;;
	return $abmain::use_sql? $self->dTaA($cG, $fpos, $val) : $self->dIaA($cG, $fpos, $val);
}

# end of jW::gSa
1;
