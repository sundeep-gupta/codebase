# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 8545 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/eKaA.al)"
sub eKaA {
 my ($self, $kQ) = @_; 
 my $f = $self->bJa($kQ, 'mbox');
 my $jKa = $bYaA->new($f, {schema=>"AbMsgBox", paths=>$self->dHaA($f), index=>5 })->iQa({noerr=>1, where=>"rcptuid='$kQ'"});
 my @rows;
 return  if not ($jKa || scalar(@$jKa));
 my $cbox;
 for my $jRa (@$jKa) {
 	my ($cLaA, $rcptuid, $senderuid, $senderdomain, $wW, $url, $cat, $status, $postime, $readtime, $replytime, $modtime) = @$jRa;
	my $cbox =qq(<input type=checkbox name="pmurl" value="$url">);
 my $mt  = $modtime||$postime;
 my $pd  = $self->fGz(abmain::dU('STD', $mt, 'oP'), 'date_font_msg');
 my $readstat = $readtime > $mt? "READ": "Not read";
 my $repstat = $replytime > $mt? "Replied": "Not replied";
	my $lnk = abmain::cUz($url, $wW);
	push @rows, [$cbox, $lnk, $senderuid, $pd, $readstat, $repstat, $readtime, $mt];
 }
 my @rows2 = sort { $b->[7] <=> $a->[7]} @rows;
 push @rows2, [qq(<input type="submit" class="buttonstyle" value="Delete checked entries">)];
 my $colsel = [0, 1, 2, 3,4, 5 ];
 my @ths = ("", "Subject", "Sender", "Time", "Read status", "Reply status");
 my $tT = "";
 if(scalar(@rows)) {
 	$tT = sVa::fMa(rows=>\@rows2, ths=>[jW::mJa($self->{cfg_head_font}, @ths)], $self->oVa(), colsel=>$colsel); 
 }
 return qq( <form action="$self->{cgi}" method=POST>
 		@{[$abmain::cYa]}
 		<input type="hidden" name="cmd" value="delpmentry">
		$tT
		</form>);
 
}

# end of jW::eKaA
1;
