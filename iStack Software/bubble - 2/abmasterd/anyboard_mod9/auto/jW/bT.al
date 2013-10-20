# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 4017 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/bT.al)"
sub bT {
 my ($self,  $cG, $gV, $hO, $no_up, $recur_cnt) = @_;
 my $eC = $self->{dA}->{$cG};
 my $i=0;
 return unless $eC &&  $eC->{fI} == $cG;
 return if $self->{_regened_mnos}->{$cG};

 if( (not $eC->qRa()) && $self->{aO}){
	return;
 }

 $recur_cnt =0 if not $recur_cnt;
 if($recur_cnt > 1000) {
	print STDERR "exceeed recursion limit, possible corruption of index\n";
 }




 if($self->{lJ} ) {
 return if $self->{cXa};
 if($cG != $eC->{aK}) {
 return if not $self->{dA}->{$eC->{aK}};
 return $self->bT($eC->{aK}, $gV, $hO, $no_up, 1+$recur_cnt);
 }
 }

 my $od = $self->{dyna_forum};
 $self->{dyna_forum} = 1 if $eC->{to};
 my $aD = $self->fA($cG, $gV, $eC->qRa());
 my $wW = $eC->{wW};

 if(not $self->{_inited_msg_header}) {
 	$self->eMaA( [qw(msg_header other_footer msg_banner msg_footer)]);
 	$self->{_inited_msg_header} =1;
 }
 my $header =$self->{msg_header};

 open(kE, ">$aD" ) || abmain::error($!. ": $aD");
 print kE qq(<html><head><title>$wW</title>\n$self->{sAz}\n);

 if(length($header)>5) {
 print kE qq(<META HTTP-EQUIV="Expires" CONTENT="0">\n<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">) if($self->{lJ});
 print kE $header;
 }else {
 print kE qq(<META HTTP-EQUIV="Expires" CONTENT="0">\n<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">)
 if($self->{lJ});
 print kE "</head><body>"
 }
 my $ad = abmain::plug_in();

 if($self->{ySz}) {
	    print kE $self->yHz($gV), "\n";
 }

 print kE qq(<center>$ad</center>) if $self->{show_plugin};
 print kE $self->{msg_banner};
 my $pub = 'p' if not $eC->qRa();
 
 my $il_saved;    
 if($eC->qRa()) {
	$il_saved = $self->{aO};
	$self->{aO} = 0;
 }

 $eC->jN(iS=>$self, nA=>\*kE, hO=>0, jK=>$cG, gV=>$gV, pub=>$pub);
 if($self->{_verbose}) {
	print "\@".$eC->{fI}.' ';
 }

 if($eC->qRa()) {
	$self->{aO} = $il_saved;
 }

 my $footer =$self->{msg_footer};
 if(length($footer) > 8) {
 	 print kE $footer, "\n";
 } else {
 	 print kE qq(</center></body></html><!--@{[$abmain::func_cnt]}-->);
 }
 print kE qq(<!--@{[$abmain::func_cnt]}-->);

 close(kE);
 $self->{_regened_mnos}->{$eC->{fI}} =1;

 $self->{dyna_forum} = $od;
 return if $self->{cXa};

 my $sV = $eC->aI($self);
 $self->{dyna_forum} = $od;

 return if not (($sV->{to} && $eC->{to}) || $sV->{to} eq $eC->{to});
 if(not $no_up) {
 	$self->bT($sV->{fI}, $gV, $hO+1, $no_up, 1+$recur_cnt) 
 if $sV && $sV->{fI}>0 ;
 }
 if($self->need_macro_in_msg('SIBLING_MSG_LINKS')) {
 if($hO ==0 && $eC->{aK} ne $eC->{fI} && $sV) {
	for my $node (@{$sV->{bE}}) {
		next if $node->{fI} eq $eC->{fI};
		$self->bT($node->{fI}, $gV, $hO+1, 1, 1+$recur_cnt);
	}
 }
 }
 $self->{dyna_forum} = $od;

}

# end of jW::bT
1;
