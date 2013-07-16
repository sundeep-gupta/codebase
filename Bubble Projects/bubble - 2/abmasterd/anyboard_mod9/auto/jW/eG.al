# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 4596 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/eG.al)"
sub eG {
 my ($self, $nA, $iD, $gV, $aW)= @_;

 $self->aFz(undef, $gV? "a" : undef);

 if($self->{dDz}) {
 $self->dPz($gV);
 }
 $self->vPz() if ((! -f $self->xMz()) || (stat($self->xMz()))[9] < (stat($self->nCa()))[9]); 
 my ($eS, $realfile);
 $self->oF(LOCK_EX, 5);
 my $regen_chk = $self->{iAa};
 if($regen_chk && not &$regen_chk){
 	$self->pG(5);
	return;
 }
 if(!$nA) {
 $eS = $gV?$self->dHz(): $self->dGz();
 if($jW::use_tmp) {
 $realfile =  $self->tmpfile();
 }else {
 $realfile = $eS;
 }
 $realfile =~ s/`|;//g;
 	open iR, ">$realfile" or abmain::error('sys', "On writing file $realfile: $!");
	$nA = \*iR;
 }
 my $title = $self->{name};
 $title .= " Archive" if $gV;

 my $cgi = $self->{cgi} ."?";
 my $amcnt= $self->{iW};
 $cgi .= "gV=1;hEz=1;" if $gV;
 
 my $header =$self->{forum_header};
 my $footer =$self->{forum_footer};

 my $fC = $self->fC();

 my $menus1= $self->wGz() if $self->{show_menu};
 my $menus2 =$self->hCa('X') if $self->{show_menu};

 if(length($header) >6) {
 if( not $header =~ s/<head>/<head>$self->{sAz}/i) {
 		$header =~ s!<html>!<html><head>$self->{sAz}</head>!i;
	       };
 }else {
 $header =  qq(<html><head><title>$title</title> 
 <META HTTP-EQUIV="expires" CONTENT="0">
 <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
 $self->{sAz}
 </head><body>);
 }
 if($self->{dDz}) {
 if($header =~ /<head>/i) {
 $header =~ s/<head>/<head><base target="MSGA"><basefont size="-1">/i;
 }else {
 $header =~ s/<html>/<html><base target="MSGA">/i;
 }
 }
 my $tJ = $self->bHa($iD, $gV, 1);

 my $pg=0;
 $pg = $jW::hDz if $jW::hDz;
 print $nA &mTa($header, \@jW::gLa, $self->{_navbarhash});
 print $nA "\n".$abmain::lRz;

 print $nA $abmain::kSz;
 print $nA <<"EOF_JS";
 var cook = new Cookie(document, "$self->{vcook}", 2400, "/");
 cook.load();
 cook['lastv0'] = cook['lastv1'];
 cook['lastv1'] =  ${\(time())};
 cook['vpage']= "$pg";
 cook.store();
EOF_JS

 print $nA "\n".$abmain::js_end;
 #print $nA "\n", $menus1;

 print $nA "".sVa::tWa();
 my $ad = abmain::plug_in();

 my $forum_ad = '';
 $forum_ad = $ad if $self->{show_plugin};
 my $forum_banner =  &mTa($self->{forum_banner}, \@jW::gLa, $self->{_navbarhash});

 if($self->{show_menu}){
 print $nA <<"KKKK";
<script language="JavaScript1.2">
$menus2
window.onLoad = loadMenuX;
function showm() { window. pOz(window.pmenu); }
function showm2() { window. pOz(window.mX); }
#document.onMouseDown = showm;
</script>
KKKK

}else {

#    print $nA qq(\n<script>function showm2() {}</script>\n); 
}

 #require gPaA;
 #my $msg_a = tie *PRINTBUF, 'gPaA';

 my $tmp2 = $self->tmpfile()."_";
 open PRINTBUF, ">$tmp2" or abmain::error('sys', "On writing to file $tmp2:$!");
 my $fh_b = \*PRINTBUF;
 

 print $fh_b qq(<div class="ABMSGAREA">);
 print $fh_b $tJ if not $self->{iWa};
 my $jK = ($nA == \*STDOUT || $self->{mFa})? -1 :0;
 print $fh_b &mTa($self->{cWz}, \@jW::gLa, $self->{_navbarhash});

 if(@{$self->{eN}->{bE}} ==0 ) {
 print $fh_b "<p><center>Start by clicking on the <b>$self->{uH}</b> link.</center>";
 }else {
 $self->{eN}->jN(iS=>$self, nA=>$fh_b, jK=>$jK, 
 depth=>$self->{hG}, gV=>$gV, kQz=>$self->{kUz},
				     pub=>$self->{kUz}?0:'p');
 }
 if($self->{rV}){
 print $fh_b &mTa($self->{cXz}, \@jW::gLa, $self->{_navbarhash});
 	print $fh_b $self->bHa($iD, $gV, 0);
 }
 print $fh_b "</div>";
 
 close PRINTBUF;
 open PRINTBUF, "<$tmp2";
 my $forum_msg_area= join("", <PRINTBUF>);
 close PRINTBUF;
 unlink $tmp2;
	

#    print $nA "\n", " "x256,  "<!--@{[$abmain::VERSION]}, @{[$abmain::license_key]}/$self->{iGz}-->\n";

 my $forum_bottom_banner =  &mTa($self->{forum_bottom_banner}, \@jW::gLa, $self->{_navbarhash});
 $self->{_navbarhash}->{FORUM_TOP_BANNER}= $forum_banner;
 $self->{_navbarhash}->{FORUM_BOTTOM_BANNER}= $forum_bottom_banner;
 $self->{_navbarhash}->{FORUM_AD}= $forum_ad;
 $self->{_navbarhash}->{FORUM_DESC_FULL}= $self->{forum_desc_full};
 $self->{_navbarhash}->{FORUM_MSG_AREA}= $forum_msg_area;

 if ($self->{forum_layout} !~ /FORUM_MSG_AREA/) {
 	print $nA "Configuration problem: forum layout does not contain FORUM_MSG_AREA";
 $self->{forum_layout} = qq(FORUM_MSG_AREA);
 }
	
 print $nA  &mTa($self->{forum_layout}, \@jW::gLa, $self->{_navbarhash});

 if(length($footer)>6) {
 print $nA &mTa($footer, \@jW::gLa, $self->{_navbarhash});
 }else {
 print $nA qq(<p><hr></body></html><!--@{[$abmain::func_cnt]}-->);
 }
 print $nA qq(<!--@{[$abmain::func_cnt]}-->);
 close $nA;
 if($realfile && $realfile ne $eS ) {
 rename $realfile, $eS or abmain::error('sys', "On renaming to $eS: $!");
 }
 $self->pG(5);
 return if !$aW;

 my $nM = @{$self->{eN}->{bE}};
 for(my $i=$nM-1; $i>=0; $i--) {
 my $cD = $self->{eN}->{bE}->[$i];
	     $self->bT($cD->{fI}, $gV,0,1);
 }
 abmain::pZa();
}

# end of jW::eG
1;
