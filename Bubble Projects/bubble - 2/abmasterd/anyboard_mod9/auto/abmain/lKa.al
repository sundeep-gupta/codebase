# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 5381 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/lKa.al)"
sub lKa {
 $iS->cR();
 my $pass = int (rand()*time()+1);
 my $sf = $iS->nDz('skey');
 open F, ">$sf" or abmain::error('sys', "On writing file $sf: $!");
 print F abmain::lKz($pass);
 close F; 
 $iS->xI("New admin password", "Password: $pass\nURL: ".$iS->fC()."\n"."You should change password immediately\n", 1);
 cTz("Password has been sent to you by email", "New password", $iS->fC());
}

# end of abmain::lKa
1;
