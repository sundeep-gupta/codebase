# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 7780 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/zJa.al)"
sub zJa {
 my ($self, $cG, $aCz, $wt, $arch) = @_;
	require zGa;
 $wt = 1 if not $wt;
 $self->gOaA();
	if(!$abmain::fPz{zN} && !$abmain::fPz{$self->{vcook}}){
	   abmain::error('iT', "Please send Cookies to $self->{name}");
	} 
 	$self->gCz() if $self->{rRz};

	my $msg= zDa->new('AbMsgList');
	my $paths = $self->zOa('');
	my $p = $paths->[0];
	$msg->aPaA("where realm =? and msg_no=?", [$p, $cG]);
 my ($aUz, $cnt) = ($msg->{rate}, $msg->{cnt});
 $aUz = ($aUz*$cnt + $aCz*$wt)/($cnt+$wt); 
 $cnt += $wt;
	$msg->{rate}=$aUz;
	$msg->{cnt}=$cnt;
	if($msg->{realm}) {
		$msg->rRa(["rate", "cnt"],"where realm =? and msg_no=?", [$p, $cG]);
 		$self->rSz();
	}
}

# end of jW::zJa
1;
