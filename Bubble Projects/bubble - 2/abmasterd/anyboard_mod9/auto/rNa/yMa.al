# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package rNa;

#line 1288 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/rNa/yMa.al)"
sub yMa {
	my ($self, $pos, $xZa) = @_;
	my @links = $self->uJa($xZa);
	my $str = qq(<div class="bHa">);
	$str .= qq(<table cellpadding=3 style="font-size: 14px; font-family: Arial" class="FormMagicNavBar">);
	$str .="<tr>";
	for my $lnk (@links) {
		my ($k, $l) = @$lnk;
		my $bg ="#dddddd";
		if( $k eq $pos) {
			$bg = qq("#6699cc");
		}
		$str .= qq(<td onmouseover="this.bgColor='#99ccff'" onmouseout="this.bgColor='#dddddd'" bgcolor=$bg>$l</td>);
	}
	$str .="</tr></table></div>";
	return $str;
	
}

# end of rNa::yMa
1;
