# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 2743 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/yDz.al)"
sub yDz{
 my $str = shift;
 my $maxlen = shift;
 my $len = length($str);
 return $str if $len <= $maxlen;
 return substr($str, 0, $maxlen -3)."...";
}

# end of abmain::yDz
1;
