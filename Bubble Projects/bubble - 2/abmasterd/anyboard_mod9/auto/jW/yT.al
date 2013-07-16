# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 4829 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/yT.al)"
sub yT{
 my $tstr = qq(<table border="0" cellpadding=2 cellspacing="1" bgcolor="#eeeecc"><tr bgcolor="#99cccc">);
 for (@_) {
 $tstr .= qq(<th> <font $abmain::dfa>$_\&nbsp;</font></th>);
 } 
 return $tstr."</tr>";
}

# end of jW::yT
1;
