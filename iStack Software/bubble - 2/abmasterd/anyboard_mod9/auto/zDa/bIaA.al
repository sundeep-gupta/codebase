# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 573 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/bIaA.al)"
sub bIaA{
 my ($self, $varr) = @_;
 my $_dbh = $self->{_dbh};
 my $sql = $self->bDaA();
 my $sth = $_dbh->prepare_cached($sql);
 $sth->execute(@$varr);
 $sth->finish();
}

# end of zDa::bIaA
1;
