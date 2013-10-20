# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 422 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/bMaA.al)"
sub bMaA{
 my ($self, $where, $params, $tag) = @_;
 my $_dbh = $self->{_dbh};
 my $sql = $self->aFaA($where, $tag);
 my $sth = $_dbh->prepare_cached($sql);
 if($params) {
 		$sth->execute(@$params);
 }else {
 		$sth->execute();
 }
 my $jRa =  $sth->fetchrow_arrayref;
 $sth->finish();
 $self->aEaA(undef, $jRa) if ref($jRa) eq 'ARRAY';
 return ref ($jRa) eq 'ARRAY'? $jRa: undef; 
}

# end of zDa::bMaA
1;
