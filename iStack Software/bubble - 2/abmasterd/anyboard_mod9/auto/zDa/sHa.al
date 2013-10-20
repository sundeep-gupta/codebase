# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 539 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/sHa.al)"
sub sHa{
 my ($self, $where, $params, $tag) = @_;
 	my $_dbh = $self->{_dbh};
 	my $sth = $_dbh->prepare_cached($self->aQaA($where, $tag));
 	$sth->execute(@$params);
 	$sth->finish();
}

# end of zDa::sHa
1;
