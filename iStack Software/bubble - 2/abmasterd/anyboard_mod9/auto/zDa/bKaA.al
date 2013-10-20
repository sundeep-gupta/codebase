# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 123 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/bKaA.al)"
sub bKaA{
 my ($self, $sql, @binds) = @_;
 my $_dbh= $self->{_dbh};
 my $sth = $_dbh->prepare_cached($sql);
 $sth->execute(@binds);
 my @row = $sth->fetchrow_array;
 $sth->finish();
 return $row[0];
}

# end of zDa::bKaA
1;
