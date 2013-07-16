# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1258 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/pDa.al)"
sub pDa {
	my ($self, $cfgf) = @_;
 $cfgf = $self->nDz('fU') if !$cfgf;
	$cfgf =~ s!/!-!g;
	$cfgf =~ s!:!_!g;
	$cfgf =~ s!\\!-!g;
	return abmain::kZz($abmain::master_cfg_dir, $cfgf);
}

# end of jW::pDa
1;
