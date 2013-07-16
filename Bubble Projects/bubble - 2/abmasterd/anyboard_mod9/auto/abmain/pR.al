# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 2697 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/pR.al)"
sub pR {
 $oG = abmain::kZz($abmain::master_cfg_dir,"config");
 $cAz = abmain::kZz($abmain::master_cfg_dir,"forum_list");
 $bWz = abmain::kZz($abmain::master_cfg_dir,"default.conf");
 $oC = abmain::kZz($abmain::master_cfg_dir,$abmain::no_dot_file?"fYz":".fYz");
 $master_dbdef_dir = abmain::kZz($abmain::master_cfg_dir, 'dbdefs');
}

# end of abmain::pR
1;
