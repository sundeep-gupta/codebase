# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 6344 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/dQaA.al)"
sub dQaA {
 my $url = $abmain::lGa;
 if($url =~ /^https/i) {
	return;
 } 
 $url= sVa::kZz($url, "/");
 my $d = mGa($url);
 return if not $d;
 my %hv;
 for (split /\n/, $d) {
	my ($k, $v) = split /:/, $_;
	$hv{$k} = $v;
 }
 return ($hv{path_info}, $hv{path_translated});
}

# end of abmain::dQaA
1;
