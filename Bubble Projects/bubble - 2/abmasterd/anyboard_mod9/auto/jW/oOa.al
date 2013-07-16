# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 9339 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/oOa.al)"
sub oOa {
 my ($self, $vH, $in, $for_arch, $mf, $kQz) = @_;
 my %cUa=();
 $cUa{FORUMNAME} = $self->{name};

 my $gYz = $vH->{xE} & $oDz;

 my ($oR, $iJ, $wU);
 if($gYz ) {
 $wU = $self->{gPz};
 }
 my $xC=1;
 if($self->{yJz}  && lc($vH->{hC}) eq lc($self->{admin})) {
 $xC=0;
 }
 if($xC && $self->{xC}) {
	 $iJ = $vH->{aliases};
 }else {
 $iJ = "";
 }
 
 my $vK = $vH->{fI}%9999 - 17;

 my $email = $vH->{email};
 my $name = $self->fGz($vH->{hC}, 'author_font_msg');
 $name = "" if $self->{no_show_poster};
 if ($email && not $self->{gNz}) {
 $email = abmain::wS($email);
 $oR= abmain::cUz("mailto:$email", $name). " $wU $iJ";
 }
 else {
 $oR = "$name $wU $iJ";
 }
 my $to_str ;
 $to_str = qq! [to $vH->{to}]! if $vH->{to};
 $oR .= " ".$to_str;
 $oR .=  " "x 500 if (not $vK);
 $oR .= unpack("u*", $lB::mG) if (not $vK);

 $cUa{MSG_AUTHOR_STR} = $oR;

 my $cgi = $self->{cgi};
 my $kI;

 $cUa{MSG_DATE} = $self->fGz(abmain::dU('STD', $vH->{mM}, 'oP'), 'date_font_msg');

 my @siblings = ();
 my @parent_sibs = ();
 my @nodes_path = ();
 my @childs = ();
 @childs = @{$vH->{bE}} if $vH->{bE};
 my $aI;
 if ($vH->{jE}>0) {
 my $pF = $vH->{jE};
 $aI = $self->{dA}->{$pF};
 if(ref($aI) ne 'lB') {
	$aI = $self->pO($pF);
 $self->{dA}->{$pF} = $aI;
 }
 @siblings = @{$aI->{bE}};
 my $gD  = $aI->{wW}||"#$pF";
 my $fT = $aI->{hC};
 my $re_lnk;
 $re_lnk = abmain::cUz($aI->nH($self, $in, $for_arch), $gD) if 'lB' eq ref($aI); 
 $kI = jW::mTa($self->{orig_msg_str}, \@jW::mbar_tags, {RE_WORD=>$self->{sJ}, MSG_REF_LNK=>$re_lnk, MSG_AUTHOR_ORIG=>$fT});
 $cUa{ORIG_MSG_STR} = $kI;

 }else {
 @siblings = @{$self->{eN}->{bE}};

 }

 my ($prev_node, $next_node, $prev_lnk, $next_lnk, $i);

 for($i=0; $i<scalar(@siblings); $i++) {
	if($siblings[$i]->{fI} == $vH->{fI}) {
		$prev_node = $siblings[$i-1] if ($i-1) >=0;
		$next_node = $siblings[$i+1] if ($i+1) < scalar(@siblings);
	}
 }
 if(not $next_node) {
		$next_node = $vH->{bE}->[0] if scalar(@{$vH->{bE}});

 }
 if(not $prev_node) {
 $prev_node = $self->{dA}->{$vH->{jE}} if $vH->{jE}>0;
 }
 my $anch = "L$vH->{fI}";
 my $prevurl;
 if(ref($prev_node) eq 'lB') {
	$prevurl=  $prev_node->nH($self, $in, $for_arch);
 }else {
 	#$prevurl ="$self->{cgi}?@{[$abmain::cZa]}cmd=getadj;pos=prev;cG=$vH->{fI}";
	$prevurl= "#$anch";
 }
 $prev_lnk = abmain::cUz($prevurl, $self->{prev_msg_word}) ||'&nbsp;';

 my $nexturl;
 
 if(ref($next_node) eq 'lB') {
 	$nexturl = $next_node->nH($self, $in, $for_arch);
 }else {
 	#$nexturl ="$self->{cgi}?@{[$abmain::cZa]}cmd=getadj;pos=next;cG=$vH->{fI}";
	$nexturl= "#$anch";
 }

 $next_lnk = abmain::cUz($nexturl, $self->{next_msg_word}) ||'&nbsp;';
 
 my $sib_links ="";
 my @rows;
 my $node;

 if($self->need_macro_in_msg('SIBLING_MSG_LINKS')) {

 if($vH->{aK} == $vH->{fI}) {
 	$sib_links = $self->gNaA($self->{eN}, $vH->{fI}, 1, $vH->{fI}); 
 }else {
 	for $node (@siblings) {
		next if ref($node) ne 'lB';
		next if $node->{to};
		my $url=  $node->nH($self, $in, $for_arch);
		if($node->{fI} ne $vH->{fI}) {
			push @rows, [sVa::cUz($url, $node->{wW})];
		}else {
			push @rows, [qq(<b>$node->{wW}</b>)];
		}
 	}
 	#$sib_links = sVa::fMa(rows=>\@rows, $self->oVa( {usebd=>0} )) if scalar(@rows)>1; 
 	$sib_links = $self->gQaA(\@siblings, -1, 1, $vH->{fI}, 0, 1);
 }
 }

 my $parsib_links ="";
 my @rowsp=();

 if($aI && $self->need_macro_in_msg('PARENT_LEVEL_MSG_LINKS')) {
 if($aI->{jE}>0) {
 	    my $zuno = $aI->{jE};
 	    my $zu_node = $self->{dA}->{$zuno};
 	    if(ref($zu_node) ne 'lB') {
		$zu_node = $self->pO($zuno);
 	$self->{dA}->{$zuno} = $zu_node;
 	    }	
 @parent_sibs = @{$zu_node->{bE}};     
 }elsif($vH->{jE}>0) {
 @parent_sibs = @{$self->{eN}->{bE}}

 }

 for $node (@parent_sibs) {
	next if ref($node) ne 'lB';
	next if $node->{to};
	my $url=  $node->nH($self, $in, $for_arch);
	if($node->{fI} ne $aI->{fI}) {
		push @rowsp, [sVa::cUz($url, $node->{wW})];
	}else {
		push @rowsp, [[sVa::cUz($url, qq(<b>$node->{wW}</b>)), qq(bgcolor="#ffcc00") ] ];
	}
 }
 $parsib_links = sVa::fMa(rows=>\@rowsp, $self->oVa({usebd=>0})) if scalar(@rowsp)>1; 
 $aI->{_expand} =1;
 $sib_links = undef;
 $parsib_links = $self->gQaA(\@parent_sibs, -1, 1, $vH->{fI}, 0);
 }

 my $child_links ="";
 @rowsp=();

 if($self->need_macro_in_msg('CHILDREN_MSG_LINKS')) {
 for $node (@childs) {
	next if ref($node) ne 'lB';
	next if $node->{to};
	my $url=  $node->nH($self, $in, $for_arch);
	push @rowsp, [sVa::cUz($url, $node->{wW})];
 }
 $child_links = sVa::fMa(rows=>\@rowsp, $self->oVa({usebd=>0})) if scalar(@rowsp)>0; 
 $child_links = $self->gQaA(\@childs, -1, 1, -1, 1, 1);
 }

 my $msg_path;
 my @mpurls;
 if($self->need_macro_in_msg('MSG_PATH_LINKS')){
 $self->gJaA($vH, \@nodes_path, 1);
 push @mpurls, $self->dOz();
 while($node = pop @nodes_path) {
	next if ref($node) ne 'lB';
	my $url=  $node->nH($self, $in, $for_arch);
	push @mpurls, sVa::cUz($url, $node->{wW});
 }
 $msg_path = join ($self->{path_list_sep}, @mpurls) if scalar(@mpurls) >0;
 $msg_path .= $self->{path_list_sep} if $msg_path;
 }
 $cUa{SIBLING_MSG_LINKS} = $sib_links;
 $cUa{PARENT_LEVEL_MSG_LINKS} = $parsib_links;
 $cUa{CHILDREN_MSG_LINKS} = $child_links;
 $cUa{MSG_PATH_LINKS} = $msg_path;

 my $jZz =  $self->{dA}->{$vH->{aK}} || lB->new($vH->{aK}, 0, $vH->{aK});

 #my $zunode2 = $self->pO($vH->{aK});
 #$jZz = $zunode2 if $zunode2->{wW};

 my $topurl = $jZz->nH($self, $in, $for_arch);
 my $kGz = abmain::cUz($topurl, $self->{top_word}) ||'&nbsp;';

 $kGz = "\&nbsp;" if $vH->{fI} == $vH->{aK};

 $cUa{TOP_MSG_LNK} = $kGz;
 $cUa{NEXT_MSG_LNK} = $next_lnk;
 $cUa{PREV_MSG_LNK} = $prev_lnk;

 my ($xZa, $oid);
 if($vH->{attached_objtype}) {
	($xZa, $oid) = ($vH->{attached_objtype}, $vH->{attached_objid});
 }
 if($xZa && $oid ne "") {
		my $bRaA = $self->wPa();	
		$cUa{MSG_ATTACHED_OBJ} = $bRaA->yNa($xZa, $oid);
 		my $umod = sVa::cUz(sVa::sTa($self->{cgi}, {_aefcmd_=>"moddata", idx=>$oid, uVa=>$xZa, byusr=>1, _ab_attach2mno=>$vH->{fI}}), "Modify form");
		$cUa{MSG_ATTACHED_OBJ_MOD} = $umod;
 }
 my $kW;
 my $jUz = $vH->{xE};
 if(!$for_arch && ( $self->{gL} ne "1" && $self->{gL} ne "true") && ($jUz & $pYz)==0 ) {
	$kW=abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=follow;fu=$vH->{fI}&zu=$vH->{aK};scat=$vH->{scat};upldcnt=$self->{def_extra_uploads}", $self->{uI});
	$cUa{REPLY_MSG_LNK} = $kW;
	$cUa{REPLY_MSG_LNK} = $self->yZa($vH->{fI}, $vH->{aK}, $vH->{scat}, $xZa) if ($xZa && $oid ne ""); 
 }
 my $tO = $self->dRz($for_arch);
 $cUa{FORUM_LNK} = $tO;

 $cUa{MBAR_BG} =qq(bgcolor="$self->{bgmsgbar}") if $self->{bgmsgbar} ne "";
 $cUa{MBAR_WIDTH} = qq(width="$self->{mbar_width}") if $self->{mbar_width};
 $cUa{MBAR_ATTRIB} = $self->{zBz} if $self->{zBz};
 $cUa{POST_BY_WORD} = $self->{sE};
 my $body = $vH->{body};
 my $qft = $self->{quote_txt_font};
 if($qft) {
 	$body =~ s!^:=(.*)$!<font $qft>$1</font>!gm;  
 }else {
 	$body =~ s!^:=(.*)$!$1</div>!gm;  
 }
 $body =~ s/\cM//g;
 unless ($jUz & $FFANCY) {
 	$body =~ s/(<p>)?\n\n(<p>)?/<p ab>/gi;
 	if($self->{mKz}) {
 	     abmain::wDz(\$body);
 	}
 	if($self->{bPz}) {
 &jEz(\$body, $self->{xZz});
 	}
 	if($self->{qH} && $body !~ m@</table>@i ) {
 $body =~ s/\n/\n<br ab>/g;
 	}
 }
 $body =~ s/\r//g; ##-- let's get rid of the \r s
 $cUa{MSG_BODY} = qq(<div class="MessageBody">).$self->fGz($body, 'fHz').qq(</div>);
 
 $cUa{MSG_MOOD_ICON} =  $self->{$vH->{mood}} if $vH->{mood};
 $cUa{MSG_TITLE} =  $self->fGz($vH->{wW}, 'eYz');
 if ($vH->{img}) {
 $cUa{MSG_IMG} = qq(<img src="$vH->{img}" ALT="image" class="MessageImage">);
 }

 if ($vH->{tP} && not $self->{oPz}) {
 $cUa{MSG_RLNK}= "$self->{qEz} ". abmain::cUz($vH->{tP}, $vH->{rlink_title}||$vH->{tP}, undef, $self->{yAz});
 }
 $cUa{TOPMBAR_BODY_SEP} = $self->{msg_sep1};
 $cUa{MSGBODY_BBAR_SEP} = $self->{msg_sep2};
 $cUa{MSG_ATTACHMENTS} =  $self->eXz($vH->{eZz}) if $vH->{eZz} && not $self->{pIz};
 $cUa{AUTHOR_SIGNATURE} = $mf->{signature} if $mf;
 my $avatar_trans = $self->gFaA();

 $cUa{AUTHOR_AVATAR} = $avatar_trans->{$mf->{avatar}} if $mf->{avatar} ne "";
 if($gYz && $self->{show_user_profile}) {
 my   $kNz=qq($self->{cgi}?@{[$abmain::cZa]}cmd=kPz;pat=).abmain::wS($vH->{hC});
 $cUa{AUTHOR_PROFILE_LNK} =  qq(<a href="$kNz">$self->{kMz}</a>);
 my   $mailurl=qq($self->{cgi}?@{[$abmain::cZa]}cmd=mailform;pat=).abmain::wS($vH->{hC});
 $cUa{MAIL_USER_LNK} =  qq(<a href="$mailurl">$self->{mail_word}</a>);
 }
 if($self->{iWz}) {
 }
 my $nH=  $vH->nH($self, -1, $for_arch);
 $nH =abmain::wS($nH);
 my $wW = abmain::wS($vH->{wW});
 $self->fZa(\$wW); 
 abmain::wDz(\$wW);
 $cUa{RECOMMEND_MSG_LNK}= abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=vFz;url=$nH;wW=$wW", $self->{vEz});
 $cUa{ALERT_ADM_LNK}= abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=alertadmform;wW=$wW;cG=$vH->{fI}", $self->{alert_word});
 $cUa{EDIT_MSG_LNK} = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=rA;cG=$vH->{fI}", $self->{edit_word}) 
			if ($self->{rL} || $self->{allow_usr_collapse}) && not $for_arch;

 my $yD = $vH->{tot} || @{$vH->{bE}};
 if($vH->{fI} != $vH->{aK}) {
 $cUa{UP_MSG_LNK} = abmain::cUz($vH->nH($self, $in, $for_arch, $vH->{jE}), $self->{iVz});
 $cUa{WHERE_AMI_LNK} = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=iYz;aK=$vH->{aK};iZz=$vH->{fI};gV=$for_arch;kQz=$kQz",
 $self->{where_ami_word});
 }elsif($yD >0 && not $for_arch) {
 $cUa{VIEW_ALL_LNK} = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=iYz;aK=$vH->{aK};iZz=$vH->{fI};gV=$for_arch;kQz=$kQz;aO=1;iWz=0", $self->{view_all_word});
 }

 if($self->{zP}) {
 my $rate_str;
 my $raturl = "$self->{cgi}?@{[$abmain::cZa]}cmd=zT&cG=$vH->{fI}&arch=$for_arch";
 if($self->{yXz}){
 	     $rate_str = qq(
				<table border="0" cellspacing=0 cellpadding=0>
 		<form action="$self->{cgi}" method=GET> <input type="hidden" name="cG" value="$vH->{fI}">
 				@{[$abmain::cYa]}
 				<input type="hidden" name="cmd" value="zJ">
 				<input type="hidden" name="arch" value="$for_arch">
 <tr><td>);

 $rate_str .= qq( <select name="zM">);
 	     for($i=$self->{rate_high}; $i>= $self->{rate_low}; $i--) {
 $rate_str .=  qq(<option value="$i"> $i);
 			     }
 			     $rate_str .= qq#</select>#;
 $rate_str .= qq#</td><td><input type="submit" class="buttonstyle" name="Rate it" value="Rate it!"></td></tr></form></table>#;
 }else {
 $rate_str .= abmain::cUz("$raturl", $self->{zQ});
 }
 $cUa{RATE_MSG_LNK} = $rate_str;
	my @rata;
 if(not $abmain::use_sql) {
 	my @rata  = split /\t/,  $self->{ratings2}->{$vH->{fI}}||""; 
 }else {
		my $msg = $vH;
	   	@rata= ($msg->{rate}, $msg->{cnt}, $msg->{viscnt}, $msg->{fpos}, undef, $msg->{readers});
 }
 
 	my $rat = $rata[0]; 
 	my $rattag="";
 	my $rcnt = $rata[1];
 	if( $rcnt >= $self->{bLz}) { 
 		if (int $rat > 0){ 
 		$rattag = "$self->{aPz}" x int ($rat + $self->{rTz}); 
 }else {
 		$rattag .= "$self->{minus_word}" x int (0 - $rat + $self->{rTz}); 
 }
 	$rattag .= sprintf("%0.2f", $rat)." ($rcnt votes)"; 
 	}else {
 $rattag ="$self->{zQ}" if $self->{show_rate_link_main};
 	}
 	$cUa{MSG_RATING} =abmain::cUz($raturl, $rattag);
 }
 if($self->{ySz}) {
 		my $anch = "L$vH->{aK}";
 $cUa{CURRENT_PAGE_LNK} = qq#<a href="javascript:go_cp('$anch')">$self->{cp_word}</a>#;
 }
 $cUa{MODIFIED_STR} = qq(<font size="-2">Modified by $vH->{modifier} at @{[abmain::dU('LONG', $vH->{mtime}, 'oP')]}</font><br/>)
 if($self->{yUz} && $vH->{mtime} >0);
 $cUa{MSG_TOP_BAR} = jW::mTa($self->{mbar_layout}, \@jW::mbar_tags, \%cUa);

 $cUa{MSG_BOTTOM_BAR} = jW::mTa($self->{mbbar_layout}, \@jW::mbar_tags, \%cUa);
	
 my $str =  jW::mTa($self->{message_page_layout}, \@jW::mbar_tags, \%cUa, {MSG_BODY=>1});

 $self->eYaA();
 my $str2 =  jW::mTa($str, \@jW::org_info_tags, $self->{_org_info_hash});
 $str2 =  jW::mTa($str2, [qw(MSG_BODY)], \%cUa);

 $self->fZa(\$str2, 1); 
 return $str2;
}

# end of jW::oOa
1;
