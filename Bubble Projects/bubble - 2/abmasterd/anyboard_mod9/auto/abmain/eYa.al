# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 4382 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/eYa.al)"
sub eYa {
 my $fM = $abmain::gJ{root_name};
 my $admin_pass = $abmain::gJ{root_passwd};

 if(not -e $abmain::oG){
 $iS->jI(\@abmain::dN, "bDz", "Create master admin first");
 abmain::iUz();
 }
 $iS->cJ($abmain::oG, \@abmain::dN);
 my $root_name;
 my $root_pass;

 my $cryp_pass = abmain::lKz($admin_pass, $iS->{root_passwd});
 if($iS->{root_name} ne "") {
	 $root_name = $iS->{root_name};
	 $root_pass = $iS->{root_passwd};
 }else {
	 $root_name = $iS->{aF};
	 $root_pass = $iS->{oU};
 }
	
 if($root_name ne $fM || $root_pass ne $cryp_pass) {
	      error('dM', "Invalid login id or password");
 }
 
 my $uid_c = unpack("h*", $fM);
 my $cE = unpack("H*", $admin_pass);
 my $cVz;
 if($abmain::gJ{qIz}) {
 $cVz=qq(<META HTTP-EQUIV="refresh" CONTENT="0; URL=).$abmain::gJ{qIz}.'">';
 }
 sVa::gYaA "Content-type: text/html\n";
 print abmain::bC('master_login', "$uid_c\&$cE", '/'), "\n"; 
 abmain::bOaA();
 abmain::fWa() if not -d abmain::kZz($abmain::master_cfg_dir, "main");
 
}

# end of abmain::eYa
1;
