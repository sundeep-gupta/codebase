# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 4821 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/nNa.al)"
sub nNa{
 my $ta = shift;
 my $tstr = qq(<table bgcolor="#eeeecc" $ta><tr bgcolor="#99cccc">);
 for (@_) {
 $tstr .= qq(<th> <font $abmain::dfa>$_\&nbsp;</font></th>);
 } 
 return $tstr."</tr>";
}

# end of jW::nNa
1;
