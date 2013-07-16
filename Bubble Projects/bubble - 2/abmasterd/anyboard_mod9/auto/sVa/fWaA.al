# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 2353 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/fWaA.al)"
sub fWaA {
	my ($fsize) = @_;
	if($fsize < 10* 1024) {
		return "$fsize bytes";
	}elsif($fsize < 10* 1024* 1024) {
 		return sprintf ("%.1f KB",$fsize/1024);
	}else{
 		return sprintf ("%.1f MB", $fsize/1024/1024);
	}
}

# end of sVa::fWaA
1;
