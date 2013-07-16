# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 3981 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/zD.al)"
sub zD{
 my ($self, $cG)=@_;
 if( not $abmain::use_sql ) {
 	return unlink $self->gN($cG);
 }else {
	require zGa;
 	my $mpart = zDa->new('AbMsgPart');
 	my $eS =  $self->nDz('msglist'); 
	my ($p, $s) = @{$self->dHaA($eS)};
 	return $mpart->sHa("where realm=? and msg_no=?", [$p, $cG]);
 }
}

# end of jW::zD
1;
