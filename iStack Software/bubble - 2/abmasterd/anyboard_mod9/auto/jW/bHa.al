# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 4368 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/bHa.al)"
sub bHa{
 my ($self, $iD, $gV, $istop)= @_;
 

 my $cgi = $self->{cgi} ."?";
 my $amcnt= $self->{iW};
 $cgi .= "gV=1;hEz=1;" if $gV;
 
 my $pg=0;
 $pg = $jW::hDz if $jW::hDz;
 $abmain::def_link_attr =qq(class="nav");
 my $wholnk = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=bRa;from=Forum;all=1;verbose=1", $self->{online_stats_word});
 my $statslnk = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=vJz", $self->{stats_word});

 my ($aL, $aV, $tP, $sI, $tO, $fNz, $golink, $rS, $uA, $qOz, $qJz, $plink, $chatlink, $reloadlink, $gflink, $dblink, $fplink) = ();
 
 for(($aL, $aV, $tP, $sI, $tO, $fNz, $golink, $rS, $uA, $qOz, $qJz, $plink, $chatlink, $reloadlink, $gflink, $dblink, $fplink)){
 $_ = '&nbsp;';
 }
 my $kYz =  abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=myforum", "$self->{kRz}")||'&nbsp;';
 $plink = qq(<a href="${cgi}@{[$abmain::cZa]}cmd=form;upldcnt=$self->{def_extra_uploads}">$self->{uH}</a>);
 $fplink = qq(<a href="${cgi}@{[$abmain::cZa]}cmd=yEa">$self->{post_form_word}</a>);
 $dblink = qq(<a href="${cgi}@{[$abmain::cZa]}_aefcmd_=wIa">$self->{db_word}</a>);
 my $hGz;
 my $gKz = $self->{logo_link} || abmain::cUz($abmain::uE, qq(<img border="0" src="${cgi}@{[$abmain::cZa]}cmd=vL"/>), "_top");

 if(not $self->{kWz}) {
 $kYz  = '&nbsp;';
 }
 if($self->{gBz}) {
 $tP .= abmain::cUz("${cgi}@{[$abmain::cZa]}cmd=yV", $self->{sK}, "");
 }
 if($self->{enable_login} || $self->{tHa}) {
 $fNz= abmain::cUz("${cgi}@{[$abmain::cZa]}cmd=dW", $self->{fKz});
 }
 if($iD ) {
 my $url = $gV? $self->pRa(): $self->dKz();
 $aL = abmain::cUz($url, $self->{tA}, "_self");
 }
 $hGz = $jW::hDz +1;
 my $kUz = abmain::wS($self->{kUz});
 
 if($self->{fV} > 1) {
 $aV= abmain::cUz("${cgi}@{[$abmain::cZa]}cmd=vXz;pgno=$hGz;kQz=$kUz",$self->{tE}, "_self");
 
 }
 my $vofp= $abmain::gJ{ofpage} ne "" ? "A" : "";
 if( 1 || $self->{nLz} >1) {
 my $imgurl="${cgi}@{[$abmain::cZa]}cmd=vL;img=1";
 $imgurl = $self->{gobtn_url} if $self->{gobtn_url};
 $golink = qq(<table border="0" cellspacing=0 cellpadding=0><tr>
<form action="${cgi}" method="GET"><td><font size="-1">
 				@{[$abmain::cYa]}
<select name="pgno" onchange="location='${cgi}@{[$abmain::cZa]}cmd=vXz;kQz=$kUz;ofpage=$vofp;pgno='+this.options[this.selectedIndex].value">);
	 for(my $i=0; $i<4; $i++) {
		my $h = 1.5 * 2**$i;
		my $t = $h/24;
 	$golink .= qq(<option value="-$t">$h hours);
	 }
 	 $golink .= qq(<option value="-1">Today's);
 	 $golink .= qq(<option value="-9999">last visit -);
 for(my $i=0; $i<$self->{nLz}; $i++) {
 my $p = $i+1;
 my $sel= ""; $sel = "SELECTED" if $i == $jW::hDz;
 $golink .= qq(<option value="$i" $sel>page $p);
 }
 $golink .= qq(</select></font></td><td valign="middle"><input type="hidden" name="cmd" value="vXz"> <input type="hidden" name="kQz" value="$kUz">\&nbsp; <input align="middle" type=image alt="Go" name="Go to page" src="$imgurl" border="0"></td></form></tr></table>);
 }

 if($self->{qR}) {
 $rS= abmain::cUz("${cgi}@{[$abmain::cZa]}cmd=jB", $self->{tD});
 }

 $chatlink= abmain::hFa("${cgi}@{[$abmain::cZa]}cmd=gochat", $self->{gochat_word}, 'chatwin')
 if $self->{enable_chat};
 my $ofpage=$jW::hDz ||"0";
 if($jW::hDz ne 'A' && $vofp eq ""){
 	$sI= abmain::cUz("${cgi}@{[$abmain::cZa]}cmd=vXz;pgno=A;ofpage=$ofpage;depth=1;kQz=$kUz", $self->{tB}, "_self")
 }else {
 	$sI= abmain::cUz("${cgi}@{[$abmain::cZa]}cmd=vXz;pgno=$ofpage;kQz=$kUz", $self->{full_view_word}, "_self")

 }
 $uA= abmain::cUz("${cgi}@{[$abmain::cZa]}cmd=log", $self->{wV});
 $qOz = $self->dRz(0); 
 $qJz =  $self->dRz(1) if -f  $self->dHz();
 $tO= "\&nbsp;" . abmain::cUz("${cgi}@{[$abmain::cZa]}cmd=qL", $self->{tC});
 $gflink= "\&nbsp;" . abmain::cUz("${cgi}@{[$abmain::cZa]}cmd=gfindform", $self->{gfind_word});
 my $tagslink= "\&nbsp;" . sVa::hFa("${cgi}@{[$abmain::cZa]}cmd=viewtags", $self->{tags_word}, "_tags");
 $reloadlink = abmain::cUz("javascript:location.reload()", $self->{reload_word});
 my $tN = $self->{dI};



 my $dL = $self->{pC} ? @{$self->{pC}} : 0;
 my $sW = $self->{fV} + $dL -1;
 my $tT = $self->{fV}."-"."$sW/$tN";
 $tT = $self->fGz($tT, 'msg_cnt_font');

 my $tJ;

 my $kVz="";
 my $navbdcolor; $navbdcolor=qq(bgcolor="$self->{navbdcolor}") if $self->{navbdcolor};
 $kVz ="$self->{kUz}'s " if $self->{kUz};
 $kVz .= $self->fGz($self->{name}, 'fDz') if($self->{dBz});
 my $nbar ;
 my $tit_str=qq(<td>\&nbsp;\&nbsp\&nbsp;<b>$kVz</b> $tT</td>); $tit_str ="" if $self->{fDz} eq 'undef';
 my $x_str = qq(<td>$gKz</td>); $x_str ="" if $gKz eq 'undef';
 my ($navobg, $navibg);
 $navobg= qq(bgcolor="$self->{navbdcolor}") if $self->{navbdcolor} =~ /\S/;
 $navibg= qq(bgcolor="$self->{navbarbg}") if $self->{navbarbg} =~ /\S/;
 my $leftins = $istop? $self->{navbar_ul}: $self->{navbar_bl};
 my $rightins = $istop? $self->{navbar_ur}: $self->{navbar_br};
 
 my $surveylnk = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=tOz", $self->{survey_word});
 my $memberlnk = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=kPz;hIz=365", $self->{members_word});
 my $evelnk = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=tVz", $self->{events_word});
 my $linkslnk = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=wMz", $self->{links_word});
 my $usrcpl = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=usercp", $self->{usercp_word});
 my $par_links = abmain::lPz($self->{eD});
 my $all_fs ="";
 $all_fs = abmain::gIaA() if $self->{compute_forum_list};
if(! $gV) {
 $self->{_navbarhash} = {
 POSTLNK=>$plink, FINDLNK=>$tO, OVERVIEWLNK=>$sI, PREVLNK=>$aV, 
 NEWESTLNK=>$aL, REGLNK=>$tP, LOGINLNK=>$fNz, OPTLNK=>$rS, 
 ADMLNK=>$uA, GOPAGEBTN=>$golink, MAINLNK=>$qOz, ARCHLNK=>$qJz, 
		  RELOADLNK=>$reloadlink, MYFORUMLNK=>$kYz, 
		  STATSLNK=>$statslnk, WHOLNK=>$wholnk, TAGSLNK=>$tagslink, QSRCHLNK=>$gflink, DBLNK=>$dblink,
		  FPOSTLINK=>$fplink,
		  LINKSLNK => $linkslnk,
		  MEMBERLNK=>$memberlnk,
		  SURVEYLNK => $surveylnk,
		  EVELNK   => $evelnk,
		  ALL_FORUMS_LIST => $all_fs,
		  CHATLNK  => $chatlink,
		  USERCPANELLINK =>$usrcpl,
		  PAR_LINKS=>$par_links,
		  FORUMNAME=>$self->{name},
		  QSEARCHBOX =>$self->gMaA(),
 }
 ;
 $nbar = mTa($self->{navbar_layout}, \@jW::gLa, $self->{_navbarhash});

$tJ = qq@
<table cellpadding=$self->{navbdsize} cellspacing=0 border="0" $navobg width=$self->{cYz}><tr><td>
<table cellpadding=$self->{navbdpad} $navibg width=100% $self->{navbarattr}>
<tr>
$leftins
$tit_str $nbar $x_str
$rightins
</tr> 
</table>
</td></tr></table>
@;

} else {

	$self->{_navbarhash} = {
 POSTLNK=>$plink, FINDLNK=>$tO, OVERVIEWLNK=>$sI, PREVLNK=>$aV, 
 NEWESTLNK=>$aL, REGLNK=>$tP, LOGINLNK=>$fNz, OPTLNK=>$rS, 
 ADMLNK=>$uA, GOPAGEBTN=>$golink, MAINLNK=>$qOz, ARCHLNK=>$qJz, 
		  RELOADLNK=>$reloadlink, MYFORUMLNK=>$kYz, 
		  STATSLNK=>$statslnk, WHOLNK=>$wholnk, TAGSLNK=>$tagslink, QSRCHLNK=>$gflink, DBLNK=>$dblink,
		  LINKSLNK => $linkslnk,
		  MEMBERLNK=>$memberlnk,
		  SURVEYLNK => $surveylnk,
		  EVELNK   => $evelnk,
		  ALL_FORUMS_LIST => $all_fs,
		  CHATLNK  => $chatlink,
		  USERCPANELLINK =>$usrcpl,
		  PAR_LINKS=>$par_links,
		  FORUMNAME=>$self->{name},
		  QSEARCHBOX =>$self->gMaA(),
 };
 
 
 $nbar = mTa($self->{navbar_layouta}, \@jW::gLa, $self->{_navbarhash});

$tJ = qq@
<table bgcolor="$self->{nNz}" width=$self->{cYz} $self->{navbarattr}>
<tr>
$leftins
$tit_str $nbar
$rightins
</tr></table>
@;
}

 $self->fQaA();
 $abmain::def_link_attr = "";
 return  $tJ;

}

# end of jW::bHa
1;
