# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1922 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/gCz.al)"
sub gCz {
 my($self, $noerr, $logop) = @_;
 my $gEz = $abmain::fPz{fOz};
 my $qIz=abmain::wS($abmain::orig_url);
 my  $fNz= abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=dW;qIz=$qIz", $self->{fKz});
 if(!$gEz) {
 if(($self->{force_login_4read} || $self->{tHa} ||($self->{yLz} eq 'RATE' && $self->{rRz})) && !$noerr) {
	      sVa::hCaA "Location: $self->{cgi_full}?@{[$abmain::cZa]}cmd=dW;qIz=$qIz\n\n";
 	      &abmain::iUz;
	  }
 return;
 }
 my ($gJz, $fJz) = split/\&/, $gEz;
 $gJz = pack("h*", $gJz);
 $fJz = pack("H*", $fJz);
 $self->fZz($gJz);

 my $auth_stat =  $self->auth_user($gJz, $fJz);
 if( $auth_stat eq 'AUTHFAIL') {
 		abmain::error('dM', "You need to $fNz.") unless $noerr;
 return;
 }
 if($self->{gAz} && $auth_stat eq 'NOUSER'){
 	abmain::error('dM', "You need to relogin: $fNz.") unless $noerr;
 return;
 }
 abmain::error('inval', "User is not activated")
	             if($self->{gAz} && $self->{gFz}->{lc($gJz)}->[4] ne 'A');

 abmain::error('deny', "This operation is enabled for adminitrator only.")
 if($self->{_admin_only} && lc($gJz) ne $self->{admin});

 $self->oXa($gJz);
 return 1;
}

# end of jW::gCz
1;
