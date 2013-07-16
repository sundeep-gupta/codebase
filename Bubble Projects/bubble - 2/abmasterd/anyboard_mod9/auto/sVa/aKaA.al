# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 1882 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/aKaA.al)"
sub aKaA{
	my ($str, $d_or_t, $pfmt) = @_;
	return if $str eq '';
	$str =~s/\D//g;
 $str =~ /(\d\d\d\d)(\d\d)(\d\d)(\d\d)(\d\d)(\d\d)/;
	my ($y, $m, $d, $h, $min, $sec) = ($1, $2, $3, $4, $5, $6);
	return if not ($y>0 && $m>0);
	$m--;
	
	my $tm = timelocal($sec, $min,$h, $d, $m, $y-1900);
	my $fm = 'STD' if $pfmt eq '';
	my $posix_fmt;
	if($pfmt =~ /^posix:/i) {
		$fm = 'POSIX';
		$posix_fmt = $pfmt;
		$posix_fmt =~ s/^posix://;
	}else {
		$fm = $pfmt;
 }
	return sVa::dU($fm, $tm, 'oP', $posix_fmt);
}

# end of sVa::aKaA
1;
