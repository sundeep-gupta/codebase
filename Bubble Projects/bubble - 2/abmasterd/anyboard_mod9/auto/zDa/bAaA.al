# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 338 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/bAaA.al)"
sub bAaA{
 my ($t, $len) = @_;
 $t = time() if not $t;
 my @tms = localtime($t);
 my $str = sprintf("%04d%02d%02d%02d%02d%02d", 1900+$tms[5], $tms[4]+1, $tms[3], $tms[2], $tms[1], $tms[0]);
	return substr($str, 0, $len) if $len;
	return $str;
}

# end of zDa::bAaA
1;
