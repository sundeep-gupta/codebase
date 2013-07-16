# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 697 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/rSa.al)"
sub rSa{
	my ($eFz, $outfile) =@_;
	open FF2, "<$eFz" or return;
 open FF3, ">$outfile" or return close FF2;
 my $buf;
	while(read (FF2, $buf, 4096)) {
		print FF3 $buf;
 }
 close FF3;
 return 1;
}

# end of sVa::rSa
1;
