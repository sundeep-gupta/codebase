# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 5909 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/gU.al)"
sub gU {
 my ($self, $aK, $par, $upldcnt, $privusr, $attachfid) = @_;
 my ($gD, $fE, $fT, $iH, $hF, $oto, $xE);

 if($par>0) {
	  my $sV = $self->pO($par);
 abmain::error('inval', "Reply to this message is disabled") if $sV->{xE} & $pYz;
 ($gD, $fT, $iH, $hF, $oto)
 = ($sV->{wW}, $sV->{hC}, 
	         abmain::dU('S', $sV->{mM}, 'oP'),
 $self->jA($par),
 $sV->{to}
	        );
 $xE = $sV->{xE};
	$fE = $self->gB($sV->{fI});
 	$self->fZa(\$fE, 1); 
 	$fE =~ s/\cM//g;
 	$fE =~ s/\n\n/<p ab>/g;
	my ($xZa, $oid);
	if($sV->{attached_objtype}) {
		($xZa, $oid) = ($sV->{attached_objtype}, $sV->{attached_objid});
 	}
 	if($xZa && $oid ne "") {
		my $bRaA = $self->wPa();	
		my $astr =  $bRaA->yNa($xZa, $oid);
		$fE .= $astr;
 	}

 }

 my $gO = $par>0? "${\($self->{uI})}:  $gD by $fT": $self->{name};
 my $cgi        = $self->{cgi}; 
 my $fC        = $self->fC();
 if($par >0) {
 my $igflag = $self->mWa(lc($fT), lc($self->{fTz}->{name}));
 	if($igflag ==1 ) {
		abmain::error('inval', "You are being ignored by $fT");
 	}elsif($igflag == 2) {
		abmain::error('inval', "You are ignoring $fT");
 	}
 }
 if($privusr ne "" && not $self->{kWz}) {
		abmain::error('deny', "Private messaging disabled");
 }
	
$self->eMaA([qw(other_header other_footer form_banner)]);

my $header =$self->{other_header};
my $footer =$self->{other_footer};

my $xstyle ;
$xstyle = abmain::htmla_code() if $self->{try_wysiwyg};
my $spelljs;
if($abmain::enable_speller) {
 $spelljs= $abmain::spell_js;
}

my $gU = qq(<html> <head> $spelljs <title>Post: $gO</title>);
if(length($header)< 5 ) {
$gU .= qq( 
$self->{sAz}
$xstyle
</head><body> <center>
<h1> <font COLOR="#DC143C">$gO</font> </h1>
<HR NOSHADE WIDTH="80%"> </center>
<br/>
);
}else {

 $header =~ s!</head>!$self->{sAz}\n$xstyle</head>!i;
 $gU .= $header;
}

$gU .= $self->{form_banner};
 
if($par >0) {
 $gU .= qq@
 <table width="90%" cellspacing="1" align="center">
 <tr>
 <th align="left" bgcolor="$self->{cfg_head_bg}"><font $self->{cfg_head_font}>$self->{sB}$self->{rK}: \&nbsp; $gD</font></th></tr>
 <tr><td  bgcolor="$self->{bIz}">
 $fE
 $self->{msg_sep2}
 </td></tr></table><p>
 @ if $self->{pZz};
}

$gU .= qq@
 <a name="post"></a>
@;

$gU .= $self->nO($aK, $par, $gD, $fE, $fT, $oto, $upldcnt, $privusr, $xE, $attachfid);

my $inithtmla;
if($self->{try_wysiwyg} && $self->{fTz}->{use_fancy} ne 'no') {
	$inithtmla=qq!\n<script type="text/javascript" defer="1"> HTMLArea.replace("htmlbody");</script>\n!;
}

$gU .= $inithtmla;
if(length($footer)<10) {
	$gU .= qq(<p><hr><p></body></html>);
}else {

 $gU .= $footer;
}

return $gU;

}

# end of jW::gU
1;
