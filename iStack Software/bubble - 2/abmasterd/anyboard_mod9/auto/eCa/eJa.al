# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package eCa;

#line 403 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/eCa/eJa.al)"
sub eJa {
	my ($hashref, $file ,$sep) = @_;
	$sep = "\n" if not $sep;
 local *F;
	open F, "$file" or return 1;
	binmode F;
	local $/ = undef;
 my $all = <F>;
 my @gHz = split /$sep/o, $all;
	for(@gHz) {
		my ($k, $v) = split /\t/, $_, 2; 
		next if $k eq "";
		$hashref->{$k} = $v;
	}
	close F;
	return 1;
}

# end of eCa::eJa
1;
