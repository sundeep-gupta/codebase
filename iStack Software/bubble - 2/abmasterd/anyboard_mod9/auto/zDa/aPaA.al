# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 382 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/aPaA.al)"
sub aPaA{
 my ($self, $where, $params, $fieldsref, $tag) = @_;
 $fieldsref = $self->{fields} if not $fieldsref;
 my $_dbh = $self->{_dbh};
 my $sql = $self->aNaA($fieldsref, $where, $tag);
 my $sth = $_dbh->prepare_cached($sql);
 if($params) {
 		$sth->execute(@$params);
 }else {
 		$sth->execute();
 }
 my $rowhashref =  $sth->fetchrow_hashref;
 $sth->finish();
 $self->aTaA($rowhashref) if ref($rowhashref) eq 'HASH';
 return ref($rowhashref) eq 'HASH'? $rowhashref: undef; 
}

# end of zDa::aPaA
1;
