# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 370 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/pop_js_url.al)"
sub pop_js_url{
 my ($url, $popwin, $attr, $w, $h) = @_;
 return '' if !$url;
 $popwin="netbula_new" if $popwin eq "";
 $w = 0.75 if not $w;
 $h = 0.75 if not $h;
 return qq("javascript:newWindow('$url', '$popwin', $w, $h,'yes')" $attr);
}

# end of sVa::pop_js_url
1;
