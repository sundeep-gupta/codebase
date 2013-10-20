# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 10014 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/eV.al)"
sub eV {
 my ($self, $par) = @_;

 if($abmain::gJ{attachfid} ne "") {
	$self->yFa($abmain::gJ{attachfid}, $self->{uC}->{fI});
	return;
 }
 my $vGz= ($self->{aWz} && not $self->{bXz}->{oked});
 my $header2 = abmain::bC($abmain::cH, abmain::nXa($self->{bXz}->{name}), '/', abmain::dU('pJ',24*3600*128));
 my $header3 = abmain::bC("iG", $iG, '/');
 my $inf_msg = $vGz? $self->{pc_msg2_moder}: $self->{pc_msg2};
 my $nIz= ($vGz)?"": abmain::cUz($self->{uC}->nH($self, -1), $self->{pc_goto});
 my $nFz;
 $nFz= abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=rA;cG=$gP", $self->{pc_edit}) if $self->{rL};
 my $mYz;
 $mYz = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=myforum", $self->{kRz}) if $self->{kWz};
 if($mYz) {
 my $cntstr = "$self->{fTz}->{mycnt} messages";
 $cntstr= qq(<font color="$self->{new_msg_color}"><blink><b>$cntstr</b></blink></font>) 
		if $self->{fTz}->{mycnt} >0 && $self->{fTz}->{mytime} < $self->{kF};
 $mYz .= "($cntstr)";
 }
 my $cVz; 
 my $remsg; 
 my $relink;
 if($par && ($par->{xE} & $pKz) && $self->{oXz} && $par->{tP}) {
 $cVz =qq(<META HTTP-EQUIV="refresh" CONTENT="2; URL=$par->{tP}">);
 $remsg ="<h2>Redirecting to related URL in 2 seconds</h2>";
 $relink = "URL: " .abmain::cUz($par->{tP}, $par->{tP});
 }

 my $palert = $self->mYa($self->{fTz}->{name});

sVa::gYaA "Content-type: text/html\n$header2\n\n";

$self->eMaA( [qw(return_header return_footer)]);
print <<jU;
<html><head>$cVz<title>Message Added: $self->{bXz}->{wW}</title>
$self->{sAz}
$self->{return_header}
$self->{pc_banner}
<center>
<h1 class="ConfirmHeader">$self->{pc_thx} $self->{bXz}->{name}!</h1>
$self->{pc_msg} <it> <b> $self->{name}</b></it>
jU

if($self->{wQ} && $bNz) {
 print "<p><center><b>";
 if($abmain::wH) {
 print "E-mail notification failed with error: $abmain::wH<p>";
 }else {
 print "E-mail notification of your message has been sent to $wN.";
 }
 print "</b></center>";
}

if($jW::mailed_back) {
 print "<center><b>Requested file has been mailed back to you ($self->{bXz}->{email})!</b></center>";
}

my $i =0;
print <<"RETURN_MSG2";
$remsg<br/>
$relink
<p>
<table border="0"  cellspacing="0" cellpadding="3" width="70%">
<tr rowspan=2><td colspan="2" bgcolor="$self->{pc_hcolor}"> $self->{pc_header}</td></tr>
${\(jW::nKz($bgs[$i++%2], "<b>$self->{sH}:</b>", "$self->{bXz}->{name}"))}
${\(jW::nKz($bgs[$i++%2], "<b>$self->{qC}:</b>", "$self->{bXz}->{email}"))}
${\(jW::nKz($bgs[$i++%2], "<b>$self->{rN}:</b>", "$self->{bXz}->{wW}"))}
${\(jW::nKz($bgs[$i++%2], "<b>$self->{pc_date}:</b>", $lV))}
</table><br/>
$inf_msg<br/>
$self->{pc_advise}<br/>
</center>
RETURN_MSG2

if( $abmain::js ne 'hV') {
}

abmain::mRz($abmain::fPz{$self->{vcook}});
my $vp = $abmain::mNz{vpage}; 
my $tO = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=vXz;pgno=$vp", $self->{cp_word});
print qq!<p><center><table border="0" cellspacing="1" cellpadding="2" width="70%">!;
print jW::nKz($bgs[$i++%2], $nIz, $nFz, $mYz, $tO);
print "</table>";
print $palert;
print "</center>";
print $self->{return_footer}

}

# end of jW::eV
1;
