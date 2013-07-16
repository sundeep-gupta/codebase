# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 3474 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/iNa.al)"
sub iNa{
 my ($self, $jO, $aA, $gLz, $dp) = @_; 
 $self->oF();
 $self->aT('A', $self->nDz('archlist'), 0, 0, '`', $dp);
 if(!$aA) {
 $aA = [];
 if($jO eq 'fI' && $self->{archive_purge_mark}>0) {
 my $del_cnt= $self->{dI}-$self->{archive_purge_mark};
 return 1 if $del_cnt <=0;
 for(@{$self->{pC}}) {
 last if $del_cnt <=0;
 push @{$aA}, $_->{fI};
 $del_cnt --;
 }
 }else {
 return;
 }
 }
 
 my %pD;
 foreach my $k (@{$aA}) {
	if($jO eq 'fI') {
		my $aK;
		($k, $aK) = split /\s+/, $k;
	}
 $pD{$k}=1;
 }

 my $entry ;
 my %hD=();
 my $val;
 my @pN;

 foreach my $entry (@{$self->{pC}}) {
 next if($hD{$entry->{fI}});
 if($jO eq 'mM') {
 $val = abmain::dU('YDAY', $entry->{mM}, 'oP');
 } elsif ($jO eq 'pQ') {
 $val = abmain::pT($entry->{pQ});
 } else {
 $val = $entry->{$jO};
 }
 if($pD{$val}) {
	    my @marr;
 $hD{$entry->{fI}}=$entry;
	    $self->jP($entry->{fI}, \@marr);
	    my $ent;
	    for $ent(@marr) {
	      $hD{$ent->{fI}}= $ent;
	    }
 }
 }
 foreach $entry (@{$self->{pC}}) {
 push @pN, $entry unless ($hD{$entry->{fI}});
 }

 my $estr; 
 my @sort_mref =sort { $a->{mM} <=> $b->{mM} } values %hD;
 $self->lN(\@sort_mref);
 foreach (values %hD) {
 $self->qQa();
 if ($_->{fI} == $_->{aK}) {
		$estr .="Deleted archive thread $_->{fI}: $_->{wW}\n" if (unlink $self->fA($_->{aK}, 1,  $_->qRa()));
 }
 if($gLz && $_->{eZz}) {
		(unlink $self->bOa($_->{eZz})) && ($estr .= "Removed uploaded file $_->{eZz}");
 }
 
 } 

 my $eS =  $self->nDz('archlist') ;
 my @rows;

 while ($entry = shift @pN) {
	  push @rows, [@{$entry}{@lB::mfs}];
		
 }
 $bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) })->iRa(\@rows);
 $self->pG();

 $self->aT('A', $eS, 0, 0, '`');

 my $delcnt=0;
 $self->aFz(undef, "a");

 my @ds; 
 foreach (values %hD) {
 push @ds, [@{$_}{@lB::mfs}];
 delete $self->{ratings2}->{$_->{fI}};
 $delcnt ++;
 }

 $eS = $self->nDz('dmsglist');
 $bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) })->kEa(\@ds);
 

 $estr .= "\nDeleted $delcnt messages!\n";
 $self->aKz(undef, "a");
 $self->eG(0,0,1);
 return $estr;
}

# end of jW::iNa
1;
