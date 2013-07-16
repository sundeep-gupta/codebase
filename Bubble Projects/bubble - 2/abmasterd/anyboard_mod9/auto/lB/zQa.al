# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/lB.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package lB;

#line 171 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/lB.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/lB/zQa.al)"
sub zQa{
 my ($self, $iS, $conver, $file)=@_;
 $conver = 0 if $file;
 require zDa;
 my $mpart = zDa->new('AbMsgPart');
 my $eS =  $iS->nDz('msglist'); 
 my ($p, $s) = @{$iS->dHaA($eS)};
 $mpart->aPaA("where realm =? and msg_no=?", [$p, $self->{fI}]);
 my $row = zGa->new($eS, {index=>2, schema=>"AbMsgList", paths=>$iS->dHaA($eS) })->kCa($self->{fI});

 @{$self}{@mfs} = @$row;
 for my $f (@mfs2) {
	my $k = lc($f);
	$self->{$f} = $mpart->{$k};
 }
 return 8;
}

# end of lB::zQa
1;
