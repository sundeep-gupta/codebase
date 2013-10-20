# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 1804 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/sTa.al)"
sub sTa{
 my ($url, $parmhash, $bS) = @_;
 if($bS ne "") {
		$url = sVa::kZz($url, $bS);
 }
 $url .="?" if not $url =~ /\?/;
 if($parmhash ) {
 for my $k (keys %$parmhash) {
		$url .=';' if $url !~ /\?$/;
		$url .= "$k=".sVa::wS($parmhash->{$k});
 }
 }
 my $chk = "_cchk=";

 if($sVa::fvp) {
	$chk = "fvp=".$sVa::fvp;
 }
 if($sVa::pvp) {
	$chk = "pvp=".$sVa::pvp;
 }
 return $url.";$chk";
}

# end of sVa::sTa
1;
