# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 388 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/fUaA.al)"
sub fUaA{
 my ($url, $str, $msg, $attr) = @_;
 return '' if !$url;
 return '' if !$str;
 return qq(<a href="$url" $attr onclick="return window.confirm('$msg');">$str</a>);
}

# end of sVa::fUaA
1;
