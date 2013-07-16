# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 614 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/cTz.al)"
sub cTz {
 my $msg = shift;
 my ($tit, $cVz, $cookie) = @_;
 sVa::gYaA("Content-type: text/html\n");
 print "$cookie\n" if $cookie;
 print "\n";
 print "<html><head>\n";
 print qq(<META HTTP-EQUIV="refresh" CONTENT="1; URL=$cVz">) if $cVz;
 print "\n";
 print "<title>$tit</title>\n";
 print qq(</head><body>\&nbsp;<p><p>);
 print $msg;
 print qq@</center></body></html>@;
}

# end of sVa::cTz
1;
