# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 6409 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/bI.al)"
sub bI{
 my $self = shift;
 my $logit=0;
 my $dM = 0;
 $abmain::g_is_root =0;
 my ($is_root, $root) = abmain::eVa() ;
 my $kWa =undef;
#x2
 goto FOR_ROOT if $is_root && $root ne "";
 if(@_) {
 ($oK, $dD) = @_; 
 $cI= unpack("H*", $oK);
 $aN = unpack("H*", $dD);
 mE($abmain::fvp);
 $logit = 1;
 }else {
 mE($abmain::fvp);
 if(not defined($abmain::fPz{$hW})) {
 	abmain::error('iT', "You need to relogin!") if(not $self->{hRa});
 return;
 }
 ($cI, $aN) = split /:/, $abmain::fPz{$hW};
 $oK = pack("H*",  $cI);
 $dD = pack("H*",  $aN);
 }
 my $p = $self->{oA};
 my $ptmp = "";
 my $p2 = $self->{admin};
 my $sf = $self->nDz('skey');
 if(open SF, $sf) {
	$ptmp =<SF>;
	$ptmp =~ s/\s//g;
	close SF;
 }
 my $inp = abmain::lKz($dD, $dD);

 if ($oK eq $self->{admin} && (($inp eq $p) || ($ptmp && $inp eq $ptmp) || $p eq "")){
 $uT = $kWa||"adm";
 }elsif ($self->{moders}->{$oK} && $inp eq $self->{moders}->{$oK}->[1]) {
 ($self->{moderator_email}, $self->{vI}, $self->{vM}, $self->{vN}, $self->{mod_can_dopoll})
 = @{$self->{moders}->{$oK}};
 $uT = "mod";
 } else {
 $logit = 1;
 $dM =1;
 
 }
 if($logit) {
 if($dM) {
 $self->wNz(0, "???", $self->nDz('admlog'));
 return if $self->{hRa};
 		abmain::error($self->{scare_adm_msg}, "Wrong admin password. Failed attempt logged <b> $abmain::ab_id0</b>");
 }
 $self->wNz(1, $uT, $self->nDz('admlog'));
 }
 return 1;
FOR_ROOT:
 $uT = $kWa||"adm";
 $oK = $root;
 $abmain::g_is_root =1;
 $self->wNz(1, $uT, abmain::wTz('admlog'));
 return 1;
}

# end of jW::bI
1;
