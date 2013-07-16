# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 4349 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/yRa.al)"
sub yRa{ 
	my ($self) = @_;
	my $bRaA = $self->wPa();	
	my @fids = $bRaA->yVa(1,0);
 my $cgi = qq($self->{cgi});
 my     $golink = qq(<table border="0" cellspacing=0 cellpadding=0><tr>
<form action="${cgi}" method="GET"><td>Post with:  </td><td><font size="-1">
 				@{[$abmain::cYa]}
<select name="attachfid" onchange="location='$self->{cgi}?@{[$abmain::cZa]}cmd=form;attachfid='+this.options[this.selectedIndex].value">);
	$golink.=qq(<option value="">Plain message);
	for(@fids) {
		my ($k, $v) = @$_;
		$golink.=qq(<option value="$k">$v);
 }
 my $imgurl="${cgi}?@{[$abmain::cZa]}cmd=vL;img=1";
 $imgurl = $self->{gobtn_url} if $self->{gobtn_url};
 $golink .= qq(</select></font></td><td valign="middle"><input type="hidden" name="cmd" value="form">  <input align="middle" type=image alt="Go" name="Go to page" src="$imgurl" border="0"></td></form></tr></table>);
}

# end of jW::yRa
1;
