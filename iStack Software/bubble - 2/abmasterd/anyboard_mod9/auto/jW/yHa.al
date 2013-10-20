# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 5352 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/yHa.al)"
sub yHa{
	my ($self) = @_;
	my $bRaA = $self->wPa();	
	my @fids = $bRaA->yVa(1,1);
	my $hdr ="<h1>Please choose one of the following forms</h1>";
	my $form_start = qq(<form name="postmsg" method="POST" action="$self->{cgi}"> @{[$abmain::cYa]});
	$form_start .=qq(
			<input type=hidden name="cmd" value="form">
			<input type=hidden name="upldcnt" value="$self->{def_extra_uploads}">
			<input type=hidden name="shortform" value="1">
			);
	for(@fids) {
		my ($k, $v) = @$_;
		$form_start.=qq(<li><input type="radio" name="attachfid" value="$k">$v);
	}
	$form_start .=qq(<br/><input type="submit" name=x value="Submit">);
	$form_start .="</form>";
	sVa::gYaA "Content-type: text/html\n\n";
	print $self->yLa("<center>$hdr".$self->yRa()."</center>");
}

# end of jW::yHa
1;
