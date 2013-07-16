# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 7806 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/xUz.al)"
#return date 

sub xUz {
 my ($aFa, $id) = @_;
 my ($y, $m, $d, $h, $mn, $ap)=
 ($aFa->{$id."_year"}, $aFa->{$id."hHa"}, $aFa->{$id."_day"},
 $aFa->{$id."_hour"}, $aFa->{$id."iOa"}, $aFa->{$id."_apm"});
 return wantarray? ($y, $m, $d, $h, $mn, $ap) : join(":", $y,$m,$d,sprintf("%02d",$h),sprintf("%02d", $mn), $ap);
}

# end of abmain::xUz
1;
