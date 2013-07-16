# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package rNa;

#line 322 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/rNa/rJa.al)"
sub rJa {
 my $v = shift;
 return 0 if $v =~ /\W/ or not $v;
 return 0 if $v eq 'cmd';
 return 1;

}

# end of rNa::rJa
1;
