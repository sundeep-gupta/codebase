# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package dDa;

#line 310 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/dDa/dKa.al)"
sub dKa
{
 my($url) = @_;
 my($service, $host, $path, $oE);

 ($service, $host, $path) = $url =~ /(\w+):\/\/([^\/]+)(.*)$/;

	# Look for a oE number in the service
	if ($host =~ m/:\d+$/) {
		($host, $oE) = $host =~ /^([^:]+):(\d+)$/;
	}

 if ($path eq "") {
		$path = "/";
 }
 $path =~ s#/{2,}#/#g;

 ($service, $host, $path, $oE);
}

# end of dDa::dKa
1;
