# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 4320 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/yZa.al)"
sub yZa{ 
	my ($self, $fu, $zu, $scat, $xZa) = @_;
	my $bRaA = $self->wPa();	
	my @fids = $bRaA->yVa(0,1);
 my @rids = $bRaA->yUa($xZa);
 my %rhash=();
	for(@rids){
		$rhash{$_}=1;
 }
 my $cgi = qq($self->{cgi}?@{[$abmain::cZa]});
 my     $golink = qq(<table border="0" cellspacing=0 cellpadding=0><tr>
<form action="${cgi}" method="GET"><td>Reply with:  </td><td><font size="-1">
 				@{[$abmain::cYa]}
<select name="attachfid" onchange="location='$self->{cgi}?@{[$abmain::cZa]}cmd=follow;zu=$zu;fu=$zu;scat=$scat;attachfid='+this.options[this.selectedIndex].value">);
	$golink.=qq(<option value="">Plain message);
	for(@fids) {
		my ($k, $v) = @$_;
		next if not $rhash{$k};
		$golink.=qq(<option value="$k">$v);
 }
 my $imgurl="${cgi}@{[$abmain::cZa]}cmd=vL;img=1";
 $imgurl = $self->{gobtn_url} if $self->{gobtn_url};
 $golink .= qq(</select></font></td><td valign="middle">
<input type="hidden" name="cmd" value="follow">
<input type="hidden" name="zu" value="$zu">
<input type="hidden" name="fu" value="$fu">
<input type="hidden" name="scat" value="$scat">
<input align="middle" type=image alt="Go" name="Go to page" src="$imgurl" border="0"></td></form></tr></table>);
}

# end of jW::yZa
1;
