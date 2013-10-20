# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 133 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/aRaA.al)"
sub aRaA{
 my ($self, $sql, @binds) = @_;
 my $_dbh= $self->{_dbh};
 $_dbh->do($sql, undef, @binds);
}

# end of zDa::aRaA
1;
