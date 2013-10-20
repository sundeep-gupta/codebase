# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 4165 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/subst.al)"
sub subst {
 my ($str, $tref, $valref) =@_;
 return $str if not ref($tref);
 for my $x (@$tref) {
 my $rep = shift @$valref || "";
 $str =~ s/$x/$rep/gi;
 }
 return $str;
}

# end of jW::subst
1;
