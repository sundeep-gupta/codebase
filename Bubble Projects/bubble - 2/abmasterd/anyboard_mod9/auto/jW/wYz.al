# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 9286 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/wYz.al)"
sub wYz {
 my $lref = shift;
 my $urls = '(http|file|gopher|ftp|wais|https|mailto)';
 my $ltrs = '\w';
 my $gunk = '/#~:.?+=&%@!\-\|';
 my $punc = '.:?\-';
 my $any  = "${ltrs}${gunk}${punc}";
 $$lref =~ /(${urls}:[$any]+?)(?=[$punc]*[^$any]|$)/goi;
 return $1;
}

# end of jW::wYz
1;
