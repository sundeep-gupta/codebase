# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 486 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/aJaA.al)"
sub aJaA{
 my ($self, $sql, $params) = @_;
 my $_dbh = $self->{_dbh};
 my $sth = $_dbh->prepare_cached($sql);
 $params? $sth->execute(@$params) : $sth->execute();
 my $all_ref = $sth->fetchall_arrayref();
 $sth->finish();
 return $all_ref; 
}

# end of zDa::aJaA
1;
