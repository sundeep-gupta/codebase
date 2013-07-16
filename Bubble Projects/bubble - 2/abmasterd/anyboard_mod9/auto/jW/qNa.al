# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 3582 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/qNa.al)"
sub qNa{
 my ($self, $aA,$pI, $eA, $gLz, $backup) = @_; 

 $self->oF();
 my $del_all = 0;
 my @tnos2d;
 my %mnos2d_hash;


 if(!$aA) {
 if($self->{purge_mark}>0) {
		return if not $self->qZa(undef, $self->{purge_mark});
 }else {
 return;
 }
	 my %tnoshsh=();
 	 foreach my $entry (@{$self->{pC}}) {
		$mnos2d_hash{$entry->{fI}}=1;
		$tnoshsh{$entry->{aK}}=1;
	 }
	 @tnos2d = keys %tnoshsh;
 }else {
	for(@$aA) {
		my ($cG, $aK) = split /\s+/, $_;
		$mnos2d_hash{$cG}=1;
		push @tnos2d, $aK;
 }	
 	$self->qZa(\@tnos2d);
 }
 
 my $entry ;

 my %hD=();

 my @pN;
 my @vCz=();

 my @updates=();
 my %updhsh=();

 foreach $entry (@{$self->{pC}}) {
 next if not $mnos2d_hash{$entry->{fI}};
 next if($hD{$entry->{fI}});
 $hD{$entry->{fI}}=$entry;
 push @vCz, $entry->{jE} if ($entry->{jE} > 0); 
 my @marr=();
 if ($pI) {
	          $self->jP($entry->{fI}, \@marr);
		  my $ent;
		  for $ent(@marr) {
		      $hD{$ent->{fI}}= $ent;
		  }
 }
 if(1 || $self->{adopt_orphan}) {
	    	my $ch;
	    	foreach $ch (@{$entry->{bE}}) {
	    	    if (!$hD{$ch->{fI}}){
	    	        $entry->{adopter} = 1 ;
		        $entry->{wW}="";
			$entry->{size}= -1;
 	        push @updates, [@{$entry}{@lB::mfs}];
			$updhsh{$entry->{fI}} =1;
			last;
	             }
 	}
 }
 
 }
#x2
 my $estr;
 my $arc_cnt=0;
 if($eA) {
 my @sort_mref =sort {$a->{mM} <=> $b->{mM}} values %hD;
 my $oldinline= $self->{lJ};
 my $oldflat = $self->{flat_tree};
 $self->{lJ}=1;
 $self->{flat_tree}=0;
 $self->lN(\@sort_mref);
 
 my $ent;
 $self->{_regened_mnos} = {};
 foreach $ent (values %hD) {
 $self->qQa();
 if ($ent->{fI} == $ent->{aK}) {
 	$self->bT($ent->{fI}, 1);
 	$estr .="Archived thread $ent->{fI}: $ent->{wW}\n";
 my $f = $self->fA($ent->{aK}, 1, $ent->qRa());
 if (not -e $f) {
 abmain::error('sys', "Fail to validate archive operation (check #$ent->{aK}, $f)!");
 }
 $arc_cnt++;
 }
 } 
 $self->{_regened_mnos} = {};

 my $eS = $self->nDz('archlist');
 my @as;
 foreach $entry (@sort_mref ) {
		$entry->{status} ='a';
 		push @as, [@{$entry}{@lB::mfs}];
 }
 $bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) })->kEa(\@as);  
 chmod 0600, $eS;
 $self->{lJ}= $oldinline;
 $self->{flat_tree}= $oldflat;

 }
 
 my $eS =  $self->nDz('msglist') ;
 my $db = $bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) });
 $db->jXa(\@updates);
 my @mnos2d;
 for(keys %hD) { 
 push @mnos2d, $_ if not $updhsh{$_};
 }
 $db->jLa(\@mnos2d);

 $self->qZa(\@tnos2d);



 $self->{_regened_mnos} = {};
 foreach my $cG (@vCz) {

 next if ($hD{$cG} || $cG==0);
 $self->bT($cG);
 $estr .="Regen message: $self->{dA}->{$cG}->{wW}\n";
 } 
 $self->{_regened_mnos} = {};

 my $delcnt=0;
 $self->{just_deleted} = []; 
 my @des;
 foreach my $ent (values %hD) {
	$self->qQa();
 if($eA && not -e $self->fA($ent->{aK}, 1, $ent->qRa())) {
	       $estr .= "Error: #$ent->{fI} not removed, cannot find corresponding archived file\n";
 next;
 }
 push @{$self->{just_deleted}}, $ent->{fI};
	  $self->nMa($ent->{fI}, $ent->nJa()) if $backup; 
 if( $self->zD($ent->{fI})) {
	       $estr .= "Removed message: $ent->{fI} -- $ent->{wW}\n";
	  }else {
	       $estr .= "Error removing $ent->{fI} $ent->{wW}:  $!\n";
	  }
 if($gLz && $ent->{eZz} && not $eA) {
 (unlink $self->bOa($ent->{eZz})) &&
 ($estr .= "Removed uploaded file $ent->{eZz}");
 }
 
 if(not $eA) {
	     push @des, [@{$ent}{@lB::mfs}];
 delete $self->{ratings2}->{$ent->{fI}};
 }
	  next if($self->{aO});
	  unlink  $self->fA($ent->{fI}, 0, $ent->qRa()) or 1;
 $delcnt ++;
 }
 if (not $eA ) {
 	$eS = $self->nDz('dmsglist');
 	$bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) })->kEa(\@des);
 }
 if($eA) {
 	my $oldinline= $self->{lJ};
 	$self->{lJ}=1;
 	my $eS = $self->nDz('archlist');
 	$self->aT(0, $eS, 0); ##load all, and not sort
 	$self->eG(0, 0, 1);
 	$self->{lJ}=$oldinline;
 }
 $estr .= "\n"."Deleted $delcnt messages!\n";
 $estr .= "\n"."Archived $arc_cnt threads!\n" if $arc_cnt;
 return $estr;
}

# end of jW::qNa
1;
