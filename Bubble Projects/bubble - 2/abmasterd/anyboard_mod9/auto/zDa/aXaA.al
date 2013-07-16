# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 496 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/aXaA.al)"
sub aXaA{
 my ($self, $where, $params, $fieldsref) = @_;
 my $_dbh = $self->{_dbh};
 $fieldsref = $self->{fields} if not $fieldsref;
 my $sql = "select ". join(", ", @$fieldsref). " from $self->{tb} $where";
 my $sth = $_dbh->prepare_cached($sql);
 $params? $sth->execute(@$params) : $sth->execute();
 my $all_ref = $sth->fetchall_arrayref();
 $sth->finish();
 return $all_ref; 
}

# end of zDa::aXaA
1;
