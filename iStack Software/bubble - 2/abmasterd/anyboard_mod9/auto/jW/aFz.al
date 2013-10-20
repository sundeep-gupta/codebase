# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 7526 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/aFz.al)"
sub aFz {
 my ($self, $cG, $suf, $one) = @_;
	return $abmain::use_sql? $self->zBa($cG, $suf, $one) : $self->zNa($cG, $suf, $one);
}

# end of jW::aFz
1;
