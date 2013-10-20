# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2348 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/pIa.al)"
sub pIa{
 my $gEz = $abmain::fPz{SSOCookie};
 my $plain_logstr = dZz::fIa($gEz);
 my @entities = split/\|/, $plain_logstr;
 my $gJz = $entities[2];
 return $gJz;
}

# end of jW::pIa
1;
