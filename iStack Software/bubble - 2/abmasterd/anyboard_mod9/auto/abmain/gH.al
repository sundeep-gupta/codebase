# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 3117 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/gH.al)"
sub gH {
 my $dVz = $iS->{eD};
 $dVz =~ s!\\!/!g if $^O =~ /win/i;
 $dVz =~ s#/[^/]+/?$##; #remove last dir component
 my $canmake = (abmain::lIz($dVz))[3];
 abmain::error('deny', "Can not make forum under $abmain::eD.") if not $canmake;  
 abmain::error('inval', "$dVz does not exist!") if ($abmain::no_nest_bdir && not -d $dVz);
 $iS->{admin}= $abmain::gJ{admin};
 $iS->{admin_email}= $abmain::gJ{admin_email};
 $iS->{name}=$abmain::gJ{name};
 $iS->{admin} =~ s/\t/ /g;
 $iS->{name} =~ s/\t/ /g;
 $iS->cJ($abmain::oG, \@abmain::dN);
 my $pA = $abmain::gJ{pA};
 my $eD = $iS->{eD};
 $eD =~ s!\\!/!g if $^O =~ /win/i;
 $pA =~ s#/?$##;
 $eD =~ s#/?$##;
 $eD =~ s!$pA$!!;
 if(not -d $eD) {
	error('inval', "$eD does not exist!<br> It seems that the script needs custom configuration. You can logon master admin panel (".
			abmain::cUz($abmain::lGa, $abmain::lGa). ") ".
 "and fix the configurations by setting no_pathinfo to 1  and set the fixed directories and URLs. If it still does not work, submit an installation request to AnyBoard support ( http://netbula.com/anyboard/installreq.html )"
 );
	
 }
 error('dM', "Who are you?") if $iS->{oU} ne $abmain::gJ{kS}; 
 $abmain::top_virtual_dir =~ s!^/?!/!;
 error('inval', "New forum virtual path must start from $abmain::top_virtual_dir ($abmain::fvp)")
 if($abmain::fvp !~ /^$abmain::top_virtual_dir/);
 my @paths= $iS->eP($abmain::gJ{gF}, $iS->{name}, $iS->{admin}, $iS->{admin_email}, $abmain::gJ{cKz}, $abmain::gJ{iGz}||$iS->{iGz});
 $bYaA->new($abmain::cAz, {schema=>"AbMasterList"})->iSa(
 	[$iS->{name}, $iS->{admin}, $iS->{admin_email}, time(), $fvp, $abmain::gJ{gF}, $iS->{eD}, abmain::lWz()]
 );
 
 if($abmain::validate_admin_email) {
 abmain::cTz(abmain::cUz($iS->xIz(), $iS->{name}). " created.<br> Administrator password sent to $iS->{admin_email}");
 }else {
 sVa::hCaA "Location: $dLz?@{[$abmain::cZa]}cmd=login;fM=$iS->{admin}\n\n";
#       sVa::hCaA "Location: ", $iS->xIz(), "\n\n";
 }
}

# end of abmain::gH
1;
