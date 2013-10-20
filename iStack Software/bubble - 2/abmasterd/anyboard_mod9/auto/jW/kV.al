# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 3362 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/kV.al)"
sub kV{
 my ($self, $tK, $gV, $wT, $find_img, $sday, $eday, $toponly, $scat) = @_; 

 my $eS = $gV? $self->nDz('archlist') : $self->nDz('msglist') ;

 if($self->{allow_user_view} ) {
 	 my $mf=$self->gXa($abmain::ab_id0);
	 $self->yIz($mf, qw(hG yVz revlist_topic revlist_reply align_col_new iW)); 
 }
 my $sti;
 my $dstr;
 if(not $sday) {
 abmain::mRz($abmain::fPz{$self->{vcook}});
 	my $lastv0 = $abmain::mNz{lastv0};
 $sti = $lastv0;
 $dstr = "since your last visit: ". abmain::dU('LONG', $sti, 'oP');
 }else {
 	$sti = time() - $sday * 24 * 3600;
 $dstr = "since ". abmain::dU('LONG', $sti, 'oP');
 }
 my $eti = time() - $eday * 24 * 3600;
 my ($match_cnt, $pN) = $self->nYa($tK, $gV, $wT, $find_img, $sti, $eti, $toponly, $scat);

 sVa::gYaA "Content-type: text/html\n\n";
print qq@<html><head><title>Search Results for $tK $dstr</title>\n$self->{sAz}\n
<p>
@
;
 pop @$pN if $match_cnt > $self->{max_match_cnt};
 my $morestr;
 $morestr = "There are more matches." if $match_cnt > $self->{max_match_cnt}; 
 my $nM= scalar(@$pN);
 my $match_cond = "";
 $match_cond = "Search pattern:" . "$tK," if $tK;
 $self->{fDz} = 'undef';
 my $cmdbar = $self->bHa(1, $gV, 1);

 print &mTa($self->{other_header}, \@jW::gLa, $self->{_navbarhash});

 print qq(\n<div class="ABMSGAREA">);
 print "\n$cmdbar\n";
 if(0 == $nM) {
 	print qq(<center><h1>No messages found.<br/><small>($match_cond $dstr)</small></h1> </center>);
 }else {
 	print qq(<center><h3>The following $nM messages have been found. $morestr<br/><small>($match_cond $dstr)</small></h3> </center>);
 	$self->lN($pN);
	$self->aFz(undef, $gV? "a":undef);
 	$self->{eN}->jN(iS=>$self, nA=>\*STDOUT, 
 jK=>($self->{aO}?0:-1), hO=>0, gV=>$gV);
 }
 print "</div>";
 print &mTa($self->{other_footer}, \@jW::gLa, $self->{_navbarhash});
 print qq|<!--@{[$abmain::func_cnt]}-->|;
 return;

 my $tO= "\&nbsp;" x 10;
 $tO .= abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=qL", $self->{tC});
 print qq|<p><hr width="$self->{cYz}">${\($self->dRz($gV))} $tO
 </div><!--@{[$abmain::func_cnt]}-->|;
}

# end of jW::kV
1;
