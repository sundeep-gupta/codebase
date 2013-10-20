# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 459 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/aYaA.al)"
sub aYaA{
 my ($self, $where, $params, $tag) = @_;
 my $_dbh = $self->{_dbh};
 my $sql = $self->aFaA($where, $tag);
 my $sth = $_dbh->prepare_cached($sql);
 if($params) {
 		$sth->execute(@$params);
 }else {
 		$sth->execute();
 }
 my $allref =  $sth->fetchall_arrayref;
 $sth->finish();
 return ref ($allref) eq 'ARRAY'? $allref: undef; 
}

# end of zDa::aYaA
1;
