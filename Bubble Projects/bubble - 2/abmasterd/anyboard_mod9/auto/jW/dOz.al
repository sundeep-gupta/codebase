# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2127 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/dOz.al)"
sub dOz {
 my($self) = @_;
 return "" if $self->{hide_flink};
 if(-f $self->nCa()) {
 	return abmain::cUz($self->fC(), $self->{name}, $self->{dDz}?'_parent':'');
 }else {
 	return abmain::cUz("javascript:history.go(-1)", "Back", $self->{dDz}?'_parent':'');
 }
}

# end of jW::dOz
1;
