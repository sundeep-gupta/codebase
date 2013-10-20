# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 400 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/yTa.al)"
sub yTa{
	my ($self, $auto) = @_;
	my $mpath = $self->dFz();
 my $u_t = (stat($mpath))[9];
	if($auto && $u_t > time() -15) {
		return;
	}
	my ($msg, $cnt) = $self->nKa();
 if(not $auto) {
 	abmain::cTz($msg);
	}
	return if not $cnt >0;
	if((not $auto) || $u_t < time() - 30) {
 		$self->aT();
 		$self->eG();
	}
}

# end of jW::yTa
1;
