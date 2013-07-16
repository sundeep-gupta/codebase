# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/lB.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package lB;

#line 188 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/lB.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/lB/nB.al)"
sub nB {
 my ($self, $iS, $entry) = @_;
 return if $entry->{fI} <=0;
 if($iS->{flat_tree}) {
 	push @{$self->{bE}}, $entry;
	return;
 }
	
 my $aI = $iS->{dA}->{$entry->{jE}};
 my $try_grp = $iS->{yBz};

 if($iS->{allow_subcat} && ($entry->{scat} eq '') && $iS->{scat_fix} ne "") { 
		$entry->{scat} = $iS->{scat_fix};
 } 
 if(not $aI) {
 if($entry->{jE} ==0 || not $try_grp){
 $aI = $self;
 }else {
 $aI = $iS->pO($entry->{jE});
 if(not $aI) {
 	$aI = new lB($entry->{aK}, $entry->{aK}, $entry->{jE},
				 ($entry->{jE} == $entry->{aK})? $iS->{top_word}: $iS->{iVz}, "", $entry->{mM});
 }else {
		$aI->{jE} = $entry->{aK} if $aI->{jE} != 0;
		$aI->{aK} = $entry->{aK};
 }
	    $aI->{scat} = $entry->{scat} if not $aI->{scat};
	    $aI->{body} = undef;
 $iS->{dA}->{$entry->{jE}} = $aI;
	    $self->nB($iS, $aI);
 }
 }
 my $top = $iS->{dA}->{$entry->{aK}};
 if($aI) {
 		$aI->{yTz} = $entry->{mM} if  $entry->{mM} >0 && $entry->{mM} > ($aI->{yTz}||0);
 }
 if(defined $top) {
		$top->{tot} ||=0;
 		$top->{tot}++ if($entry->{aK} != $entry->{fI}); 
 		$top->{yTz} = $entry->{mM} if  $entry->{mM} >0 && $entry->{mM} > ($top->{yTz}||0);
		$top->{zCz} = (($top->{zCz}||0) * $top->{tot} + $entry->{mM})/($top->{tot}+1);
 }
 return if not $aI;
 return if ($aI->{fI}||0) == ($entry->{fI}||0);
 return if $aI->{fI} >= $entry->{fI};
 push @{$aI->{bE}}, $entry;
}

# end of lB::nB
1;
