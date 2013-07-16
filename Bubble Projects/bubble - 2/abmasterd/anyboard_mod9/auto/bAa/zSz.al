# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/bAa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package bAa;

#line 30 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/bAa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/bAa/zSz.al)"
sub zSz {
 my ($id, $varri, $aOa, $zJz) = @_;
 my $str = qq(<select class="FormSelect" name="$id">);
 my ($sel, $dv);
 my $i =0;
 for (@$varri) {
 $sel = "";
 $sel =qq(selected="selected") if $aOa && $aOa eq $_;
 if($zJz) {
 $dv = $zJz->[$i];
	    $i++;
 }else {
 $dv = $_;
 }
	my $idx = $i%2;
	my $cls;
	if($sel ne '') {
		$cls = "option_selected";
	}else {
		$cls = "option_select_$idx";
	}
 $str .= qq(<option class="$cls" value="$_" $sel>$dv</option>);
 }
 return $str."</select>";  
}

# end of bAa::zSz
1;
