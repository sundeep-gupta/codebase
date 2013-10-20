# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 4836 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/nKz.al)"
sub nKz{
 my $color = shift;
 $color = qq(bgcolor="$color") if $color;
 my $tstr = qq(<tr $color>);
 for (@_) {
 $tstr .= qq(<td> $_\&nbsp;</td>);
 } 
 return $tstr."</tr>";
}

# end of jW::nKz
1;
