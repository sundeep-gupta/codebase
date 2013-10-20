# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 6117 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/gQa.al)"
sub gQa{
 $iS->cR() if -f $iS->nCa();
 abmain::error("deny") if  not abmain::eVa() ;
 my $wW = $abmain::gJ{em_subject};
 my $comments = $abmain::gJ{mycomments};
 my $myname = $abmain::gJ{myname} || "Your friend";
 my $myemail= $abmain::gJ{myemail};
 my $mailmerge= $abmain::gJ{em_merge};
 if($iS->{qK} >0 && length($comments) > $iS->{qK}){
 &abmain::error('iK', "Message body must be less than $iS->{qK}");
 }
 my $email = $abmain::gJ{em_emails};
 my %mail;
 $mail{From} = $myemail;
 $mail{To} = $email;
 $mail{To} =~ s/,?$//;
 $mail{Bcc} = $abmain::gJ{mybcc} ;
 $mail{Mlist} = scalar(abmain::hAa()) if $abmain::gJ{em_all};
 $mail{Mlist} =~ s/,?$//;
 $mail{Subject} =$wW;
 $mail{Body} = "$comments\n\n";
 #$mail{Body} .= "\n-------------------\nEmail sent by AnyBoard (http://netbula.com/anyboard/)\n";
 #$mail{Body} .= abmain::bW($ENV{'REMOTE_ADDR'}); 
 $mail{Smtp}=$iS->{cQz};
 my @errs;
 if($mailmerge) {
	$mail{to_list} = $mail{To};
	$mail{To} = undef;
	@errs = sVa::gLaA( \%mail);
 }else {
 	&abmain::vS(%mail);

 }
 if($abmain::wH) {
 abmain::cTz("Email failed: $abmain::wH");
 }else {
	abmain::cTz("<h1>Email sent</h1> Recipients:<br>$email<br>$mail{Mlist}\n@errs", "Response");
 }
}

# end of abmain::gQa
1;
