# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 2381 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/hAaA.al)"
sub hAaA {
	my ($dir) = @_;
	my $size=0;
	local *D;
	opendir D, $dir;
	my @files = readdir D;
	close D;
	my $e;
	for $e(@files) {
		my $path = sVa::kZz($dir, $e);
		next if $e eq '.';
		next if $e eq '..';
		if (-d $path) {
			$size += hAaA($path);
		}
		my @stats = stat($path) ;
		$size += $stats[7];
 }
 return $size;
}

1;
1;
# end of sVa::hAaA
