# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package eCa;

#line 421 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/eCa/ePa.al)"
sub ePa {
	my ($hashref, $file, $sep ) = @_;
	$sep = "\n" if not $sep;
	if ($debug_flag) {
		my $count = int keys %$hashref;
		#DEBUG("untie $hashref ($count keys), output to $file\n")
	}
	return 1 if not $file;
	open F, ">$file" or return "On writing file $file: $1 ";
	binmode F;
	for(keys %$hashref) {
		print F $_, "\t", $hashref->{$_}, $sep;
	}
	close F;
}

# end of eCa::ePa
1;
