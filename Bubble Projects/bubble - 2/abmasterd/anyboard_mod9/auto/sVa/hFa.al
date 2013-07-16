# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 359 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/hFa.al)"
sub hFa{
 my ($url, $str, $popwin, $attr, $w, $h) = @_;
 return '' if !$url;
 return '' if !$str;
 return cUz($url, $str, undef, $attr) if $sVa::no_pop_link;
 $popwin="netbula_new" if $popwin eq "";
 $w = 0.75 if not $w;
 $h = 0.75 if not $h;
 return qq(<a href="javascript:newWindow('$url', '$popwin', $w, $h,'yes')" $attr>$str</a>);
}

# end of sVa::hFa
1;
