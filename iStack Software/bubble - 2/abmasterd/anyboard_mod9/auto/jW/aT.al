# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2803 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/aT.al)"
sub aT {
#sBz =1 private message only
#sBz =2 no private messages

 my ($self, $pgno, $eS, $zI, $yM, $kQz, $sBz, $sti, $eti) = @_;
 $sBz ||= 0;
 $kQz ||= "";

 $self->xHz();

 $kQz = lc($kQz);
 $eS =  $self->nDz('msglist') unless($eS);

 my $db = $bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) });
 my $nM = $db->pXa();
 $self->{dI}= $nM;

 my $pcnt = $self->{iW}||16;
 my $bcnt;

 $jW::debug_str = "<p>nM = $nM ; ";

 my $gV = ($eS eq $self->nDz('archlist'));



 my $start = 0;
 my $mcnt = $nM; 
 $pgno ||=0;
 $jW::hDz = $pgno || 0;

 $self->{nLz} = int $nM/$pcnt;
 $self->{nLz}++ if ($nM%$pcnt); 

 if(uc($pgno) ne 'A'){
 return if($pgno > ($nM/$pcnt +1)); 
 $bcnt = $pcnt * (1+ $pgno);
 $start = $nM - $bcnt;
 $mcnt = $pcnt;
 if ($start < 0 ) {
 $start = 0;
 $mcnt = $nM % $pcnt;
 }
 }
 my $eidx = ($self->{hEz} || $pgno eq 'A')? $nM: $start+$mcnt;
 my $ppos = abmain::oTa(\@lB::mfs, 'hC');
 my $topos = abmain::oTa(\@lB::mfs, 'to');
 my $mynopos = abmain::oTa(\@lB::mfs, 'fI');
 my $tnopos = abmain::oTa(\@lB::mfs, 'aK');
 my $tmpos = abmain::oTa(\@lB::mfs, 'mM');
 my %tops;
 my $cur_cnt=0;
 my $privfilter = sub {
	    return if $sti && $_[0]->[$tmpos] < $sti;
	    return if $eti && $_[0]->[$tmpos] > $eti;
 	    return if $sBz == 1 && not $_[0]->[$topos];
 return if $sBz == 2 && $_[0]->[$topos];
 return if $cur_cnt > $mcnt+50 && not $tops{$_[0]->[$tnopos]};
 $tops{$_[0]->[$mynopos]} = 1 if $_[0]->[$tnopos] == $_[0]->[$mynopos];
	    return 1 if $kQz eq '`';
 if(not $kQz) {
 	$cur_cnt++;
		return 1 if not $_[0]->[$topos];
 }else {
 	$cur_cnt++;
 	return 1 if (lc($_[0]->[$ppos]) eq $kQz && $_[0]->[$topos]) || jW::sFa($_[0]->[$topos], $kQz) ; 
 }
	    return;
 };

 #$privfilter = undef if $kQz eq '`';

 my $jKa;
 if($kQz && $kQz ne '`'){
	my $wh="to_user is NOT NULL";
 	$jKa = $db->iQa({where=>$wh, sidx=>$start, eidx=>$eidx, filter=>$privfilter} ); 
 }else {
 	$jKa = $db->iQa({sidx=>$start, eidx=>$eidx, filter=>$privfilter} ); 
 }
 my ($fI, $entry);
 $cur_cnt=0;
 %tops =();
 my @hS;
 for(@$jKa){
 $entry = lB->new (@$_);
 next if $entry->{fI} <=0;
 next if $cur_cnt > $mcnt && not $tops{$entry->{aK}};
 $jW::max_mno = $entry->{fI} if $entry->{fI} > $jW::max_mno;
 if($yM) {
 next if not &$yM($entry);
 }
#use two flags aGz, aIz to tell whether to load
#reviwed/unreviewed posts
 if($self->{aWz} && not $gV) {
 if ($self->{aLz}->{$entry->{fI}}) {
	   		next if not $self->{aGz};
	   } else {
 	next if not $self->{aIz};
 }
 }
 $tops{$entry->{fI}} = $entry if $entry->{aK} == $entry->{fI};
 push @hS, $entry;
 $cur_cnt ++;
 }

 if($zI) {
 @hS = sort { $a->{mM} <=> $b->{mM} } @hS;
 }
 $nM = @hS;
 $jW::debug_str .= " hS len= $nM;";

 $self->{fV} = $start+1;
 lN($self, \@hS, $mcnt); 
 $jW::debug_str .= " start= $start;";
 1;
}

# end of jW::aT
1;
