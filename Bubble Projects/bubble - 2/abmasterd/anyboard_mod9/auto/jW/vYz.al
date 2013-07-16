# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 4242 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/vYz.al)"
sub vYz {
 my ($self, $curpos)= @_;

 my $title = $self->{name};

 my $cgi = $self->{cgi} ."?";
 
 my $header =$self->{idx_tframe_head};
 my $footer =$self->{idx_tframe_foot};

 my $fC = $self->fC();

 if(length($header) >6) {
 }else {
 $header =  qq(<html><head><title>$title</title> 
 <META HTTP-EQUIV="expires" CONTENT="0">
 <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
 <META HTTP-EQUIV="pragma" CONTENT="no-cache">
 $self->{sAz}
 </head><body>
 )
 }
 if($header =~ /<head>/i) {
 $header =~ s/<head>/<head>$self->{sAz}\n<base target="ginfo">/i;
 }else {
 $header =~ s!<html>!<html><head>$self->{sAz}\n<base target="ginfo"></head>!i;
 }

 my ($myforumlnk, $tP, $fNz, $uA, $qOz, $qJz, $plink, $chatlink, $surveylnk, $memberlnk, $evelnk, $linkslnk, $statslnk, $fplink);
 for (($myforumlnk, $tP, $fNz, $uA, $qOz, $qJz, $plink, $chatlink, $surveylnk, $memberlnk, $evelnk, $linkslnk)) {
 $_ = '&nbsp;';
 }
 
 $myforumlnk =  abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=myforum", "$self->{kRz}") if $self->{kWz};

 $plink = abmain::cUz("${cgi}@{[$abmain::cZa]}cmd=form;upldcnt=$self->{def_extra_uploads}", $self->{uH});
 $fplink = abmain::cUz("${cgi}@{[$abmain::cZa]}cmd=yEa", $self->{post_form_word});

 my $gKz = $self->{logo_link} || abmain::cUz($abmain::uE, qq(<img border="0" src="${cgi}@{[$abmain::cZa]}cmd=vL"/>), "_top");

 if($self->{gBz}) {
 $tP = abmain::cUz("${cgi}@{[$abmain::cZa]}cmd=yV", $self->{sK}, "");
 }
 if($self->{enable_login} || $self->{tHa}) {
 $fNz= abmain::cUz("${cgi}@{[$abmain::cZa]}cmd=dW", $self->{fKz});
 }
 my $wholnk = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=bRa;from=Forum;all=1;verbose=1", $self->{online_stats_word});

 $chatlink= sVa::hFa("${cgi}@{[$abmain::cZa]}cmd=gochat", $self->{gochat_word}, 'chatwin') if $self->{enable_chat};
 $uA= abmain::cUz("${cgi}@{[$abmain::cZa]}cmd=log", $self->{wV});
 $qOz = $self->dRz(0); 
 $qJz =  $self->dRz(1) if -f  $self->dHz();
 $surveylnk = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=tOz", $self->{survey_word});
 $memberlnk = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=kPz;hIz=365", $self->{members_word});
 $evelnk = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=tVz", $self->{events_word});
 $linkslnk = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=wMz", $self->{links_word});
 $statslnk = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=vJz", $self->{stats_word});
 my $cpl= abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=usercp", $self->{usercp_word});
 my $fplink = qq(<a href="$self->{cgi}?@{[$abmain::cZa]}cmd=yEa">$self->{post_form_word}</a>);
 my $dblnk = qq(<a href="$self->{cgi}?@{[$abmain::cZa]}_aefcmd_=wIa">$self->{db_word}</a>);
 my $gbar = mTa($self->{idx_nav_cfg}, \@jW::idx_tags, 
 {
 REGLNK=>$tP, 
		STATSLNK =>$statslnk,
		WHOLNK=>$wholnk,
		DBLNK =>$dblnk,
		FPOSTLINK=>$fplink,
	        LOGINLNK=>$fNz,
		 ADMLNK=> $uA,
		 MAINLNK=> $qOz, ARCHLNK=> $qJz, 
 CHATLNK=> $chatlink, MYFORUMLNK=> $myforumlnk, MEMBERLNK=> $memberlnk,  POSTLNK=>$plink,  
SURVEYLNK=>$surveylnk, EVELNK=>$evelnk, FORUMNAME=>$title, LINKSLNK=>$linkslnk,
USERCPANELLINK=>$cpl}
);
 sVa::gYaA "Content-type: text/html\n\n";
 print $header, "\n", sVa::tWa(), "\n", $gbar, $footer;
}

# end of jW::vYz
1;
