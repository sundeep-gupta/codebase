# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1285 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/nCa.al)"
sub nCa{
 my ($self, $bak) = @_;
 my $cfgf = $bak ? $self->nDz('cfg_bak') : $self->nDz('fU');
 return $cfgf if not $abmain::shadow_cfg;
 my $scfgf = $self->pDa($cfgf);
 $self->shadow_cfg($cfgf)  if not -f $scfgf;
 return $scfgf;
}

# end of jW::nCa
1;
