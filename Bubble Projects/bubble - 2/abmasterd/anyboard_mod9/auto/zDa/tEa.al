# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 563 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/tEa.al)"
sub tEa{
 my ($self, $tag) = @_;
 my @fs = grep { (not defined $self->{$_}) ||  $self->{$_} !~ /^sqlfunc:/i } @{$self->{fields}};
 my $_dbh = $self->{_dbh};
 my $sql = $self->bHaA($tag);
 my $sth = $_dbh->prepare_cached($sql);
 $sth->execute(@$self{@fs});
 $sth->finish();
}

# end of zDa::tEa
1;
