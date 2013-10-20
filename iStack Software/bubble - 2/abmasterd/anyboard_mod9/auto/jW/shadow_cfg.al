# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1266 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/shadow_cfg.al)"
sub shadow_cfg {
 my ($self, $cfgf) = @_;
 $cfgf = $self->nDz('fU') if !$cfgf;
 my $scfgf = $self->pDa($cfgf);
 local *F;
 chmod 0600, $cfgf;
 open F, "<$cfgf" or return;
 local $/ = undef;
 binmode F;
 my $line = <F>;
 close F;
 chmod 0000, $cfgf;
 open F, ">$scfgf" or return;
 binmode F;
 print F $line;
 close F;
 chmod 0600, $scfgf;
 return 1;
}

# end of jW::shadow_cfg
1;
