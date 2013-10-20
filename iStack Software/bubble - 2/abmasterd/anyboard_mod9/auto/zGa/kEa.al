# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zGa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zGa;

#line 35 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zGa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zGa/kEa.al)"
sub kEa{
 my ($self, $rowrefs, $opts, $clear) =@_;
 my $res;
 my $dbo = $self->{_dbobj};
 if($clear) {
	$dbo->sHa("where realm=? and srealm=?", [$self->{realm}, $self->{srealm}]);
 }
 my $col_cnt = scalar(@{$dbo->bFaA()});
 for my $jRa (@$rowrefs) {
	next if not ref($jRa) eq 'ARRAY';
	if(scalar(@$jRa) < $col_cnt -2)  {
	     my $dc = $col_cnt -2 - scalar(@$jRa);
	     push @$jRa, map { undef} (1..$dc); 
	}
	push @$jRa, $self->{realm};
	push @$jRa, $self->{srealm};
	$dbo->bIaA($jRa);
 }
 1;
}

# end of zGa::kEa
1;
