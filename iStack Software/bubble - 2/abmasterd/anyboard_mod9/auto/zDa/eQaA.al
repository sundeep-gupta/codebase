# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 399 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/eQaA.al)"
sub eQaA {
 my ($self, $hashref, $fieldsref) = @_;
 $fieldsref = $self->{fields} if not $fieldsref;
 my $stmt = "select ". join (",\n", map{ (defined $self->{$_}) && $self->{$_} =~ /^sqlfunc:(.*)/i ? $1: $_} @{$fieldsref});
 $stmt .= "\nfrom $self->{tb} \n";
 my $where;
 my @bindvarrs;
 for my $k (keys %$hashref) {
	push @bindvarrs, $k;
 }
 $where = join (" and ", map { "$_ = ?" } @bindvarrs );
 $stmt .= " where $where" if $where;
 print STDERR $stmt, "\n";
 my $_dbh = $self->{_dbh};
 my $sth = $_dbh->prepare_cached($stmt);
 $sth->execute(@{$hashref}{@bindvarrs});
 my $rowhashref =  $sth->fetchrow_hashref;
 $sth->finish();
 $self->aTaA($rowhashref) if ref($rowhashref) eq 'HASH';
 return ref($rowhashref) eq 'HASH'? $rowhashref: undef; 
}

# end of zDa::eQaA
1;
