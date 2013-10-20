# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dZz.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package dZz;

#line 268 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dZz.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/dZz/eQz.al)"
sub eQz {
 my ($self) = @_;
 my $eIz=1;

 return $self->{eCz} if $self->{eCz};

 my $lref = $self->{gHz};
 my $start = $self->{ePz};
 my $lkey="";
 for(;$start< $self->{eLz}; $start++) {
	    $_ = $lref->[$start];
	    $_ =~ s/\r?\n$//;

	    if($_ eq '' && $eIz) {
			 $eIz =0;
 $self->{eKz} = $start +1;
 last;
 }
	    if($eIz){
			if($_ =~ /^([^: 	]+):\s*(.*)/) {
 $lkey = lc($1);
			    $self->{head}->{$lkey}= $2;
 }elsif($lkey) {
 $self->{head}->{$lkey} .= $_ ;
 }else {
			   last;
 }
 }
 }
 for(keys %{$self->{head}}) {
		$self->{head}->{$_} = dZz::pLa($self->{head}->{$_});
 }
 $self->{eCz}= ($lkey ne "");

}

# end of dZz::eQz
1;
