# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 5058 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/xCz.al)"
sub xCz {
 $iS->iA(\@abmain::lQa);
 my $cgi = $jT;
 my $pA = $abmain::gJ{cat_dir};
 my $fM = $abmain::gJ{root_name};
 my $admin_pass = $abmain::gJ{root_passwd};

 if(not -e $abmain::oG){
 $iS->jI(\@abmain::dN, "bDz", "Create master admin first");
 abmain::iUz();
 }
 $iS->cJ($abmain::oG, \@abmain::dN);
 my $root_pass = abmain::lKz($iS->{eF}->{root_passwd}, $iS->{root_passwd});

 if($iS->{root_name} ne $abmain::gJ{root_name} || $iS->{root_passwd} ne $root_pass) {
 error('dM', "Invalid login id or password");
 }
 my $dir = abmain::kZz($iS->{eD}, $pA);
 abmain::error('inval', "Directory $dir exists") if -d $dir;
 mkdir $dir, 0755 or abmain::error('sys', "When create $dir: $!");
 $iS->{root_passwd}="";
 $iS->{root_name}="";
 $iS->cW(abmain::kZz($dir, ".catidx"), \@abmain::lQa);
 my $fvp = $abmain::fvp;
 my $cVz;
 if($abmain::no_pathinfo) {
	my $fvps = kZz($fvp, $pA);
 $cVz =  $dLz. "?fvp=$fvps;cmd=lGz;lF=1"; 
 }else {
 	$cVz =  kZz($dLz, "/$pA?cmd=lGz;lF=1"); 
 }
 sVa::hCaA "Location: $cVz\n\n";
}

# end of abmain::xCz
1;
