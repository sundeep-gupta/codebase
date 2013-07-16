# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 3556 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/vQz.al)"
sub vQz{            
 my ($dir, $jT) = @_;
 opendir DIRF, $dir; 
 my @jXz = grep !/^\.\.?$/, readdir DIRF;
 close DIRF;
 my ($sdesc, $catdesc, $list, $makeb, $catnews, $catguide, $catinhe, $catinheg)
 =abmain::lIz($dir);

 my @forums=();
 my @cats =();
 for(sort @jXz) {
 my $d = abmain::kZz($dir, $_);
 my $sd = $_;
 next if not -d $d;
 my $cgi = abmain::kZz($jT, $sd);
 if(-f abmain::kZz($d, ".forum_cfg") and -f abmain::kZz($d, ".msglist") ) {
 push @forums, new jW(eD=>$d, cgi=>$cgi );
 }elsif (-f abmain::kZz($d, ".catidx")){
 push @cats, vQz($d, $cgi);
 }
 }
 return [$sdesc, $jT, $list, [@cats], [@forums]];
}

# end of abmain::vQz
1;
