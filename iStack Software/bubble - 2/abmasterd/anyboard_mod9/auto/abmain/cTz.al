# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 2717 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/cTz.al)"
sub cTz {
 my $msg = shift;
 my ($tit, $cVz, $cookie, $doclose) = @_;
 sVa::gYaA "Content-type: text/html\n";
 print "$cookie\n" if $cookie;
 print "\n";
 print "<html><head>\n";
 $doclose = $abmain::gJ{hIa} if not $doclose;
 print qq(<meta http-equiv="refresh" CONTENT="2; URL=$cVz">) if $cVz && not $doclose;
 print $iS->{sAz}, "\n" if $iS && $iS->{sAz};
 print "\n";
 my $close_win;
 $close_win= qq(<script>\nsetTimeout('window.close()', 20000);\n</script>\n) if $doclose;
 print "<title>$tit</title>\n";
 if( $iS->{_loaded_cfgs} ) {
		$iS->eMaA([qw(other_header other_footer)]);
 }
 print $abmain::iS->{other_header};
 print qq(&nbsp;<p><p>);
 print $msg;
 print "<hr><br>", $abmain::close_btn if $doclose;
 print "<p><small>", abmain::cUz($cVz, "Redirecting to $cVz"), "</small>" if $cVz && not $doclose;
 print qq@<p><hr><a href="javascript:history.go(-1)"><small>back</small></a>@;
 print $close_win;
 print $abmain::iS->{other_footer};
}

# end of abmain::cTz
1;
