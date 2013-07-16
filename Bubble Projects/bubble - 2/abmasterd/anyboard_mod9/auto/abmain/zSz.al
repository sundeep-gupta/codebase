# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 2532 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/zSz.al)"
sub zSz {
 my ($id, $varri, $aOa, $zJz) = @_;
 my $str = qq(<select name="$id">);
 my ($sel, $dv);
 for (@$varri) {
 $sel = "";
 $sel ="SELECTED" if $aOa && $aOa eq $_;
 if($zJz) {
 $dv = shift @$zJz;
 }else {
 $dv = $_;
 }
 $str .= qq(<option value="$_" $sel>$dv);
 }
 return $str."</select>";  
}

# end of abmain::zSz
1;
