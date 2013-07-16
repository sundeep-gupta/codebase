# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 8607 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/cMaA.al)"
sub cMaA{
	my ($self, $vH, $to) = @_;
 my ($cLaA, $rcptuid, $senderuid, $senderdomain, $wW, $url, $cat, $status, $postime, $readtime, $replytime, $modtime);
	$senderuid = $vH->{hC};
	$senderdomain = $self->{eD};
	$cLaA = $vH->{fI};
	$wW = $vH->{wW};
	$url = $vH->nH($self, -1);
	$cat = $vH->{scat};
	$status = "new";
	$postime = $vH->{mM};
	$readtime = 0;
	$replytime = 0;
	$modtime = $vH->{mtime};
 for my $to1 (split /\s*,\s*/, $to) {
		next if $to1 !~ /\S/;
		$rcptuid = $to1;
 		my $f = $self->bJa($to1, 'mbox');
		$bYaA->new($f, {schema=>"AbMsgBox", paths=>$self->dHaA($f), index=>5 }) ->iSa([$cLaA, $rcptuid, $senderuid, $senderdomain, $wW, $url, $cat, $status, $postime, $readtime, $replytime, $modtime]);
 }
}

# end of jW::cMaA
1;
