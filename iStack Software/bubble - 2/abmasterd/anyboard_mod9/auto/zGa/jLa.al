# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zGa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zGa;

#line 135 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zGa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zGa/jLa.al)"
sub jLa{
 my ($self, $ids, $opts, $clear) =@_;

 my $dbo = $self->{_dbobj};
 my $index = $self->{index};
 if($clear) {
	$dbo->sHa("where realm=? and srealm=?", [$self->{realm}, $self->{srealm}]);
	return;
 }
 my $idxcol = $dbo->aDaA($index);
 for(@$ids) {
	$dbo->sHa("where realm=? and srealm=? and $idxcol =?", [$self->{realm}, $self->{srealm}, $_]);
 }
 return scalar(@$ids);
 
}

1;
1;
# end of zGa::jLa
