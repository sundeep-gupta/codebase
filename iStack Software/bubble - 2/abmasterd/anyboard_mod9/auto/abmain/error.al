# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 2758 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/error.al)"
sub error {
 my ($error, $kG, $suggest)  = @_;
 my $lU = $error;
 my $nT  = "Unknown";
 my $fG = "Notify webmaster";

 my $var = $abmain::cP{$error};
 if($var) {
 $lU = $var->[0];
 $nT = $var->[1];
 $fG  = $suggest || $var->[2];
 }

 my $header ="";
 $error =~ s#$err_filter#X#g if $err_filter;
 $kG =~ s#$err_filter#X#g if $err_filter;
 sVa::gYaA "Content-type: text/html\n";

 if($error eq 'forbid_words'){
 $jH = $jH +1;
 $header = bC($abmain::dS, $jH, "/", dU('pJ', 60*3600*24));
 $lU = qq(Did you say <font color="#cc0000"> $jW::fO </font>, $gJ{'name'} ??);
 $nT = "<center>$iS->{scare_msg}</center>\n";
 &nF;

 }elsif ($error eq 'nG'){
 $lU = "Unknown Server Error 7161";
 if($abmain::js ne 'hV') {
 $nT =qq@<script language="javascript"><!--
 var i=0;  
#x1
#x1
#x1
#x1
#x1
 //--> </script>@; 
 }
 }
 print $header;
 print "\n<html><head><title>Error: $kG</title>\n";
 if($abmain::iS) {
	if( $iS->{_loaded_cfgs} ) {
		$iS->eMaA([qw(other_header other_footer)]);
	}
	print $abmain::iS->{sAz}, "\n";
	print $abmain::iS->{other_header};
 }else {
 	print qq(</head><body bgcolor="$abmain::msg_bg">);
 }
 my @rows;
 
 push @rows, [qq(<img src="$abmain::img_top/error.gif" align="left" alt="Error" hscape=4 vspace=4> <font color="#ffffff">$kG</font>)];
 push @rows, [qq(Error type), qq(<b>$lU</b>)];
 push @rows, [qq(General description), $nT ];
 push @rows, [qq(Suggested action), $fG];

 my $goback = qq(<a href="javascript:history.go(-1)">Go back</a>);
 my $gohome= qq(<a href="/">Home page</a);
 my $capt = join ('&nbsp;|&nbsp;', $goback, $gohome);

 if (ref($iS)) {
 	print sVa::fMa($iS->oVa(), rows=>\@rows, capt=>$capt);
 }else {
 	print sVa::fMa(sVa::oVa(), rows=>\@rows, capt=>$capt);
 }

 print "<p><p>\n";
 if($abmain::iS) {
	if($abmain::iS->{bXz}->{body} ne "") {
		print $abmain::iS->gDaA();
	}
	print $abmain::iS->{other_footer};
 if($abmain::iS->{yLz} eq 'POST') {
#		$abmain::iS->wNz($lU, $abmain::gJ{name}||$abmain::iS->{bXz}->{name}||$abmain::iS->{fTz}->{name}, $abmain::iS->nDz('failpostlog'));
	}
 }else {
 	print "</body></html>\n";
 }
 print "<!--", join("; ", caller(6)), "-->";
 &abmain::iUz();
 
}  

# end of abmain::error
1;
