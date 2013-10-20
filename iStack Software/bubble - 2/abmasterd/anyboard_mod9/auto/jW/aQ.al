# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 3757 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/aQ.al)"
sub aQ{
 my ($self, $jO, $aA,$pI, $eA, $gLz, $backup) = @_; 

 $self->oF();
 $self->mQa();


 if(!$aA) {
 $aA = [];
 if($jO eq 'fI' && $self->{purge_mark}>0) {
 my $del_cnt= $self->{dI}-$self->{purge_mark};
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
 


#   my @var_arr = sort @{$val_arr_ref0};
#   my $var_arr_ref = \@var_arr; 
 
 my %pD;
 foreach (@{$aA}) {
 $pD{$_}=1;
 }

 my $entry ;



 my %hD=();

 my $val;

 my %uB;
 my @pN;
 my @vCz=();

 foreach $entry (@{$self->{pC}}) {

 next if($hD{$entry->{fI}});

 if($jO eq 'mM') {
 $val = abmain::dU('YDAY', $entry->{mM}, 'oP');
 } elsif ($jO eq 'pQ') {
 $val = abmain::pT($entry->{pQ});
 } else {
 $val = $entry->{$jO};
 }

 if($pD{$val}) {
 	    if($jO ne 'fI' && !$uB{$val}) {
 	      $self->iU($jW::max_mno);
		      my $ent = lB->new($gP, 0, $gP, $val, "Archive", time());
		      $uB{$val} = $ent;
 $hD{$gP} = $ent;
 $self->{dA}->{$gP} = $ent;
 	    }
 $hD{$entry->{fI}}=$entry;

 push @vCz, $entry->{jE} if ($entry->{jE} > 0); 
 if($jO ne 'fI') {
 	my $vtop = $uB{$val};
 $entry->{jE} = $vtop->{fI};
 $entry->{aK} = $vtop->{fI};
 }
	    my @marr=();
	    if ($pI) {
	          $self->jP($entry->{fI}, \@marr);
		  my $ent;
		  for $ent(@marr) {
		      $hD{$ent->{fI}}= $ent;
		      $ent->{aK} = $uB{$val}->{aK} if $jO ne 'fI';
		  }
 }
	    if($self->{adopt_orphan}) {
	    	my $ch;
	    	foreach $ch (@{$entry->{bE}}) {
	    	    if (!$hD{$ch->{fI}}){
	    	        $entry->{adopter} = 1 ;
		        $entry->{wW}="";
			$entry->{size}= -1;
			last;
	             }
 	}
	    }
 }
 }
#x2
 foreach $entry (@{$self->{pC}}) {
 push @pN, $entry unless ($hD{$entry->{fI}} && not $entry->{adopter});
 }




 my @tR = ();
 if(!$self->{adopt_orphan}) {
 foreach $entry (values %hD) {
	       my $ch;
	       foreach $ch (@{$entry->{bE}}) {
	           last if  $hD{$ch->{fI}};
	           $self->tQ(\@tR, $ch->{fI});
	       }
	  }
 }






 my $estr;
 my $arc_cnt=0;
 if($eA) {
 my $oldinline= $self->{lJ};
 $self->{lJ}=1;
 my @sort_mref =sort {$a->{mM} <=> $b->{mM}} values %hD;
 $self->lN(\@sort_mref);
 my $ent;
 $self->{_regened_mnos} = {};
 foreach $ent (values %hD) {
	$self->qQa();
 if ($ent->{fI} == $ent->{aK}) {
 	$self->bT($ent->{fI}, 1);
 		$estr .="Archived thread $ent->{fI}: $ent->{wW}\n";
 	  if (not -e $self->fA($ent->{aK}, 1, $ent->qRa())) {
 	     abmain::error('sys', "Fail to validate archive operation (check #$ent->{aK})!");
 	  }
 	  $arc_cnt++;
 }
 } 
 $self->{_regened_mnos} = {};

 my $eS = $self->nDz('archlist');
 my @as;
 foreach $entry (@sort_mref ) {
		$entry->{status} = 'a';
 		push @as, [@{$entry}{@lB::mfs}];
 }
 $bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) })->kEa(\@as);  
 chmod 0600, $eS;
 $self->aT(0, $eS, 0); ##load all, and not sort
 $self->eG(0, 0, 1);
 $self->{lJ}=$oldinline;

 }
 
 my $eS =  $self->nDz('msglist') ;

 my @ms;
 while ($entry = shift @pN) {
 		push @ms, [@{$entry}{@lB::mfs}];
 }
 $bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) })->iRa(\@ms);
 $self->xGz();
 $self->pG();

 $self->aT('A', 0,0,0,'`');



 $self->{_regened_mnos} = {};
 foreach (@vCz) {

 next if ($hD{$_} || $_==0);
	$self->qQa();
 $self->bT($_);
 $estr .="Regen message: $self->{dA}->{$_}->{wW}\n";
 } 
 $self->{_regened_mnos} = {};

 foreach (@tR) {
 next if ($hD{$_->{fI}});
 $self->bT($_->{fI});
 $estr .="Regen message-2: $_->{wW}\n";
 }
 $self->{_regened_mnos} = {};


 my $delcnt=0;

 $self->{just_deleted} = []; 
 my @des;
 foreach (values %hD) {
	$self->qQa();
 if($eA && not -e $self->fA($_->{aK}, 1, $_->qRa())) {
	       $estr .= "Error: #$_->{fI} not removed, cannot find corresponding archived file\n";
 next;
 }
 push @{$self->{just_deleted}}, $_->{fI};
	  $self->nMa($_->{fI}, $_->nJa()) if $backup; 
 if( $self->zD($_->{fI})) {
	       $estr .= "Removed message: $_->{fI} -- $_->{wW}\n";
	  }else {
	       $estr .= "Error removing $_->{fI} $_->{wW}:  $!\n";
	  }
 if($gLz && $_->{eZz} && not $eA) {
 (unlink $self->bOa($_->{eZz})) &&
 ($estr .= "Removed uploaded file $_->{eZz}");
 }
 
 if(not $eA) {
	     push @des, [@{$_}{@lB::mfs}];
 delete $self->{ratings2}->{$_->{fI}};
 }
	  next if($self->{aO});
	  unlink  $self->fA($_->{fI}, 0, $_->qRa()) or 1;
 $delcnt ++;
 }
 if (not $eA ) {
 	$eS = $self->nDz('dmsglist');
 	$bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) })->kEa(\@des);
 }
 $estr .= "\n"."Deleted $delcnt messages!\n";
 $estr .= "\nArchived $arc_cnt threads!\n" if $arc_cnt;
 return $estr;
}

# end of jW::aQ
1;
