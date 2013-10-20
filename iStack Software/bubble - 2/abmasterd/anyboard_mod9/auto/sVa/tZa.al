# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 709 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/tZa.al)"
sub tZa{
	my ($outfile, $data) =@_;
 open FF3, ">$outfile" or return;
	binmode FF3;
	print FF3 $data;
 close FF3;
 return 1;
}

# end of sVa::tZa
1;
