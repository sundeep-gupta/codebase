# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 474 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/aCaA.al)"
sub aCaA{
 my ($self, $where, $params) = @_;
 my $_dbh = $self->{_dbh};
 my $sql = "select count(*) from $self->{tb} $where";
 my $sth = $_dbh->prepare_cached($sql);
 $params? $sth->execute(@$params) : $sth->execute();
 my @rarr = $sth->fetchrow_array();
 my $cnt = $rarr[0];
 $sth->finish();
 return $cnt; 
}

# end of zDa::aCaA
1;
