# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 2555 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/cUz.al)"
sub cUz {
 my ($url, $str, $tgt, $attr) = @_;
 return '' if !$url;
 return '' if !$str;
 $attr ||="";
 $attr =" $attr" if $attr;
 $attr =" $abmain::def_link_attr" if $abmain::def_link_attr;
 return qq(<a href="$url" target="$tgt"$attr>$str</a>) if $tgt;
 return qq(<a href="$url"$attr>$str</a>);
}

# end of abmain::cUz
1;
