# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 9273 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/jEz.al)"
sub jEz {
 my $lref = shift;
 my $attr = shift;
 $attr = " $attr" if $attr;
 my $urls = '(http|file|gopher|ftp|wais|https|javascript)';
 my $ltrs = '\w';
 my $gunk = '/#~:.,?+=&%@!\-\|\$';
 my $punc = '.:?\-';
 my $any  = "${ltrs}${gunk}${punc}";
 #$$lref =~ s{([^="']\s+|^)(${urls}:[$any]+?)(?=[$punc]*[^$any]|$)(?!")}{$1 <a href="$2"$attr>$2</a>}goi;
 $$lref =~ s{([^="']\s+|^)(${urls}:[$any]+?)(?=[^$any]|$)(?!")}{$1 <a href="$2"$attr>$2</a>}goi;
 $$lref =~ s{$abmain::uD}{<a href="mailto:$1">$1</a>}goi;
}

# end of jW::jEz
1;
