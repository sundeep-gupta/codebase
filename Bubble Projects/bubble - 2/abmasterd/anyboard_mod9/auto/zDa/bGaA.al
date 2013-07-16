# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 152 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/bGaA.al)"
sub bGaA{
 my ($self, $seqname, $rec) = @_;
 return if $rec && $rec >1;
 my $_dbh= $self->{_dbh};
 $seqname="$self->{tb}_seq" if not $seqname;
 my @row;
 if($_dbh->do("UPDATE sequence_counters set seqno= LAST_INSERT_ID(seqno+1) where name = ?", undef, $seqname) != 0) {
 	my $sth = $_dbh->prepare_cached("SELECT LAST_INSERT_ID()");
 	$sth->execute();
 	@row = $sth->fetchrow_array;
 	$sth->finish();
 }
 if((not @row) || $row[0] <=0) {
 	$_dbh->do("INSERT INTO sequence_counters (seqno, name) values(1, ?)", undef, $seqname);
	return $self->bGaA($seqname, $rec++);
 }
 return $row[0];
}

# end of zDa::bGaA
1;
