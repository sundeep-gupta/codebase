# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1867 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/dRaA.al)"
sub dRaA {
	my ($self, $rdir) = @_;
	$rdir =~ s/^\.\.$//g;
	my $dir = sVa::kZz($self->{eD}, $rdir);
 	opendir DIR, "$dir";
 	my @entries = readdir DIR;
 	closedir DIR;
	my @drows;
	my @frows;
	my @ds = sort { lc($a) cmp lc($b) } @entries;
	for my $de (@ds) {
		my $path = sVa::kZz($self->{eD}, $de);
		my @stats = stat($path);
		my $owner = eval 'getpwuid($stats[4])';
		my $perm = sprintf("%04o", $stats[2] & 07777);
		my $size = $stats[7];
		my $mt = $stats[9];
		if(-d $path) {
		}else {
		}
	}	
}

# end of jW::dRaA
1;
