# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 3126 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/vUz.al)"
sub vUz{
 my ($self, $usr_pat, $iN, $etime) = @_; 

 my $eS = $self->nDz('msglist') ;
 my $aB = $self->nDz('dmsglist') ;
 my $afile = $self->nDz('archlist');
 my $sf = $self->nDz('pstat');
 my ($mt, $dt, $at, $gDz) = map { (stat($_))[9] } ($eS, $aB, $afile, $sf);
 my $entry ;
 my @pN ;

 my $sti;
 my $dstr;
 my %ostats;
 my $force = $abmain::use_sql;
 $self->aFz();
 $self->aFz(undef, "a") if ($at > $gDz || $force);
 $self->aFz(undef, "d") if ($dt > $gDz || $force);
 
 my $linesref = $bYaA->new($sf, {schema=>"AbPostStat", paths=>$self->dHaA($sf) })->iQa({noerr=>1} );
 for (@$linesref) {
	$ostats{$_->[0]} = $_;
 }
	
 my %stats;
 foreach my $file (($eS, $aB, $afile))  {
 my $u_t = (stat($file))[9];
 next if ($u_t < $gDz && not $force);
 my $jKa = $bYaA->new($file, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($file) })->iQa({noerr=>1});
	next if not $jKa;
 	for(@$jKa) {
 	   $entry = lB->new ( @$_ );
 my $hC = $entry->{hC};
	   next if not $hC;
 	   $stats{$hC}->[1] ++;
 	   $stats{$hC}->[2] += $entry->{size};
 my $nloc;
 if($file eq $eS) {
 	   	$stats{$hC}->[3] ++;
 }elsif($file eq $afile) {
 	   	$stats{$hC}->[4] ++;
		$nloc ="a";
 }elsif($file eq $aB) {
 	   	$stats{$hC}->[5] ++;
		$nloc ="d";
 }
 	   $stats{$hC}->[6] ++ if $entry->{eZz};

 my $cG = $entry->{fI};
	   if($self->{ratings2}->{$cG} ) {
 	my ($aUz, $cnt, $ovis, $fpos, $loc, $rds) = split /\t/, $self->{ratings2}->{$cG} ;
 	   	$stats{$hC}->[7] += $ovis;
 	   	$stats{$hC}->[8] += $aUz*$cnt;
 	   	$stats{$hC}->[9] += $cnt;
 if($loc ne $nloc) {
 		$self->{ratings2}->{$cG} = join("\t", $aUz, $cnt, $ovis, $fpos, $nloc, $rds);
 } 
 }
 	}
 }
 for(keys %stats) {
 $stats{$_}->[0] = $_;
 }
 my @posters = sort { $b->[1] <=> $a->[1]} values %stats;
 my @rows;
 for (@posters) {
 my $n = $_->[0];
	my $i;
	for($i=1; $i<10; $i++) {
 		$_->[$i]= ($ostats{$n}->[$i] || 0) if not $_->[$i];
 }
 	push @rows, $_;
 }
 $bYaA->new($self->nDz('pstat'), {schema=>"AbPostStat", paths=>$self->dHaA($self->nDz('pstat')) })->iRa(\@rows);
 $self->aKz() if ($mt > $gDz || $force);
 $self->aKz(undef, "a") if ($at > $gDz || $force);
 $self->aKz(undef, "d") if ($dt > $gDz || $force);
}

# end of jW::vUz
1;
