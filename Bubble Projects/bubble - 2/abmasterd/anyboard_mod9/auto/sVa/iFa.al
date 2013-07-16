# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 1614 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/iFa.al)"
sub iFa {
 my ($path) = @_;

 $path =~ s/`|\|&//g;

 my $lRa= fIaA($path);
 local *F;
 if(not open F, "<$path") {
	sVa::error("sys", "Fail to open file: $!");
	return;
 }
 binmode F;
 binmode STDOUT;
 $| = 1;
 sVa::gYaA("Content-type: $lRa\n");
 $path =~ s!.*/!!;
 if(not ($lRa =~ /text/i || $lRa =~ /image/i || $lRa =~ /script/i)) {
 	print qq(Content-Disposition: attachment; filename="$path"\n);

 }
 print "\n";
 my $buf;
 while(sysread F, $buf, 4096*4) { syswrite (STDOUT, $buf, length($buf), 0); }
 close F; 
 return 1;
}

# end of sVa::iFa
1;
