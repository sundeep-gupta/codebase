# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 8661 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/uW.al)"
sub uW {
 my $self = shift;
 $self->cR();
	$self->fetch_usr_attrib();
#x1
	$self->{yLz} = 'POST';

 $self->gOaA();
 if($self->{lDz}) {
 $self->{bXz}->{rhost}= $self->{_cur_user_domain};
 }

 my $title = $self->{name};
	my $aI ;
	&abmain::dE($abmain::master_cfg_dir);
	&abmain::dE($self->{eD});
	if($self->{force_cookie} && !$abmain::fPz{$abmain::cH} && !$abmain::gJ{fM}){
	   abmain::error('iT', "Please send Cookies to $title");
	   return;
	} 
	my $g_ok=0;
	if($abmain::gJ{gpassword} ne '' && $abmain::gJ{gpassword} eq $abmain::g_post_pw) {
		$g_ok = 1;
	}
	$self->gCz($abmain::gJ{fM}) unless $g_ok;

	$self->yA(\%abmain::gJ);
#x1

 my $name = $self->{bXz}->{name};

	my $ustat = $self->{gFz}->{lc($name)}->[4];
 abmain::error('inval', "User is not activated") if($ustat ne '' && $ustat ne 'A');

	if($self->{fWz}) {
	     $name = $self->{fTz}->{name};
	} elsif(not $g_ok) {
	  if($self->{gBz} || $self->{gAz}) {
	     $self->fZz($name);
	     my $auth_stat = $self->auth_user($name, $abmain::gJ{passwd});
 abmain::error('inval', "User is not activated")
	             if($auth_stat eq 'AUTHOK' && $self->{gFz}->{lc($name)}->[4] ne 'A');

	     if($self->{gAz} &&  $auth_stat eq 'NOUSER') {
 if($self->{gBz}) {
 my $tP= abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=yV", $self->{sK});
	             abmain::error('dM', "You must register with a name and password: $tP")
 }else {
	             abmain::error('dM', "User not found!")
 }
	     }
 	     $iG = abmain::lKz($abmain::gJ{passwd}, 'ne') if $abmain::gJ{passwd};
	     $iG = $abmain::fPz{iG} unless $iG;
	     if($auth_stat ne 'NOUSER') {
 my $req;
 $req = "<br/>". abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=reqpassform", "Request lost password") 
 if($self->{mWz});
	          abmain::error('dM', "Correct password required for registered user <b>$name</b>. $req")
 if $auth_stat eq 'AUTHFAIL';
 $self->oXa($name);
	     }elsif($abmain::gJ{passwd}){
 $iG = "";
	     }
 }
	}
	abmain::error('dM', "Poster must be authenticated by http server")
 if($self->{force_http_auth} && not $ENV{REMOTE_USER});

	abmain::error('dM', "User does not have posting privilege")
 if($self->{gAz} && $self->{fTz}->{type} eq 'A');

#x1

 my $to = $self->{bXz}->{to};
 my $od = $self->{dyna_forum};
 my $to_cnt=0;
 if($to) {
 my @tos;
	     my %tos_hash;
 for my $to1 ( split /\s*,\s*/, $to) {
		next if $to1 eq "";
 	if($self->{tHz}) {
	     		$self->fZz($to1);
 		abmain::error('inval', "$to1 is not a registered user.") if not $self->{fYz}->{lc($to1)};
 	}
		$tos_hash{$to1} =1;
		$to_cnt ++;
	     }
 }
 abmain::error('inval', "The maximum number of private recipients is $self->{priv_recip_max}") if $to_cnt > $self->{priv_recip_max};
 $self->{dyna_forum} = 1 if $to;

 my $wD = $abmain::gJ{oauthor} || $to;
 my $igflag = $self->mWa(lc($wD), lc($name));
 	if($igflag ==1 ) {
		abmain::error('inval', "You are being ignored by $wD");
 	}elsif($igflag == 2) {
		abmain::error('inval', "You are ignoring $wD");
 	}

 my $post_approved = 0; 
 if($self->{fTz}->{type} ne 'C' || not $self->{aWz}) {
 $post_approved = 1; 
 }
 if($self->{no_moder_priv} &&  $to) {
 $post_approved = 1; 
 }
 $self->fSa($name, "Post");

#x1
 
 if($post_approved ) {
 	$self->{aGz} = 1;
 }else {
 	$self->{aIz} = 1;
 	$self->{aGz} = 1;
 }
 $self->aQz() if $self->{aWz};
#x1

 my $iphex = abmain::bW($ENV{'REMOTE_ADDR'}); 

 my $t = time();

 my $lcname = lc($name);
 $self->gCa($abmain::gJ{zu}||-1, $lcname);
	my @rata = split /\t/, $self->{ratings2}->{$abmain::gJ{zu}}||"";
	abmain::error("inval", "Thread closed")
		 if $abmain::gJ{zu} > 0 && $rata[3] & 2;

#x1

	$self->iU($jW::max_mno);
 $pF = $abmain::gJ{fu} > 0 ? $abmain::gJ{fu}:0;
 $bR = $abmain::gJ{zu} > 0 ? $abmain::gJ{zu}:$gP;
 if($gP < $pF) {
 $bR = $gP;
 $pF = 0;
 }
 if($self->{gMz} && $pF ==0) {
 abmain::error('deny', "Only administrator can post new thread")
 unless ($name eq $self->{admin} || $self->{moders}->{$name});
 } 

 ($self->{fTz}->{mycnt}, $self->{fTz}->{mytime}) = $self->wUz($name) 
		if $self->{kWz};
	my $nM = @{$self->{pC}};
	my $cnt=0;
 my $subject = $self->{bXz}->{wW};
	my $iL;
	my ($ono, $otno, $i, $lstr);
 my $iHz = kKz($self->{iGz}||$abmain::license_key);
	for($i=$nM-1; $i>0 && $cnt <20; $i--, $cnt++) {
	      $iL = $self->{pC}->[$i];
	      if((not $iL->{to}) && $iL->{wW} eq $subject && $iL->{pQ} eq $iphex && not $self->{yR}){
	        ($ono, $otno) = ($iL->{fI}, $iL->{aK});
 $lstr = abmain::cUz($self->nGz($ono, $otno), "<b>$subject</b>");
	      	abmain::error('inval', "$lstr topic already exists.", "Go back and change the subject." );
	      }
 if($iL->{pQ} eq $iphex && time()<$iL->{mM}+$self->{yN}) {
 sleep(1);
 abmain::error('inval', "System unavailable, repost after $self->{yN} seconds");
 }
	}
 
 my $ct = time();
 my $iBz=24*3600;
 my $ct_1 = $ct - $iBz;
 my ($iEz, $iCz, $postcnt_tot) = (0,0,0);
 my $thr_cnt = 0;
 my $thr_tot =0;
 my @user_post_nos=();
 for($i=$nM-1; $i>0; $i--) {
	      $iL = $self->{pC}->[$i];
 if($iL->{mM} > $ct_1) {
 	if($thr_tot < 10 && $iL->{aK} == $iL->{fI}) {
	            $thr_tot ++; 
 $thr_cnt ++ if lc($iL->{hC}) eq $lcname;
 	}
 	next if lc($iL->{hC}) ne $lcname;
 	$iEz ++;
 	$iCz++ if $iL->{eZz};
 }
 if(lc($iL->{hC}) eq $lcname){
 	$postcnt_tot++;
		push @user_post_nos, join ("\t", $iL->{fI}, $iL->{aK});
	      }
 }
 abmain::error('inval', "Exceeded daily posting limit ($self->{iAz})") 
#x1
 abmain::error('inval', "Exceeded daily upload limit ($self->{iDz})") 
#x1
 if($thr_tot >= 10 && $self->{yKz} >0 && $lcname ne lc($self->{admin}) && $self->{bXz}->{to} eq "" ) {
 	abmain::error('inval', "Exceeded presence ratio ($self->{yKz})") if $thr_cnt/$thr_tot > $self->{yKz};
 }

 my $hOaA =0;
 if ($self->{hPaA} && $self->{hPaA} <= $postcnt_tot ) {
 if (not $self->{hQaA}) {
#x1
	     }else {
		$hOaA = $postcnt_tot +1 - $self->{hPaA};
 }
	}

 my $wL=99999999;
 if($nM>20) {
 $wL = $self->{pC}->[$nM-1]->{mM} - $self->{pC}->[$nM-20]->{mM};
 }
 if($nM>20 &&$wL >0 && $wL <  $self->{yU}) {
 $self->xI("20 posts arrived in $wL seconds!");
 }
 $jUz |= $oDz if($iG || $self->{fTz}->{reg}); ## user is registered or not
	$jUz |= $jW::FNOHTML if $self->{bXz}->{nohtml};
 if($self->{oXz} && ($self->{fTz}->{name} eq $self->{admin} || not $self->{nTz})) {
 $jUz |= $pKz if $self->{bXz}->{repredir};
 $jUz |= $oRz if $self->{bXz}->{repmailattach};
 }
 $self->{bXz}->{rhost} = abmain::lWz("",1) if $self->{record_rhost} && not $self->{bXz}->{rhost};

#x1

 my $status="ok";
 	if($abmain::gJ{attachfid} ne "") {
		$status ="tmp";
	}
	$self->mO($bR, $pF, $gP, $subject, 
 $name, time(), length($self->{bXz}->{body}), abmain::bW($ENV{'REMOTE_ADDR'}),
 $jUz, $self->{bXz}->{email}, $self->{bXz}->{eZz}, $self->{bXz}->{to}, 
 $self->{bXz}->{mood}, $self->{bXz}->{url}, $self->{bXz}->{rhost}, "", 
 $self->{bXz}->{scat}, $abmain::ab_track, $abmain::VERSION||8, undef,
 undef, $status, undef, 0,
		             undef, undef, undef, $self->{bXz}->{sort_key}, $self->{bXz}->{key_words}); 
	$aI = $self->{dA}->{$pF};
	$self->kA($post_approved);

#x1

 if($hOaA >0) {
	     my $len = scalar(@user_post_nos);
	     my @mnos = @user_post_nos[-$hOaA .. -1];
#x1
 }
 if($self->{purge_mark}>0 && $self->{dI}> $self->{purge_mark} && $gP%10==0 && not $hOaA ) {
#x1
 }
 if($post_approved && $self->{aWz}) {
 $self->vHz($gP);
 $self->{bXz}->{oked}=1;
 }
 $self->{dyna_forum} = $od;
 if($post_approved ) {
		$self->nU();
 }
#x1
 
	$self->eV($aI);
#x1
 print join("\n", "<!--", @abmain::ticks, "-->");
	$self->qXa() if (($gP%15)==0);
}

# end of jW::uW
1;
