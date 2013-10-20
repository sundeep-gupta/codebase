# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jEa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jEa;

#line 192 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jEa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jEa/oMz.al)"
sub oMz{
 my ($self, $opts) =@_;
 local *TBF;
 my %jIa=();
 my $index = $self->{index};
 my $jTa = $self->{tb};
 my $jKa= jEa::jZa($opts->{aNz} ||"${jTa}_upd", {index=>$index, noerr=>1}, 1);
 for(@$jKa) {
		$jIa{$_->[$index]} = $_;
 }
 my $kIa = jEa::hAz("${jTa}_del");
 return if (scalar(keys %jIa) ==0  && scalar(keys %$kIa) ==0 );

 if(not open TBF, "<$jTa") {
	return;
 }
 my $row;
 my $cnt=0;
 my $filtcnt=0;
 my $filter = $opts->{filter};
 my $idx=0;
 open TBF2, ">$jTa.tmp";
 my $l;
 while( $l = <TBF>){
 $l =~ s/\r*\n$//;
	next if not $l;
 $idx ++;
	$row = [split /\t/, $l];
 if(exists $jIa{$row->[$index]}) {
		$row = $jIa{$row->[$index]};
 }
 if($kIa->{$row->[$index]}) {
	      $filtcnt ++;
	      next;
 }
	if ($filter && &$filter($row, $idx)) {
 $filtcnt ++;
	     next;
 }
 print TBF2 join("\t", @$row), "\n";
	$cnt ++;
 }
 close TBF;
 close TBF2;
 
 open TBF2, ">$jTa";
 open TBF, "<$jTa.tmp";
 binmode TBF2;
 my $buf;
 while(sysread TBF, $buf, 4096*4) { syswrite (TBF2, $buf, length($buf), 0); }
 close TBF;
 close TBF2;
 unlink $jTa."_upd";       
 unlink $jTa."_del";       
 unlink "$jTa.tmp";       
 return $filtcnt;
}

1;
1;
# end of jEa::oMz
