# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 104 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/aOaA.al)"
#if seqname is undef, then use {table_name}_seq

sub aOaA{
 my ($self, $seqname) = @_;
 my $_dbh= $self->{_dbh};
 $seqname="$self->{tb}_seq" if not $seqname;
 my $tag = "getseq_$self->{tb}";
 
 if(not $self->{_res}->{$tag}) {
 	my $stmt = "select $seqname.nextval from dual";
 	$sqls{$stmt} = $tag;
 	my $sth = $_dbh->prepare_cached($stmt);
 	$sth->execute();
 	my @row = $sth->fetchrow_array;
 	$sth->finish();
 	return $row[0];
 }
}

# end of zDa::aOaA
1;
