# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 3076 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/cLz.al)"
sub cLz {
 my $name = shift;
 if($name) {
 return  abmain::kZz($abmain::master_cfg_dir,"$name.conf");
 }
 return $bWz;
}

# end of abmain::cLz
1;
