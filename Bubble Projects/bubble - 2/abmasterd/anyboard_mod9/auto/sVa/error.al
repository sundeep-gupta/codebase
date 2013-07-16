# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 636 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/error.al)"
sub error {
 my ($error, $kG, $suggest)  = @_;
 my $lU = $error;
 my $nT  = "Unknown";
 my $fG = "Notify webmaster";

 my $var = $cP{$error};
 if($var) {
 $lU = $var->[0];
 $nT = $var->[1];
 $fG  = $suggest || $var->[2];
 }

 my $header ="";
 $error =~ s#$err_filter#X#g if $err_filter;
 $kG =~ s#$err_filter#X#g if $err_filter;
 sVa::gYaA ("Content-type: text/html\n");

 print $header;
 print "\n<html><head><title>Error: $kG</title>\n";
 if($abmain::iS) {
	print $abmain::iS->{other_header};
 }else {
 	print qq(<body bgcolor="#ffffff">);
 }
 print qq(<table width="75%" align="center" border="0"><tr><td><h3>$kG</h3></td></tr></table><br/>);
 print qq( 
<table align="center" border="0" cellpadding=0 cellspacing=0 width=75% bgcolor="#000000"><tr><td>
<table align="center" border="0" width=100% cellspacing=1 cellpadding=5>
<tr bgcolor="#cc0000"><th colspan=2> <font color="#ffffff">$kG</font></th></tr> 
<tr bgcolor="#d3e3f8"><th>Error type</th><th> $lU</th></tr> 
<tr bgcolor="#ffffff"><td> General description</td><td> $nT</td></tr> 
<tr bgcolor="#d3e3f8"><td>Suggested action</td><td>$fG</td></tr>
</td></tr></table>
</table>
);
 print "<p><p>\n";
 if($abmain::iS) {
	print $abmain::iS->{other_footer};
 }else {
 	print "</body></html>\n";
 }
 
 iUz(); 
 
}  

# end of sVa::error
1;
