# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 3174 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/lCa.al)"
sub lCa{
 my @arr = (split /(\d+)/, lc($_[1]))[0..2, 4,5,7..9]; 
 return  @arr if $_[1] eq kTa($_[0], @arr);
}

# end of abmain::lCa
1;
