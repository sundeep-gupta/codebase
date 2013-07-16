# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 6203 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/tLz.al)"
sub tLz {
 $iS->cR();
 $iS->{tHa} = 1;
 $iS->{_admin_only}=1 if not $iS->{uIz};
 $iS->{gAz} =1 if $iS->{uSz};
 my @jS = abmain::oCa(\@abmain::del_conf_cfgs);
 push @jS, ["eveid", "hidden"];
 my $eveform = aLa->new("eve", \@abmain::uHz);
 my $ef = abmain::kZz($iS->nDz('evedir'), "$abmain::gJ{eveid}.eve"); 
 $eveform->load($ef);
 $iS->tGz();  
 my $name=$iS->{fTz}->{name};
 if ($name ne $eveform->{eve_author}) {
		abmain::error('deny', "Only the author can modify it")
 unless (($name eq $iS->{admin} || $iS->{moders}->{$name}));
 }
 $jS[0][2]="Please confirm the deletion of event: <b>$eveform->{eve_subject}</b>";
 $iS->{eveid} = $abmain::gJ{eveid};
 $iS->jI(\@jS, "tUz", "");
}

# end of abmain::tLz
1;
