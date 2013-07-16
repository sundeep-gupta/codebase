# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/lB.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package lB;

#line 327 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/lB.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/lB/jN.al)"
sub jN {
 my $self = shift;
 my %fH = @_;






 my ($iS, $nA, $jK,  $hO, $gQ, $gV, $depth, $jAz, $iZz, $kQz, $pub) = 
 ($fH{iS}, $fH{nA}, $fH{jK}||0, $fH{hO}||0, 
	  $fH{gQ}||0, $fH{gV}||0, $fH{depth}||0, $fH{jAz}||0, $fH{iZz}||0, $fH{kQz}||"", $fH{pub});

 my ($selmak, $catjumper);
 $selmak = aLa::bYa(['scat', $iS->{scat_use_radio}?'radio':'select',  join("\n", $iS->{catopt}, $iS->{hBa})]) if $iS->{allow_subcat};
 $catjumper = $iS->oHa();

 $iS->hVz();
 my @uN=();
 my @gHz=();
 my $loop_cnt=0;
 my $top = $iS->{dA}->{$self->{aK}};
 my $max_loop = ($top->{tot} + scalar(@{$self->{bE}}) )* 10 + 1000;;
 $kQz = "" if $kQz eq '`';
 my $od = $iS->{dyna_forum};
 $iS->{dyna_forum} = 1 if $kQz;


#array elements: msgnode, level(depth), idx in the thread, tag
 my ($sw, $nw, $dw)= ($iS->{qLz}, $iS->{qMz}, $iS->{qPz});
 $sw = 'width="60%"' if not $sw;
 $nw = 'width="15%"' if not $nw;
 $dw = 'width="25%"' if not $dw;

 my ($bdcolor, $bdextpad, $bdinspace) = 
 ($iS->{bdcolor} ne "" ? qq( bgcolor="$iS->{bdcolor}") :" ", 
 qq(cellpadding="$iS->{bdsize}"), qq(cellspacing=$iS->{lZz})
 );
 print $nA sVa::gXaA();

 push @uN, [0, 0, 0, "</DIV>\n"];

 push @uN, [$self, $hO, 0, ""];

 push @uN, [0, 0, 0, qq(<DIV class="ABMSGLIST">\n)];

 my $msg_row_col_cnt;
 if($iS->{align_col_new}) {
	$msg_row_col_cnt++ while ($iS->{msg_row_layout} =~ m!/td>!gi);
 }
 $lB::sL= unpack("u*", $mG);
 my $vD;
 my $stack_log={};
 while($vD= pop @uN) {
 if( $loop_cnt++ >$max_loop ) {
 print STDERR join("-", caller)." exceeded $max_loop\n" if $loop_cnt++ >$max_loop;
	abmain::iUz(-2);
 }
 my $mtag = $vD->[3];
 
 if($mtag) {
 print $nA $mtag;
 next;
 }
 my $uL = $vD->[1];

#      next if ($uL > $depth && $depth>0);

 my $vH= $vD->[0];

 next if ($vH->{status} eq 'tmp' && not $gQ);
 next if $pub eq 'p' && $vH->{to} =~ /\S/;

 my $hA = $vD->[2];

 if($abmain::debug) {
 abmain::pEa("hO=$uL #=$vH->{fI}\n");
 } 

 if($vH->{fI} >0 ) {
	    last if $stack_log->{$vH->{fI}};
	    $stack_log->{$vH->{fI}}=1;
	    my $bc ="";
	    my $fc ="";
 my $in = $vH->vK($iS, $gV);
 my $dH = ($jK == $in && not $jAz);

 my $url = $vH->nH($iS, $jK, $gV);
 #next if((!$dH) && $jK > 0 && $jK != $vH->{fI} && $iS->{no_links_inmsg});

 my $gYz = ($vH->{xE}||0) & $oDz;

	    my %msg_hash = ();
	    my @print_buf=();

 my $wW = $vH->{wW};
 my $hC = $vH->{hC} || '&nbsp;';
 $wW = abmain::yDz($wW, $iS->{xVz}) if $iS->{xVz} >0 && $vH->{hC};
	    $iS->fZa(\$wW) if $iS->{kMa};
	    my $sfont = $iS->{_usr_subj_fonts}->{lc($hC)};

 if($sfont) {
		$wW = qq(<font $sfont>$wW</font>);
 }else {
 	$wW = $iS->fGz($wW, $vH->{fI} == $vH->{aK}? 'topic_font': 'eSz');
	    }
 my $nc =  $vH->{hC} && $vH->{size} ==0 && not ($vH->{tP} || $vH->{eZz} || ($vH->{xE} & $pTz) );
 my $nolink = $nc && $uL > 1 && $jK <=0 && $iS->{nolink_nt};

 #my $hC = ($kQz && $vH->{hC} eq $kQz)? "To $vH->{to}" : $vH->{hC};
	    my $pfont = $iS->{_usr_fonts}->{lc($hC)};
 if($pfont) {
		$hC ="<font $pfont>$hC</font>";
 } 
 elsif(lc($hC) eq lc($iS->{admin})) { 
 $hC = $iS->fGz($hC, 'cRz');
 }elsif($iS->{moders}->{$hC}) { 
 $hC = $iS->fGz($hC, 'moder_font');
 }else { 
 $hC = $iS->fGz($hC, $gYz?'reg_author_font':'fEz');
 }
 my $wU=""; 
	    $wU = $iS->{gPz} if ($iS->{gSz} && $gYz);

 my $tf='LONG';
 if($iS->{posix_date}) {
		 $tf = 'POSIX';
 }elsif($iS->{day_date}) {
	         $tf='DAY';
 }elsif($iS->{bKz}) {
 $tf = 'SHORT';
 }elsif($iS->{jCa}) {
 $tf = 'STD';
 }
 my $pt = $iS->fGz(abmain::dU($tf, $vH->{mM}, 'oP', $iS->{posix_df}), 'fCz');
	    #$pt = qq!<script>document.write(unix_date_conv($vH->{mM}));</script><noscript>$pt</noscript>!;

 if($iS->{bOz}) {
 $wW = "<b>$wW</b>";
 }

	    $msg_hash{MSG_SUBJECT} = $wW;

	    if(time() < ($vH->{mtime}||0) + 60*$iS->{kF} ) {
	            $pt = qq(<font color="$iS->{mod_msg_color}"><b>). "$pt". qq(</b></font>);
 } elsif(time() < $vH->{mM} + 60*$iS->{kF} ) {
	            $pt = qq(<font color="$iS->{new_msg_color}"><b>). "$pt". qq(</b></font>);
	    }else {
	         #   $pt = qq(<i>). "$pt". qq(</i>); #let's don't do this
	    }
 
 $msg_hash{MSG_TIME} = $pt;

	    my $yD = $vH->{tot} || @{$vH->{bE}};
	    my $dF="";
 if ($iS->{bJz} && $yD > 0) {
 	$dF = " +$yD $iS->{fc_tag}";
 $dF = $iS->fGz($dF, 'followcnt_font');
 }
 $msg_hash{MSG_REPLY_CNT} = $yD;

	   my @mtags = ();
 if($iS->{xJ} && ($vH->{xE} || 0) & $pTz) {
 $dF = "$iS->{bQz} $dF";
		    push @mtags, $iS->{bQz};
 }
 if($iS->{show_has_attach} && $vH->{eZz} ne "") {
 $dF = "$iS->{attach_tag_word} $dF";
		   push @mtags, $iS->{attach_tag_word};
 }
 if($iS->{show_has_lnk} && ($vH->{xE} ||0) & $FHASLNK) {
 $dF = "$iS->{lnk_tag_word} $dF";
		   push @mtags, $iS->{lnk_tag_word};
 }
	
 my @rata = (); 
	   if(not $abmain::use_sql) {
	   	@rata= split /\t/, $iS->{ratings2}->{$vH->{fI}} if $iS->{ratings2}->{$vH->{fI}};
	   }else {
		my $msg = $vH;
	   	@rata= ($msg->{rate}, $msg->{cnt}, $msg->{viscnt}, $msg->{fpos}, undef, $msg->{readers});
 }
 $iS->{aSz}->{$vH->{fI}}->[3] = $rata[3];
 $vH->{yTz} ||=0;
	   if((not $gV) && $iS->{collapse_age}>0 && $vH->{yTz} > 0 && time() - $vH->{yTz} > 3600*$iS->{collapse_age}) {
 	$iS->{aSz}->{$vH->{fI}}->[3] |= 1;
	   }
		
 if($yD >0 && ($iS->{aSz}->{$vH->{fI}}->[3] || 0) & 1 && $jK ==0 && $uL >0) {
 	$dF = "$iS->{aUa} $dF";
			push @mtags, $iS->{aUa};
	   }

 if($iS->{rM}) {
 my $eUz = $iS->fGz(sVa::fWaA($vH->{size}), 'eVz');
	           $dF = "$iS->{dsz_sep} $eUz $iS->{szo_sep} $dF";
		   $msg_hash{MSG_SIZE} = $eUz;
 }

 if($iS->{bMz} && !$gV && $jK <= 0) {
 my $reads =$rata[2] || 0;
 my $fAz = "$reads reads";
 if($reads > $iS->{fFz}) {
 $fAz = "<font color=red>$fAz</font>";
 }
	           $fAz =  $iS->fGz($fAz, 'eTz');
	           $dF = "(". $fAz. ") $dF";
 $msg_hash{MSG_READS} = $fAz;
 }

 if($gQ && $vH->{to}) {
 $dF .= "<font color=red>Private</font>";
		   push @mtags, "<font color=red>Private</font>";
 }

	   my $readtag = ""; 
 if($vH->{to}) {
		if(jW::sFa($rata[5], $iS->{fTz}->{name}) || lc($vH->{to}) eq lc($iS->{fTz}->{name})) {
			$readtag=$iS->{old_word};
		}else {
	   		$readtag= $iS->{notread_word};
		}
 }
 my $rateinsubj="";
 if($iS->{zP} && $jK <=0 ) {
 my $rat = $rata[0]; 
 $dF .= qq(\&nbsp;) x 2;
 my $raturl = qq($iS->{cgi}?@{[$abmain::cZa]}cmd=zT;cG=$vH->{fI};rate=$rat);
 my $rattag="";
		   my $tit;
 my $rcnt = $rata[1] ||0;
 if( $rcnt >= $iS->{bLz}) { 
 next if $rata[0] < $iS->{min_rate} && $rcnt > $iS->{rYz} && not $gQ;
 	if (int $rata[0] > 0){ 
 		$rattag = "$iS->{aPz}" x int ($rata[0] + $iS->{rTz}); 
 }else {
 		$rattag .= "$iS->{minus_word}" x int (0 - $rata[0] + $iS->{rTz}); 
 }
 }else {
 $rattag ="$iS->{zQ}" if $iS->{show_rate_link_main};
 }
 $tit = "Number of times rated: $rcnt" if $rcnt>0; 
 if ($iS->{show_rate_link_main}){
		       $msg_hash{MSG_RATE_LNK} = abmain::cUz($raturl, $rattag, undef, qq(title="$tit") );
 if($iS->{dAa} ) {
			        $rateinsubj ="\&nbsp;\&nbsp;".$msg_hash{MSG_RATE_LNK};
 }else {
 		$dF .= $msg_hash{MSG_RATE_LNK};
			}
 }else {
 if($iS->{dAa} ) {
			  $rateinsubj = '&nbsp;&nbsp;'.$rattag;
 }else {
 	  $dF .= $rattag;
 }
		       $msg_hash{MSG_RATE_LNK} = qq(<span class="MsgRating" title="$tit">$rattag</span>);
 }
 }
	   $dF .= $readtag;

 $msg_hash{MSG_READ_STATUS} = $readtag;
	   $msg_hash{MSG_AUTHOR_REGSTAT} = $wU;
			

#should be ( $uL>1 && (!$dH || $iS->{mJ}));  

 my ($tdins0, $tdins1, $tdins2, $tdins3)=('', '','','');
 ($tdins0, $tdins1, $tdins2, $tdins3)=("<tr><td $sw>", qq(</td><td $nw>), 
 qq(</td><td $dw>), "</td></tr>\n") if $iS->{mAz};

 if($uL ==1) {
 $tdins0="";
 $tdins3="";
 }

 $iS->{lVz} = 1 if ($iS->{mAz} || $iS->{align_col_new});
 push @print_buf,  $tdins0 if $iS->{mAz} && $uL >0;

 if ( $uL>1 && !($dH && !$iS->{mJ}) && !$iS->{fW}){
 if($iS->{lVz} ) {
 $msg_hash{MSG_SPACER}=  $iS->{lUz} x ($uL-1);
 push @print_buf,  $msg_hash{MSG_SPACER};
 }else {
 	     if (not $iS->{no_li}){  
 	      $msg_hash{MSG_SPACER} = "<li>";  
 push @print_buf,  $msg_hash{MSG_SPACER};
		     }
 }
 }
 
 my $row_cls;

	   my $thr_closed = $rata[3] & 2;

 if($uL==1) {
		  my $po =$hA%2;
		  $bc =$mP[$po];
		  $fc =$eK[$po];
		  $row_cls = ('ThreadRow0', 'ThreadRow1')[$po];
 push @print_buf,   qq(<tr class="$row_cls" );
		  push @print_buf,   qq(bgcolor="$bc" ) if $bc;
 $sw = 'width="100%"' if not $iS->{mAz};
 if($vH->{fI} == $vH->{aK}) {
		      if($thr_closed) {
		  	push @print_buf,   "><td $sw>$iS->{closed_tag}" ;
			$msg_hash{MSG_STAT_TAG} = $iS->{closed_tag};
		      }else {
		  	push @print_buf,   "><td $sw>$iS->{topic_tag}" ;
			$msg_hash{MSG_STAT_TAG} = $iS->{topic_tag};
 }
 }else {
		  	push @print_buf,   "><td $sw>";
 if($iS->{hSa}) {
			  $msg_hash{MSG_STAT_TAG} = abmain::cUz($iS->nGz($vH->{aK}, $vH->{aK}, $gV, $jK, $vH->qRa()), $iS->{sub_topic_tag});
			  push @print_buf,  $msg_hash{MSG_STAT_TAG};
 }else {
 push @print_buf,  $iS->{sub_topic_tag};
			  $msg_hash{MSG_STAT_TAG} = $iS->{sub_topic_tag};
 }
 }
		  push @print_buf,   qq(<font color="$fc"> ) if $fc && $jK != $in;
 }
	    my $del_chk="";
	    my $here_mark="";
	    if($gQ) {
	         $del_chk =   qq!<input type="checkbox" name="fJ" value="$vH->{fI} $vH->{aK}" title="$vH->{fI}">!;
	         push @print_buf,  $del_chk;
	    }

	    if( $iS->{link_edit} && ($iS->{rL} || $iS->{allow_usr_collapse}) && !$gV &&(!$iS->{gZz} || $gYz)) {
	              $hC = abmain::cUz("$iS->{cgi}?@{[$abmain::cZa]}cmd=rA;cG=$vH->{fI}", $hC, undef, $iS->{xXz});
	    }
 if($gQ) {
 $hC .= " \&nbsp;[". abmain::pT($vH->{pQ})." ". $vH->{rhost}. " <font size=1 color=#006600>".$vH->{track}."</font>]";
 }

 my $mood="";
 $mood = $iS->{$vH->{mood}} if $vH->{mood};
	    if(($vH->{size}||0)<0) {

	    }
	    elsif($dH) {

#not used
	    }else {  ## not inline text
		
 my $abs = "";
 if($vH->{fI} == $vH->{aK} && $iS->{top_abstract_len} > 40){
		    my $text= $iS->gB($vH->{fI});
		    $text =~ s/&nbsp;/ /gi;
		    $text =~ s!<br>|<p>!\n!gi;
 $text =~ s/<[^>]*>//gs;         
 $text =~ s/<//g;          
		    $abs = substr $text, 0, $iS->{top_abstract_len};
 	            if($iS->{auto_href_abs}) {
 		&jW::jEz(\$abs, $iS->{xZz});
 }
		
		    
		    if(length($abs)>10) {
		    	$abs = $iS->fGz($abs, 'abs_font');
			if($iS->{read_more_abs}) {
	                 	  my $lnk= abmain::cUz($url, $iS->{read_more_word}, undef,  $iS->{xYz});
				  $abs .= " ($lnk)";
			}
		    	$abs = $iS->{abs_begin}.$abs.$iS->{abs_end};
			$msg_hash{MSG_ABS} = $abs;
 }
		 }
 if($iS->{show_msgnos4sub} || ($vH->{fI} == $vH->{aK} && $iS->{show_msgnos4top})) {
 	push @print_buf,  "<b>$vH->{fI}</b>\&nbsp;\&nbsp;";
			$msg_hash{MSG_NUMBER} = $vH->{fI};
		 }
 if($vH->{fI} == $iZz ) {
			$here_mark =  $iS->{jRz};
 	push @print_buf,  $here_mark;
		 }
 push @print_buf,  "<!--$vH->{fI}-->" if($iZz eq 'HERETMP');
 push @print_buf,  qq(<a name="L$vH->{fI}"></a>);

		 $msg_hash{MSG_MOOD} = $mood;

 if($nolink) {
 	push @print_buf,   "$mood  $wW ", abmain::cUz($url, $iS->{nt_word}, undef,  $iS->{xYz}), $rateinsubj;
			$msg_hash{MSG_LINK} = "$wW ". abmain::cUz($url, $iS->{nt_word}, undef,  $iS->{xYz}). $rateinsubj;
 }else {
 	push @print_buf,   "$mood  <a $iS->{xYz} href=\"$url\">$wW</a>", $rateinsubj;
 push @print_buf,   " $iS->{nt_word}" if $nc;
 if($vH->{fI} == $iZz  && $iS->{nolink_here}) {
			$msg_hash{MSG_LINK} = "<b>".$wW."</b>";
 }else {
			$msg_hash{MSG_LINK} = "<a $iS->{xYz} href=\"$url\">$wW</a>". $rateinsubj;
			$msg_hash{MSG_LINK} .= " $iS->{nt_word}" if $nc;
		     }
 }
		 if ($iS->{no_show_poster}) {
		 	$hC = $wU = undef ;
			$msg_hash{MSG_POSTER} = undef;
 }else {
			$msg_hash{MSG_POSTER} = "<b>$hC</b> $wU";
		 }
		 if ($iS->{no_show_time}) {;
		 	$pt = $dF = "";
			$msg_hash{MSG_TIME} ="";
		 }
		 $msg_hash{MSG_FLAGS} = join(" ", @mtags);
 push @print_buf,   $iS->{sn_sep} if not $iS->{mAz};
 push @print_buf,   "<br>$abs" if $iS->{mAz};
 push @print_buf,  "$tdins1<b>$hC </b> $wU $tdins2 $iS->{nd_sep} $pt $iS->{ds_sep} $dF $tdins3\n";
		 push @print_buf,  "<br>$abs" if $abs && not $iS->{mAz};
 if ( ($iS->{fW} || $iS->{lVz} || $iS->{no_li}) && not $iS->{mAz} ) {
 	push @print_buf,   "<br>";
		 }
	      }

	      if($dH && $vH->{size}>=0) {
 if($vH->load($iS,1)) {
 	     my $mf;
	    	     if ($gYz ) {
	    	            $mf = $iS->{gKa}->{$vH->{hC}} || $iS->gXa($vH->{hC});
	    		    $iS->{gKa}->{$vH->{hC}} = $mf if not $iS->{gKa}->{$vH->{hC}};	
 	     }
 push @print_buf,   qq(<a name="$vH->{fI}"></a>\n);
 push @print_buf,  $iS->oOa($vH, $jK, $gV, $mf, $kQz); 
		     $vH->{body} = undef;
 } 
 }
	      if ($uL==1) {
		push @print_buf,   qq(</font> ) if ($fc && !$iS->{fW} && $jK != $in);
 	push @print_buf,   "</td></tr>\n";  
	      }
	      if($iS->{align_col_new} && not $dH) {
		if($del_chk) {
			$msg_hash{MSG_LINK} = $del_chk . $msg_hash{MSG_LINK};
		}
		if($here_mark) {
			$msg_hash{MSG_LINK} = $here_mark. $msg_hash{MSG_LINK};
		}
		my $layout = $iS->{msg_row_layout};
 		my $l = jW::mTa($layout, \@lB::msg_macs, \%msg_hash);
		my $po =  $hA%2;
		my $cls ;
		my $col;
		if($uL ==1) {
			$cls = ('ThreadRow0', 'ThreadRow1') [$po];
			$col = $mP[$po];
		}else{
			$cls = ('ThreadFollow0', 'ThreadFollow1') [$po];
			$col = $dR[$po];
		}
		my $cs;
		$cs = " bgcolor=$col" if($col);
		print $nA qq(<tr $cs class="$cls">$l</tr>\n);
			
	      }else {
	      	print $nA @print_buf;
	      }

 }  



 if ($jK > 0  && $jK == $vH->{fI} &&  $iS->{no_links_inmsg} ){
		next;
 }

 my $fpos = $iS->{aSz}->{$vH->{fI}}->[3] || 0;
 next if $jK ==0 && $fpos & 1;

 my $nM = 0;
 $nM = @{$vH->{bE}} if ref($vH->{bE});

 next if $nM <=0;



 if ($uL==0){
 if ($jK > 0  && ($iS->{lJ} || not $iS->{no_links_inmsg})){

 
 print $nA  qq(<div style="margin-left:10px">\n) if $iS->{xP};
 print $nA  $iS->{qE}, "\n";

	       print $nA  qq(\n<table width=$iS->{cYz} border="0" $bdcolor $bdextpad cellspacing=0><tr><td>\n);
	       print $nA  qq(<table width=100% border="0" cellpadding=$iS->{padsize} $bdinspace class="MsgFollowups");
 if ($iS->{follow_bg}) {
 	  print $nA  qq(bgcolor="$iS->{follow_bg}");
 }elsif ($bdcolor){
 print $nA  qq(bgcolor="#ffffff");
 }
 print $nA  qq( border="0" name=fl>);
 push @uN, [0, $uL, $hA, "</table>\n"];
 push @uN, [0, $uL, $hA, "</td></tr></table>\n"];
 
 push @uN, [0, $uL, $hA, "</div>\n"] if $iS->{xP};
	   $uL ++;
 
 }else {
	  if($iS->{align_col_new}  && not $iS->{aO}) {
	    print $nA qq(<table width="$iS->{cYz}" cellspacing=1 cellpadding="$iS->{padsize}" $bdcolor class="MsgListTable">);
	    if($iS->{msg_row_header}) {
		print $nA qq(\n<tr class="MsgRowHeader">$iS->{msg_row_header}</tr>\n);
	    }
	    if($iS->{msg_row_header_bottom} && $iS->{msg_row_header}) {
	       unshift @uN, [0,0,0, qq(\n<tr class="MsgRowHeaderBottom">$iS->{msg_row_header}</tr>\n)];
	    }
	    unshift @uN, [0,0,0, "\n</table>\n"];
 }

 }
 }

 # this is for the followup links
 if($uL ==1 ) {
		if(not ($iS->{mAz} || $iS->{align_col_new}) ) {
 print $nA  "<tr><td>\n";
 push @uN, [0, $uL, $hA, "</td></tr>\n"] ;
	        }	
 }

 my $nS = ($iS->{aO} && !$iS->{mJ})||
			   ($iS->{lJ} && $jK == $vH->{aK} && !$iS->{mJ}) || 
 $iS->{fW};

 my $ultype = "";
 $ultype=" type=square" if $iS->{use_square};
 if ($uL && !$nS) {
 print $nA  "\t" x $hO, "<ul$ultype>\n" if not $iS->{lVz};
 push @uN, [0, $uL, $hA, "</ul>\n"] if not $iS->{lVz};
 }
 my $me;
 my @lXz=();
 next if $iS->{no_links_inmsg} && $uL >=0 && $jK >0;
 
 
 if($uL==0) {
 my @yWz = @{$vH->{bE}};
 my $sort_func;
		if($iS->{yVz} eq 'mM') {
		   if ($iS->{allow_subcat} && $iS->{grp_subcat}) {
			@yWz = sort { $b->{scat} cmp $a->{scat} or 
				        ($iS->{revlist_topic}? $b->{mM}<=>$a->{mM}: $a->{mM} <=> $b->{mM}) 
 } @yWz ;
 }else {
			@yWz = sort {  ($iS->{revlist_topic}? $b->{mM}<=>$a->{mM}: $a->{mM} <=> $b->{mM}) 
					} @yWz;

 }
			@{$vH->{bE}}= @yWz;
		
		}else {
			for my $chld (@yWz) {
				$chld->{yTz} = 1 if $chld->{yTz} <=0;
			}
 if($iS->{yVz} eq 'yTz' ||$iS->{yVz} eq 'zCz' || $iS->{yVz} eq 'size' || $iS->{yVz} eq 'fI') {
 if($iS->{allow_subcat} && $iS->{grp_subcat}) {
					@yWz = sort {$b->{scat} cmp $a->{scat} or
					   	       ($iS->{revlist_topic}?
 	           		$b->{$iS->{yVz}} <=> $a->{$iS->{yVz}}:
 	           		$a->{$iS->{yVz}} <=> $b->{$iS->{yVz}}
 )
 } @yWz;
				}else {
					@yWz = sort {
					   	       ($iS->{revlist_topic}?
 	           		$b->{$iS->{yVz}} <=> $a->{$iS->{yVz}}:
 	           		$a->{$iS->{yVz}} <=> $b->{$iS->{yVz}}
 )
 } @yWz;
				}
			}else{
 if($iS->{allow_subcat} && $iS->{grp_subcat}) {
					@yWz = sort {$b->{scat} cmp $a->{scat} or
					   	       ($iS->{revlist_topic}?
 	           		$b->{$iS->{yVz}} cmp $a->{$iS->{yVz}}:
 	           		$a->{$iS->{yVz}} cmp $b->{$iS->{yVz}}
 )
 } @yWz;
				}else {
					@yWz = sort {
					   	       ($iS->{revlist_topic}?
 	           		$b->{$iS->{yVz}} cmp $a->{$iS->{yVz}}:
 	           		$a->{$iS->{yVz}} cmp $b->{$iS->{yVz}}
 )
 } @yWz;
				}
 }
			@{$vH->{bE}}= @yWz;
 }
 }
		
 my $shown_cat=0;
 my $scatname="";
 my $scatjump="";
 my $catlab="";
 my $scat="";
 my $cat="";
 
 next if ($uL >= $depth && $depth>0 && not $vH->{_expand});

 foreach $me (@{$vH->{bE}}) {
 next if ($me->{fI}||0) == ($vH->{fI}||0);
	      if($uL ==0) {
		    $catlab ="";
		    my $scatn="";
		    $scatn = $selmak->bDa($me->{scat}) if $selmak;
 my $catjump = $catjumper->($me->{scat});
 $cat= $me->{scat};
		    if($scatn ne $scatname) {
 if ($scatname) {
			    if($iS->{align_col_new} && not $iS->{aO}) {
				my $csp1 = int( $msg_row_col_cnt /2) || $msg_row_col_cnt;
				my $csp2 = $msg_row_col_cnt - $csp1;
 	$catlab=qq(\n<tr $iS->{scat_tb_attr}><td colspan="$csp1"><a name="cat$scat"></a><font $iS->{scat_font}>$scatname</font></td>);
				if($iS->{show_cat_jump} && not $gQ) {
				  $catlab .= qq(<form><td align="right" colspan="$csp2"> Go to $scatjump</td></form>) if $csp2>0;
				}else {
				  $catlab .= qq(<td align="right" colspan="$csp2"> &nbsp; </td>) if $csp2>0;
				}
 $catlab .=qq(</tr>\n);

 }else {
 	$catlab=qq(<a name="cat$scat"></a><table width="$iS->{cYz}" cellspacing="0" $iS->{scat_tb_attr}><tr><td><font $iS->{scat_font}>$scatname</font></td>);
				if($iS->{show_cat_jump} && not $gQ) {
				  $catlab .= qq(<form><td align="right"> Go to $scatjump</td></form>);
				}
 $catlab .=qq(</tr></table>);
			    }
 }
			$shown_cat = $scatname;
			$scatname = $scatn;
			$scatjump = $catjump;
			$scat = $cat;
		    }
 my $po = $hA%2;
 my $col=$dR[$po];
		    my $cls = ('ThreadTable0', 'ThreadTable1')[$po];
 my $str =qq(<table width="$iS->{cYz}" cellspacing=0 $bdextpad $bdcolor><tr><td>);
 $str .=qq(<table width="100%" $bdinspace cellpadding=$iS->{padsize} class="$cls" );
 $str .= qq(bgcolor="$col" ) if $col;
 $str .= " name=om>\n";
		    my $banner="";
 if($iS->{banner_freq}>0 && ($hA % $iS->{banner_freq}) ==0 && $hA >0) {
			$banner = abmain::mNa(time());
 }
 if(($me->{fI}==$me->{aK} || !$iS->{sub_top_bottom})) {
 	push @uN, [0, $uL, $hA, $catlab] if ($catlab && $iS->{grp_subcat});
 	push @uN, [0, $uL, $hA, $iS->{rP}] if $iS->{rP};
			if ($banner ) {
				if(not $iS->{align_col_new}) {
					push @uN, [0, $uL, $hA, $banner];
				}else{
					push @uN, [0, $uL, $hA, qq(<tr><td colspan="$msg_row_col_cnt">$banner</td></tr>)];
				}
			}
 	push @uN, [0, $uL, $hA, "</table></td></tr></table>\n"] if not ($iS->{align_col_new} && not $iS->{aO});
 	push @uN, [$me, $uL+1, $hA];
 	push @uN, [0, $uL, $hA, $str] if ($iS->{aO} || not $iS->{align_col_new});
 	$hA++;
 }else {
 	unshift @uN, [0, $uL, $hA, $str] if ($iS->{aO} || not $iS->{align_col_new});
 	unshift @uN, [$me, $uL+1, $hA];
 	unshift @uN, [0, $uL, $hA, "</table></td></tr></table>\n"] if not ($iS->{align_col_new} && not $iS->{aO});

			if ($banner) {
				if(not $iS->{align_col_new}) {
					unshift @uN, [0, $uL, $hA, $banner];
				}else {
					unshift @uN, [0, $uL, $hA, qq(<tr><td colspan="$msg_row_col_cnt">$banner</td></tr>)];
				}
			}

 	unshift @uN, [0, $uL, $hA, $iS->{rP}] if $iS->{rP};
 	unshift @uN, [0, $uL, $hA, $catlab] if ($catlab && $iS->{grp_subcat});
 	$hA++;
 }
 next;
	      }
 next if not $lB::sL;  
 if($iS->{revlist_reply}) {
 unshift @lXz, [$me, $uL+1, $hA];
 }else {
 push @uN, [$me, $uL+1, $hA];
 }
 }
 if($uL==0 && $scatname && $shown_cat ne $scatname) {
		if($iS->{aO} || not $iS->{align_col_new} ) {
 	$catlab=qq(\n<a name="cat$cat"></a><table width="$iS->{cYz}" cellspacing="0" $iS->{scat_tb_attr}><tr><td><font $iS->{scat_font}>$scatname</font></td>);
			if($iS->{show_cat_jump} && not $gQ) {
				  $catlab .= qq(<form><td align="right"> Go to $scatjump</td></form>);
			}
 $catlab .=qq(</tr></table>\n) ;
		}else {
			my $csp1 = int( $msg_row_col_cnt /2) || $msg_row_col_cnt;
			my $csp2 = $msg_row_col_cnt - $csp1;
 		$catlab=qq(\n<tr $iS->{scat_tb_attr}><td colspan="$csp1"><a name="cat$cat"></a><font $iS->{scat_font}>$scatname</font></td>);
			if($iS->{show_cat_jump} && not $gQ) {
			  $catlab .= qq(<form><td align="right" colspan="$csp2"> Go to $scatjump</td></form>) if $csp2>0;
			}else {
				  $catlab .= qq(<td align="right" colspan="$csp2"> &nbsp; </td>) if $csp2>0;
			}
 $catlab .=qq(</tr>\n);
		}
 push @uN, [0, $uL, $hA, $catlab] if $iS->{grp_subcat};
 }
 push @uN, @lXz if @lXz;
 }
 $iS->{dyna_forum} = $od;
}

1;

1;
# end of lB::jN
