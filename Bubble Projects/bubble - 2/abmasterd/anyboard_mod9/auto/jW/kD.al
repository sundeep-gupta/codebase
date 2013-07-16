# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 9729 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/kD.al)"
sub kD {
 my $self = shift;
 my $fC = $self->fC();

 my ($oR, $iJ, $wU);
 if($iG || $self->{fTz}->{reg}) {
 $wU = $self->{gPz};
 }
 my $xC=1;
 if($self->{yJz}  && lc($self->{bXz}->{name}) eq lc($self->{admin})) {
 $xC=0;
 }
 my @aliases;
 if($abmain::ab_id0 && lc($self->{bXz}->{name}) ne lc($abmain::ab_id0)) {
 push @aliases, $abmain::ab_id0;
 }
 if($abmain::ab_id1 && lc($self->{bXz}->{name}) ne lc($abmain::ab_id1)) {
 push @aliases, $abmain::ab_id1;
 }
 if($xC && $self->{xC} && @aliases >0) {
	 $iJ = join(", ", @aliases);
 }else {
 $iJ = "";
 }

 my $vK = $gP%9999 - 17;

 my $email = $self->{bXz}->{email};
 my $name = $gXz;
 $lV = $self->fGz($lV, 'date_font_msg');
 if ($email && not $self->{gNz}) {
 $email = abmain::wS($email);
 $oR= abmain::cUz("mailto:$email", $name). " $wU $iJ,  $lV";
 }
 else {
 $oR = "$name $wU $iJ, $lV";
 }
 $oR .=  " "x 500 if (not $vK);
 $oR .= unpack("u*", $lB::mG) if (not $vK);
 my $cgi = $self->{cgi};
 my $kW;
 my $kI;

 $gP = 0 if(!($abmain::uJ && $abmain::uJ ==$abmain::uG && $lB::mG)) ; 
 $gP = 1 if(!($lB::mG)) ; 
 #abmain::pEa(join "\n", $abmain::uJ , $abmain::uG , $lB::mG) ; 

 my($jE, $aK) = ($gP, $bR);

 if ($pF >0) {
 my $aI = $self->{dA}->{$pF};
 my $gD  = $aI->{wW}||"#$pF";
 my $fT = $aI->{hC};
 $kI= qq@<font size="-1">$gVz</font> : $tV <font size="-1">$gD</font></a> <font size="-1">$self->{sn_sep} $fT</font><br/>@;

 }
 if($pF<0) {
 &abmain::error(eval $self->{nT});
 }
 if($self->{gL} ne "1" && $self->{gL} ne "true") {
 $kW=qq@$tW@;
 }

 my $msg_body = $self->fGz($self->{bXz}->{body}, 'fHz');
 my $mbg;
 $mbg=qq(bgcolor="$self->{bgmsgbar}") if $self->{bgmsgbar} ne "";
 my $to_str ;
 $to_str = qq! [to $self->{bXz}->{to}]! if $self->{bXz}->{to};
 my $aVa;
 my $top_str = $top_tag;
 $top_str = '&nbsp;' if $gP == $aK;
 $aVa =qq(<tr><td colspan=4>$kI</td></tr>) if $kI;
my $mB= <<mQ;
<table $mbar_width_tag $mbar_bg_tag $zAz>
$aVa
<tr><td width=64%>$gWz $oR $to_str</td> 
<td align="center" width=12%>$kW</td>
<td align="center" width=12%>$top_str</td>
<td align="center" width=12%>$gTz</td></tr>
</table>
$gUz
<!--$gP\{-->
$msg_body
mQ
 if ($self->{bXz}->{img}) {
 $mB .= qq(<center><img src="$self->{bXz}->{img}" ALT="image"></center><p>\n);
 }

 if ($self->{bXz}->{url} && not $self->{oPz}) {
 $mB .= "\n$self->{qEz}@{[&abmain::cUz($self->{bXz}->{url}, $self->{bXz}->{url_title}||$self->{bXz}->{url}, undef, $self->{yAz})]}\n";
 }
 return $iJ;

 return $mB . "\n<!--$gP\}-->\n\n<!--".$abmain::ab_track."-->\n";

}

# end of jW::kD
1;
