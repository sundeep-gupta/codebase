# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 2617 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/oYa.al)"
sub oYa {
 my $f = abmain::kZz($abmain::master_cfg_dir, $$);
 open F, ">$f.dmp";
 print F "ENV:\n";
 for(keys %ENV) {
	print F $_, "=", $ENV{$_}, "\n";
 } 
 print F "gJ:\n";
 for(keys %abmain::gJ) {
	print F $_, "=", $abmain::gJ{$_}, "\n";
 } 
 print F $abmain::start_time, "--", time();
 close F;
 abmain::error('sys', "time out");
}

# end of abmain::oYa
1;
