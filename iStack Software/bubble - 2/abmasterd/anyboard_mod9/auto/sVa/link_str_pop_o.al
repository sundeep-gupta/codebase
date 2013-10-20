# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 379 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/link_str_pop_o.al)"
sub link_str_pop_o{
 my ($url, $str, $popwin, $attr, $w, $h) = @_;
 return '' if !$url;
 return '' if !$str;
 $popwin="netbula_new" if $popwin eq "";
 $w = 0.6 if not $w;
 $h = 0.6 if not $h;
 return qq(<a href="$url" $attr onclick="newWindow(this.href, '$popwin', $w, $h,'yes');return false;">$str</a>);
}

# end of sVa::link_str_pop_o
1;
