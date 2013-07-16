# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2973 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/qZa.al)"
sub qZa{
 my ($self, $tnosarr, $purgemark) = @_;
 my $eS =  $self->nDz('msglist');
 my $db = $bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) });
 my $nM = $db->pXa();
 $self->{dI}= $nM;

 my $eidx = $nM - $purgemark if $purgemark;
 return if $eidx < 0; 

 my $tnopos = abmain::oTa(\@lB::mfs, 'aK');
 my $privfilter;
 my %tnohash=();
 if(not $tnosarr) {
 $privfilter =  undef;
 }else {
 	for(@$tnosarr) {
		$tnohash{$_} = 1;

	}
 $privfilter = sub {
	    return $tnohash{ $_[0]->[$tnopos] };
 };
 }
 my $jKa = $db->iQa({filter=>$privfilter, eidx=>$eidx} ); 
 my ($fI, $entry);
 my @hS;
 for(@$jKa){
 $entry = lB->new (@$_);
 next if $entry->{fI} <=0;
 $jW::max_mno = $entry->{fI} if $entry->{fI} > $jW::max_mno;
 push @hS, $entry;
 }
 $self->lN(\@hS); 
 return scalar(@hS); 
}

# end of jW::qZa
1;
