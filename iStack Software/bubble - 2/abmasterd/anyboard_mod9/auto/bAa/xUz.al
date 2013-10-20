# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/bAa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package bAa;

#line 72 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/bAa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/bAa/xUz.al)"
sub xUz {
 my ($aFa, $id) = @_;
 return if not $aFa->{$id."_year"};
 return sVa::eGaA($aFa->{$id."_year"}, $aFa->{$id."hHa"}, $aFa->{$id."_day"},
 $aFa->{$id."_hour"}, $aFa->{$id."iOa"}, 0);
}

# end of bAa::xUz
1;
