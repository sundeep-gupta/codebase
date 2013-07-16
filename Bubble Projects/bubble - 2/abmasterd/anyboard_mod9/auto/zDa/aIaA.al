# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 529 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/aIaA.al)"
sub aIaA{
 my ($self, $kvhash, $where, $params, $tag) = @_;
 my @fs = grep { (not $kvhash->{$_}) ||  $kvhash->{$_} !~ /^sqlfunc:/i } @{$self->{fields}};
 my @ps = (@$kvhash{@fs}, @$params);
 	my $_dbh = $self->{_dbh};
 	my $sth = $_dbh->prepare_cached($self->aVaA(\@fs, $where, $kvhash, $tag));
 	$sth->execute(@ps);
 	$sth->finish();
}

# end of zDa::aIaA
1;
