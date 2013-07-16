# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zGa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zGa;

#line 28 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zGa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zGa/pXa.al)"
sub pXa{
	my ($self) = @_;
	my $dbo = $self->{_dbobj};
 my $cnt = $dbo->aCaA("where realm=? and srealm =?", [$self->{realm}, $self->{srealm}]);
	return $cnt;
}

# end of zGa::pXa
1;
