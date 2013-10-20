# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/bAa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package bAa;

#line 152 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/bAa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/bAa/be_deci.al)"
sub be_deci {
 my $v = shift;
 return " invalid decimal" if ($v !~ /\d+(\.\d+)*/ or $v eq "");
 return;
}   

# end of bAa::be_deci
1;
