# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zGa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zGa;

#line 73 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zGa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zGa/iQa.al)"
sub iQa{
 my ($self, $opts) =@_;
 my $index = $self->{index};
 my $dbo = $self->{_dbobj};
 my $rows=[];
 my $filter = $opts->{filter};
 my $where = $opts->{where} || "";
 $where = "and $where"  if $where;
 my $row;
 my $cnt=0;
 my $filtcnt=0;
 my $max = $opts->{maxret}||0;
 my $sidx = $opts->{sidx};
 my $eidx = $opts->{eidx};
 my $idx=0;
 my $wantstr = $opts->{getstr};
 local $_;
 my $idxcol = $dbo->aDaA($index);
 my $no_srealm = $opts->{nosr};
 my $allrows;
 if($no_srealm) {
 	$allrows = $dbo->aYaA("where realm =? $where order by $idxcol", [$self->{realm}]);
 }else {
 	$allrows = $dbo->aYaA("where realm =? and srealm =? $where order by $idxcol", [$self->{realm}, $self->{srealm}]);
 }
 for my $row (@$allrows){
 $idx ++;
	next if ($sidx && $idx <$sidx+1);
	last if ($eidx && $idx >$eidx);
	if ($filter && not &$filter($row, $idx)) {
 $filtcnt ++;
	     next;
 }
	pop @$row;
	pop @$row;
 if($wantstr) {
		push @$rows, join("\t", @$row);
 }else {
		push @$rows, $row;
 }
	$cnt ++;
 last if $max >0 && $cnt > $max;
 }
 return wantarray? ($rows, $cnt, $filtcnt) : $rows;
}

# end of zGa::iQa
1;
