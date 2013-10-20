# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jEa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jEa;

#line 85 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jEa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jEa/jZa.al)"
sub jZa{
 my ($jTa, $opts, $no_upd) =@_;
 local *TBF;
 my %jIa=();
 my $index = $opts->{index} ||0;
 my $dhash=undef;
 if(not $no_upd) {
	my $jKa= jEa::jZa($opts->{aNz} || "${jTa}_upd", {index=>$index, noerr=>1}, 1);
	$dhash = jEa::hAz(${jTa}."_del");
 for(@$jKa) {
		$jIa{$_->[$index]} = $_;
 }
 }
 
 if(not open TBF, "<$jTa") {
	unless($opts && $opts->{noerr} ) {
			print caller, "\n";
			sVa::error("sys", $opts->{kG}. "($!: $jTa)");
 }
	return;
 }
 my $rows=[];
 my $filter = $opts->{filter};
 my $row;
 my $cnt=0;
 my $filtcnt=0;
 my $max = $opts->{maxret}||0;
 my $sidx = $opts->{sidx};
 my $eidx = $opts->{eidx};
 my $idx=0;
 my $wantstr = $opts->{getstr};
 local $_;
 while(<TBF>){
 $_ =~ s/\r*\n$//;
	next if not $_;
	$row = [split /\t/, $_];
 next if($dhash && $dhash->{$row->[$index]});
 $idx ++;
	next if ($sidx && $idx <$sidx+1);
	last if ($eidx && $idx >$eidx);
 if((not $no_upd) && exists $jIa{$row->[$index]}) {
		$row = $jIa{$row->[$index]};
 }

	if ($filter && not &$filter($row, $idx)) {
 $filtcnt ++;
	     next;
 }
 if($wantstr) {
		push @$rows, $_;
 }else {
		push @$rows, $row;
 }
	$cnt ++;
 last if $max >0 && $cnt > $max;
 }
 close TBF;
 return wantarray? ($rows, $cnt, $filtcnt) : $rows;
}

# end of jEa::jZa
1;
