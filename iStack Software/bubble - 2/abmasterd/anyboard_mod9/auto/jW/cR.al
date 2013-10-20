# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1293 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/cR.al)"
sub cR{
 my($self, $cfgf, $blind) = @_;
 $cfgf = $self->nCa() if !$cfgf;
 my @eE;
 if($blind ) {
	$self->{_blind_cfgs}=1;
 }else {
 	for(values %abmain::eO) {
 	     push @eE, $_->[1];
 	}
	$self->{_blind_cfgs}=0;
 }
 
 $self->cJ($cfgf, @eE, \@abmain::bO, \@abmain::vC);
 $self->{_loaded_cfgs}=1;
 if($cfgf eq $self->nCa()) {
 $self->cJ(abmain::wTz('overcfg'), @eE, \@abmain::bO)
 if -r abmain::wTz('overcfg');
 $self->cJ($self->nDz('overcfg'), @eE, \@abmain::bO)
 if -r $self->nDz('overcfg');
 }

 $self->hack_headers();
 $self->lP();

 my @moders = split ("\t", $self->{moderator});
 my @jTz=split("\t", $self->{moderator_email});
 my @kFz=split("\t", $self->{vI});
 my @jHz=split("\t", $self->{vM});
 my @mod_can_polls=split("\t", $self->{mod_can_dopoll});
 my @jOz=split("\t", $self->{vN});
 my $mcnt = @moders;
 my $i;
 for($i=0; $i<$mcnt; $i++) {
 $self->{moders}->{$moders[$i]} = [$jTz[$i], $kFz[$i], $jHz[$i], $jOz[$i], $mod_can_polls[$i]];
 }
 $self->{lVz} = 1 if $self->{mAz};
 $abmain::tz_offset = $self->{tz_offset};
 for(keys %abmain::cP) {
 $abmain::cP{$_} = [ $self->{$_."_e0"}, $self->{$_."_e1"}, $self->{$_."_e2"}];
 };
 $abmain::msg_bg = $self->{msg_bg};
 $jW::random_seq = $self->{random_seq};
 $jW::random_seq = 0 if $abmain::use_sql;
 $self->{iW} = 16 if $self->{iW} <=0;
 $self->{aC} = 'index.html' if $self->{aC} eq '';
 $self->{idx_file} = 'gindex.html' if $self->{idx_file} eq '';
 $self->{ext} = 'html' if $self->{ext} eq '';
 @jW::bgs=($self->{cbgcolor0}, $self->{cbgcolor1});
}

# end of jW::cR
1;
