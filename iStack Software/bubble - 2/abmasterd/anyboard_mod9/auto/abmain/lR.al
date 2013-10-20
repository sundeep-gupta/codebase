# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 5836 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/lR.al)"
sub lR {
 $iS->cR();
 $iS->gCz(1);
 my $name= $abmain::gJ{kQ} || $iS->{fTz}->{name};
 my $fMz= $iS->{user_init_type}||'E';
 my $ustat = $iS->{user_init_stat} || 'A';
 my $yK;
 if($abmain::gJ{cmd} eq 'xT') {
 abmain::error('deny', "Username does not match") if(lc($name) ne lc($iS->{fTz}->{name}));
 }
 if(lc($name) eq lc($iS->{fTz}->{name}) && $iS->{fTz}->{reg}){
 $yK =1;
 if($iS->{gFz}->{lc($name)}->[1] eq $abmain::gJ{email}){
 $iS->{rH} = 0;
 }
 $fMz = $iS->{gFz}->{lc($name)}->[6];
 $ustat = $iS->{gFz}->{lc($name)}->[4];
 }elsif($iS->{rH}) {
 $ustat = 'C';
 }
 if($iS->{ask_on_reg} && not $yK) {
 my $ans = $iS->{reg_answer};
 my $ans1 = $abmain::gJ{my_answer};
 $ans1 =~ s/\s+/ /g;
 $ans =~ s/\s+/ /g;
 abmain::error('inval', $iS->{inval_ans_err}) unless $ans1 =~ /$ans/i;
 }
 my $err;
 
 if($err=abmain::jVz($name)) {
 abmain::error('inval', $err);
 }

 if(length($name) > $iS->{sO}){
 &abmain::error('iK', "Name field must be less than ${\($iS->{sO})} characters");
 }
 abmain::error('miss', "Name and Password are required") 
 unless $abmain::gJ{nC} && $name;
 if($abmain::gJ{nC} =~ /\s+/) {
 abmain::error('inval', "Password must not contain spaces");
 }
 if($abmain::gJ{nC} ne $abmain::gJ{bD}) {
 abmain::error('inval', "Passwords do not match");
 }
 if($err=abmain::jVz($name)) {
 abmain::error('inval', $err);
 }
 abmain::jJz(\$name);
 my $n_re = $iS->{forbid_names};
 if($n_re) {
 &abmain::error('inval', "The name you used is not allowed") if $name =~ /$n_re/i;
 }

 $abmain::gJ{wO}=~ s/\t/ /g;
 $abmain::gJ{wO}=~ s/\n/ /g;
 $abmain::gJ{wJ} =~ s/\t/ /g;
 $abmain::gJ{wJ} =~ s/\n/ /g;
 $abmain::gJ{xK} =~ s/\t/ /g;
 $abmain::gJ{xK} =~ s/\n/ /g;

 $iS->dJ($name, $abmain::gJ{nC}, 
 $abmain::gJ{email},  $abmain::gJ{wO}, $ustat, int rand()* time(),
 $fMz, $abmain::gJ{wJ}, $abmain::gJ{xK}, $abmain::gJ{add2notifiee}, $abmain::gJ{noshowmeonline});
 my $url = $iS->fC();
 if($iS->{rH}) {
 $jW::iG = "";
 }    
 my $uid_c = unpack("h*", $name);
 my $cook = abmain::bC($abmain::cH, abmain::nXa($name), '/', abmain::dU('pJ',24*3600*128));
 my $cVz=$abmain::gJ{qIz};
 my $msg;
 if($iS->{rH}) {
 	$msg = "Thank you, $name! An email with account activation instruction has been sent to you.";
 }else {
 if($yK) {
 		 $msg= "$name! Your registration has been modified";
 }else {
 	 $msg ="Congratulations, $name! You are now registered.";
 		 $cVz = $iS->{mp_url} || "$iS->{cgi}?@{[$abmain::cZa]}cmd=mform" if $iS->{mp_enabled};
	        $iS->pHa($name) if $iS->{post_welcome};
 }
 }
 abmain::cTz("<h1>$msg</h1>", "Register", $cVz||$iS->fC(), $cook);
}

# end of abmain::lR
1;
