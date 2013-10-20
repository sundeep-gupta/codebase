# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 508 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/rRa.al)"
sub rRa{
 my ($self, $fieldsref, $where, $params, $tag) = @_;
 $fieldsref = $self->{fields} if not $fieldsref;
 my @fs = grep { (not defined $self->{$_}) || $self->{$_} !~ /^sqlfunc:/i } @{$fieldsref};
 my @ps = (@$self{@fs}, @$params);
 my $_dbh = $self->{_dbh};
 my $sth = $_dbh->prepare_cached($self->aVaA($fieldsref, $where, undef, $tag));
 $sth->execute(@ps);
 $sth->finish();
}

# end of zDa::rRa
1;
