# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zGa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zGa;

#line 56 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zGa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zGa/kCa.al)"
sub kCa {
 my ($self, $id) = @_;
 my $index = $self->{index};
 my $dbo = $self->{_dbobj};
 my $row;
 my $cnt=0;
 my $idxcol = $dbo->aDaA($index);
 my $allrows = $dbo->aYaA("where realm =? and srealm=? and $idxcol = ?", [$self->{realm}, $self->{srealm}, $id]);
 $row = $allrows? $allrows->[0] : undef;
 if($row) {
	pop @$row;
	pop @$row;
 }
 return $row;

}

# end of zGa::kCa
1;
