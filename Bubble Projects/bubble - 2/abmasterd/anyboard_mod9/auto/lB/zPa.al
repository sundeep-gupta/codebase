# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/lB.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package lB;

#line 102 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/lB.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/lB/zPa.al)"
sub zPa{
 my ($self, $iS, $file)=@_;
 require zDa;
 require zGa;
 my $mpart = zDa->new('AbMsgPart');
 my $eS =  $iS->nDz('msglist'); 
 my ($p, $s) = @{$iS->dHaA($eS)};
 $mpart->sHa("where realm=? and msg_no=?", [$p, $self->{fI}]);
 $mpart->aTaA({
	rlink_title =>$self->{rlink_title},
	img => $self->{img},
	aliases =>$self->{aliases},
	body =>$self->{body},
	hack=>$self->{hack},
	modifier=>$self->{modifier},
	msg_no=>$self->{fI},
	realm=>$p,
 }
 );
 $mpart->tEa();
}

# end of lB::zPa
1;
