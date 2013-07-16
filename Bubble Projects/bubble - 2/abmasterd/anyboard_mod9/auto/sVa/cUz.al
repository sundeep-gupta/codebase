# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 395 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/cUz.al)"
sub cUz {
 my ($url, $str, $tgt, $attr) = @_;
 return '' if !$url;
 return '' if !$str;
 $attr ||="";
 $attr =" $attr" if $attr;
 return qq(<a href="$url" target="$tgt"$attr>$str</a>) if $tgt;
 return qq(<a href="$url"$attr>$str</a>);
}

# end of sVa::cUz
1;
