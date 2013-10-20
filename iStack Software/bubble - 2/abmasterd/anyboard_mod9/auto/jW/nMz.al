# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 3423 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/nMz.al)"
sub nMz {
 my ($self, $gV, $rmne) = @_; 
 return if $abmain::use_sql;
 my $eS = $gV? $self->nDz('archlist') : $self->nDz('msglist');
 my $estr;
 $self->oF();
 my $linesref= $bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) } )->iQa({noerr=>1} );
 my %ent_hash;
 my $entry;
 my ($tot, $dupcnt, $badcnt, $rmcnt, $keepcnt, $loopcnt);
 for(@$linesref) {
 next if not $_->[0];
 $tot ++;
 $entry = lB->new (@$_);
 if(exists $ent_hash{$entry->{fI}}){
 	$estr .= "Dupplicate index found for $entry->{fI}\n"; 
 $dupcnt++;
 }
 if ($entry->{size}>=0 && not -e  $self->fA($gV? $entry->{aK}: $entry->{fI}, $gV, $entry->qRa()) && not $self->{aO}) {
 $estr .= "File for index $entry->{fI} does not exist" ;
 $estr .= ", however, data for index $entry->{fI} exist" if -e $self->gN($entry->{aK}) ;
 $estr .="\n";
 $badcnt++;
 if ($rmne) {
 $rmcnt++;
 next;
 }
 }
 unless(($entry->{fI} > $entry->{jE}) || ($entry->{jE}==0 && $entry->{fI} == $entry->{aK})) {
		$loopcnt ++;
	         next;
 }
 $ent_hash{$entry->{fI}} = $entry;
 $keepcnt++;
 }
 $estr .= "\nTotal=$tot\nDup=$dupcnt\nBad=$badcnt\nRemoved=$rmcnt\nRemoved cycle=$loopcnt\nKeep=$keepcnt\n";

 if($rmne) {
 	my @ent_arr=  sort {$a->{mM} <=> $b->{mM}} values %ent_hash;
 my @rows;
 	for $entry (@ent_arr) {
 		push @rows, [@{$entry}{@lB::mfs}];
 	}
 	$bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) })->iRa(\@rows);
 }
 $self->pG();
 $self->aT(0,$eS);
 $self->aFz(undef, $gV? "a" : undef);
 $self->eG(0,0,$gV);
 return $estr;
}

# end of jW::nMz
1;
