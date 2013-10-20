# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1766 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/kB.al)"
sub kB {
 my($self) = @_;
 abmain::error('iT', 'Cookie not received') unless ($abmain::fPz{test_cook} || not $self->{force_cookie}) ;
 $self->iA(\@abmain::pP);
 abmain::jJz(\$self->{kQ});
 $self->fZz($self->{kQ});
 if($self->{gFz}->{lc($self->{kQ})}->[5] >0) {
 	  abmain::error("inval", "You must activate your account first.");
 }
 my $ustat = $self->{gFz}->{lc($self->{kQ})}->[4];
 abmain::error('inval', "User is not activated")
	             if($ustat ne '' && $ustat ne 'A');
 my $qIz = abmain::wS($abmain::gJ{qIz})  if($abmain::gJ{qIz}) ;
 my $cE= $self->{fYz}->{lc($self->{kQ})};
 my $auth_stat = $self->auth_user($self->{kQ}, $self->{eF}->{nC});
 if($auth_stat eq 'NOUSER' && $self->{gAz}) {
 my $tP= abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=yV;qIz=$qIz", $self->{sK});
 abmain::error("dM", "User not found. Please $tP.");
 }
 if($auth_stat eq 'AUTHFAIL'){
 $self->wNz(0, $self->{kQ}, $self->nDz('usrlog'));
 my $req;
 $req = "<br/>". abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=reqpassform", "Request lost password") if($self->{mWz});
	 
	abmain::bP("Incorrect password.$req");
	return;
 }
 if(not $self->gOaA(1)) {
 $self->wNz(0, $self->{kQ}, $self->nDz('usrlog'));
 abmain::error('deny');
 }
 $self->wNz(1, $self->{kQ}, $self->nDz('usrlog'));
 my $uid_c = unpack("h*", $self->{kQ});
 $cE = unpack("H*", $self->{eF}->{nC});
 my $url = $self->fC();
 my $cookexp="";
 if($self->{rem_upass}) {
 $cookexp=abmain::dU('pJ', 10*3600*24);
 }
 my $cVz;
 my $i;
 if($abmain::gJ{qIz}) {
 $cVz=qq(<META HTTP-EQUIV="refresh" CONTENT="2; URL=).$abmain::gJ{qIz}.'">';
 }

 $self->eMaA( [qw(other_header other_footer)]);
 sVa::gYaA "Content-type: text/html\n";
 print abmain::bC('fOz', "$uid_c\&$cE", '/',$cookexp), "\n";
 print qq(<html><head>$cVz\n$self->{sAz}\n$self->{other_header}
 <center>
 <table border="0" cellpadding="5" width=60%><tr rowspan=2 bgcolor="$self->{cfg_head_bg}"><th><font $self->{cfg_head_font}>Logged onto $self->{name}</font></th></tr></table>
		</center>
 );
 print $self->cNaA($self->{kQ});
 print "$self->{other_footer}";
 $self->fSa($self->{kQ}, "Login");
}

# end of jW::kB
1;
