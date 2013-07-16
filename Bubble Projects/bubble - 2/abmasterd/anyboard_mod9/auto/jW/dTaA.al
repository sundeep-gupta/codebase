# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 7841 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/dTaA.al)"
sub dTaA{
 my ($self, $cG, $fpos, $val) = @_;

 $self->gOaA();

	if(!$abmain::fPz{zN} && !$abmain::fPz{$self->{vcook}}){
#	   abmain::error('iT', "Please send Cookies to $title");
	} 
#      $self->gCz() if $self->{rRz};

	my $msg= zDa->new('AbMsgList');
	my $paths = $self->zOa('');
	my $p = $paths->[0];
	$msg->aPaA("where realm =? and msg_no=?", [$p, $cG]);

	my $nfval = $msg->{fpos};
	my $ofval = $msg->{fpos};
	my $f = 1<<($fpos -1);
 if($val) {
 $nfval |= $f;
 }else {
		$nfval &= ~$f;
 }
		
	if ($ofval == $nfval) {
		return;
	}
	$msg->{fpos}= $nfval;
	$msg->rRa(["fpos"],"where realm =? and msg_no=?", [$p, $cG]);
 	$self->rSz();
}

# end of jW::dTaA
1;
