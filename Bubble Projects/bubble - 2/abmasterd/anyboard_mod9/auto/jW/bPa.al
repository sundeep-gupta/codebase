# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2166 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/bPa.al)"
sub bPa{
	my ($kQz)=@_;
 	$kQz = lc($kQz);
 	$kQz =~ s/(\W+)/unpack("h*", $1)/e;
	return $kQz;
}

# end of jW::bPa
1;
