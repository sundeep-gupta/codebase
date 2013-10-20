# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 2267 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/fMaA.al)"
sub fMaA {
	my ($dir, $nA, $gDz, $et) = @_;
	eval 'use Tar';
	print STDERR "Error: $@\n" if $@;
	my $tar = Tar->new();
	if(not $tar) {
		print STDERR "Failed to create tar obj: $!\n";
		return;
	}
	fPaA($tar, $dir, $gDz, $et);
	$tar->write($nA);
}

# end of sVa::fMaA
1;
