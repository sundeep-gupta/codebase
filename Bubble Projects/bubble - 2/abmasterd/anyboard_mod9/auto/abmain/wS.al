# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 8219 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/wS.al)"
sub wS {   
 my $str = shift;
 return "" if $str eq "";
 $str =~ s/([" %?&+<=>';\r\n])/sprintf '%%%.2X' => ord $1/eg;
 return $str;
}

# end of abmain::wS
1;
