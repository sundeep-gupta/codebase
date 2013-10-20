# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 3102 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/gOa.al)"
sub gOa{
 my ($dir, $user)=@_;
 my $exfile =abmain::kZz($dir, ".kill");
 open(aXz, ">>$exfile") or abmain::error('sys', "On writing file $exfile: $!");
 print aXz "$user\n";
 close aXz;
}

# end of abmain::gOa
1;
