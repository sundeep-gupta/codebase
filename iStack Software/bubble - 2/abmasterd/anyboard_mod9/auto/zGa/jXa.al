# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zGa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zGa;

#line 119 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zGa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zGa/jXa.al)"
sub jXa{
 my ($self, $rowrefs) =@_;
 my $dbo = $self->{_dbobj};
 my $index = $self->{index};
 my $idxcol = $dbo->aDaA($index);
 for my $row (@$rowrefs) {
	push @$row, $self->{realm};
	push @$row, $self->{srealm};
	if($dbo->aPaA("where realm =? and srealm=? and $idxcol=?", [$self->{realm}, $self->{srealm}, $row->[$index]])) { 
		$dbo->aZaA($row, "where realm =? and srealm=? and $idxcol=?", [$self->{realm}, $self->{srealm}, $row->[$index]]);
	}else {
		$dbo->bIaA($row);
	}
 }
}

# end of zGa::jXa
1;
