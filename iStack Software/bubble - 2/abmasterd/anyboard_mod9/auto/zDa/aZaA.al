# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 519 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/aZaA.al)"
sub aZaA{
 my ($self, $jRa,  $where, $params, $tag) = @_;
 my $fieldsref = $self->{fields};
 my @ps = (@$jRa, @$params);
 my $_dbh = $self->{_dbh};
 my $sth = $_dbh->prepare_cached($self->aVaA($fieldsref, $where, undef, $tag));
 $sth->execute(@ps);
 $sth->finish();
}

# end of zDa::aZaA
1;
