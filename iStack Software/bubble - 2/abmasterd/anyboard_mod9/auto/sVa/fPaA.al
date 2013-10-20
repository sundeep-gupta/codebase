# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 2280 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/fPaA.al)"
sub fPaA {
	my ($tarobj, $dir, $gDz, $et) = @_;
	local *DIR;
	opendir DIR, $dir or return;
	my @ents = readdir DIR;
	closedir DIR;
	my $ent;
	for $ent (@ents) {
		next if ($ent eq '.' || $ent eq '..');
		my $path= sVa::kZz($dir, $ent);
 	my $u_t = (stat($path))[9];
		next if $gDz && $u_t < $gDz;
		next if $et && $u_t > $et;

		if( -f $path) {
			$tarobj->add_files($path);
	#		print STDERR "Adding file $path\n";
		}elsif(-d $path) {
	#		print STDERR "Adding dir $path, ENT=$ent, DIR=$dir\n";
			fPaA($tarobj, $path, $gDz, $et);
		}
	}
	return;
}

# end of sVa::fPaA
1;
