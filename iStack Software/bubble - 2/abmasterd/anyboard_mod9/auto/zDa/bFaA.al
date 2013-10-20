# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 175 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/bFaA.al)"
sub bFaA {
 my ($self, $tb) = @_;
 my $_dbh = $self->{_dbh};
 $tb = $self->{tb} if not $tb;
 return $tab_desc{$tb} if $tab_desc{$tb};
 my $stmt = "select * from $tb where 0=1";
 my $sth = $_dbh->prepare_cached($stmt);
 $sth->execute();
 $tab_desc{$tb} = [map{lc($_)}@{$sth->{NAME}}];
 $precision_desc{$tb} = [@{$sth->{PRECISION}}];
 $nullable_desc{$tb} = [@{$sth->{NULLABLE}}];
 $sth->finish();
 return $tab_desc{$tb};
	
}

# end of zDa::bFaA
1;
