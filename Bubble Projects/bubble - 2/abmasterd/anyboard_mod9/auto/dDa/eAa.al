# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package dDa;

#line 132 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/dDa/eAa.al)"
sub eAa{
	my ($pL, $path) = @_;
 my ($service, $host, $eUa) = $pL =~ /(\w+):\/\/([^\/]+)(.*)$/;
 my $url;
	if($path =~ m#^(\w+)://# ) {
		$url = $path;
	}elsif($path =~ m#^/#) {
		$url = "$service://$host$path";
	}else {
		$eUa =~ s#/[^\/]*$##;
		$url =  kZz("$service://$host", kZz($eUa, $path));
	}
	my ($page, $oE);
 ($service, $host, $page, $oE) = &dKa($url);
	$page =~ s#/[^/]+/\.\./#/#g;
	return $oE? "$service://$host:$oE$page": "$service://$host$page";
}

# end of dDa::eAa
1;
