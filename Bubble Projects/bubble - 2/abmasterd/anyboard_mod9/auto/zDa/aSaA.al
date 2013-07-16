# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 438 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/aSaA.al)"
sub aSaA{
 my ($self, $where, $params, $fN, $fieldsref, $tag) = @_;
 my $objs=[];
 my $_dbh = $self->{_dbh};
 $fieldsref = $self->{fields} if (not defined($fieldsref)) || scalar(@$fieldsref)==0;
 my $sql = $self->aNaA($fieldsref, $where, $tag);
 my $sth = $_dbh->prepare_cached($sql);
 $fN = 1024*10 if not defined($fN);
 $params? $sth->execute(@$params) : $sth->execute();
 my $hashref;
 my $cnt;
 my $t = ref($self);
 while(($hashref =  $sth->fetchrow_hashref) && ++$cnt <= $fN) {
 	   my $obj = $t->new($self->{tb});
 	   $obj->aTaA($hashref) if $hashref;
	   push @$objs, $obj;
 }
 $sth->finish();
 return $objs; 
}

# end of zDa::aSaA
1;
