# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 4265 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/sWz.al)"
sub sWz {
 $iS->cR();
 $iS->{tHa} = 1;
 $iS->tGz();  
 $iS->{sZz} =~ s/USER_NAME/$iS->{fTz}->{name}/g;
 $iS->sEz($iS->{chat_sys_name}, $iS->{sZz}. " (".dU('SHORT').")", 1, 'sm_happy');
 $iS->fSa($iS->{fTz}->{name}, "Exit Chat");
 abmain::cTz("You have exited the chatroom", undef, undef, undef, 1);
}

# end of abmain::sWz
1;
