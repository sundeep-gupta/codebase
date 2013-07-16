# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 3262 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/nYa.al)"
sub nYa{
 my ($self, $tK, $gV, $wT, $find_img, $sti, $eti, $toponly, $scat) = @_; 

 my $eS = $gV? $self->nDz('archlist') : $self->nDz('msglist') ;
 my $pN = [];

 abmain::error('inval', "Fail to compile jK $tK: $@") if not defined(eval '/$tK/');
 my $jGz= jW::jFz($tK);

 my $kQz = $self->{kUz};
 if($gV) {
 $self->{aIz} =1;
 }

 my $max_ret=$self->{max_match_cnt};
 
 my $filt = sub  {
 my ($row) = @_;
 my $entry = {};
 @{$entry}{@lB::mfs} = @$row;
 return if $toponly && ($entry->{aK} != $entry->{fI});
 return if $entry->{to} && not (jW::sFa($entry->{to}, $kQz)  || $entry->{hC} eq $kQz);
 return if ($eti && $entry->{mM} > $eti);
 return if ($entry->{mM} < $sti);
 return if ($find_img && ($entry->{xE} & $pTz)==0);
 return if $scat && $entry->{scat} ne $scat;
 if($self->{aWz}) {
 return if ($self->{aLz}->{$entry->{fI}} && (not $self->{aGz}));
 return if (!$self->{aLz}->{$entry->{fI}} && (not $self->{aIz}));
 }
 if(!$tK) {
	return 1;
 }
 if(&$jGz($entry->{hC}) || &$jGz($entry->{key_words}) ||  &$jGz($entry->{wW}) || &$jGz($entry->{pQ}) || &$jGz($entry->{eZz}) || &$jGz($entry->{rhost}) || &$jGz($entry->{track}) || &$jGz(join(" ", $entry->{jE}, $entry->{aK}, $entry->{fI})) ) {
	return 1;
 }elsif($wT && $self->{allow_body_search}) {
 my $data = $self->yO($entry->{fI});
 return 1 if(&$jGz($data));
 }  
 return;
 };

 my $linesref = $bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) } )->iQa({filter=>$filt, maxret=>$max_ret});
 my $match_cnt=0;
 my $nM = scalar(@$linesref);
 my $sidx =0;
 if($self->{max_match_cnt} >0 && ($nM> $self->{max_match_cnt})) {
	$sidx = $nM- $self->{max_match_cnt};
 }
 
 for(;$sidx<$nM; $sidx++) {
 my $ent = lB->new (@{$linesref->[$sidx]});
 push @$pN, $ent;
 $match_cnt++;
 }
 return ($match_cnt, $pN);

}

# end of jW::nYa
1;
