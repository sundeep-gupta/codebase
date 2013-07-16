# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 7160 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/bRa.al)"
sub bRa{
 my $uf; $uf = abmain::wTz('onlineusr') if $abmain::gJ{all};
 $iS->cR() if -f $iS->nCa();
 my $where = $abmain::gJ{where};
 my ($ul, $ths)= $iS->fTa($where, $uf);
 my $colsel = [0,1];
 my $code;
 my $cols = $abmain::gJ{cols};
 if($where) { #
 if($cols) {
 $code = abmain::qAa(ncol=>$cols, tba=>"cellpadding=3 cellspacing=1", vals=>[map {$_->[0]} @$ul ] );
 }else {
 $colsel = [0]; 
 $code =  sVa::fMa(rows=>$ul, ths=>$ths, $iS->oVa(), colsel=>$colsel); 
 }
 }else {
 $colsel = [0, 1, 2, 4] if  $abmain::gJ{verbose};
 $code =  sVa::fMa(rows=>$ul, ths=>$ths, $iS->oVa(), colsel=>$colsel); 
 }
 if($abmain::gJ{js}) {
 	sVa::gYaA "Content-type: application/x-javascript\n\n";
 	print abmain::rLz($code);
 }else {
 	sVa::gYaA "Content-type: text/html\n\n";
 if($abmain::gJ{from} ne 'Forum') {
 	my $ubg = $iS->{chat_usr_bg};
 		print qq(<html><head><title>Online Users</title></head><body bgcolor="$ubg">);
	}else {
 		$iS->eMaA( [qw(other_header other_footer)]);
 		print qq(<html><head><title>Tags</title>$iS->{sAz}$iS->{other_header});
 }
 	print $code;
 if($abmain::gJ{refresh} >0) {
 	print qq!<script>setTimeout("location.reload()", $abmain::gJ{refresh}*1000);</script>!;
 }
 if($abmain::gJ{from} ne 'Forum') {
 	print "</body></html>";
	}else {
 		print $iS->{other_footer};
	}
 }
 $iS->gCz(1);
 $iS->fSa($iS->{fTz}->{name}||$abmain::ab_id0||'???', $abmain::gJ{from}) if $abmain::gJ{from};
}

# end of abmain::bRa
1;
