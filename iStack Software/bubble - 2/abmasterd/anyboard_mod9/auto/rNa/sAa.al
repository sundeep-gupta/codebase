# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package rNa;

#line 1237 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/rNa/sAa.al)"
sub sAa{
 my ($self, $xZa, $inline) = @_;
 return sub {
	my $file = shift;
 	my $cTa = sVa::rOa($file);
 	my $url = sVa::sTa($self->{cgi_full}, {_aefcmd_=>"retr", uVa=>$xZa, vf=>$cTa});
	if($inline) {
		my $lRa = sVa::fIaA($file);
		if($lRa =~ /image/) {
			return qq(<img src="$url" alt="$file">);
		}
	}
 	return sVa::cUz($url, $file);
 }
}

# end of rNa::sAa
1;
