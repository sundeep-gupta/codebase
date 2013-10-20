# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package eCa;

#line 642 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/eCa/dVa.al)"
sub dVa {
	my ($db, $shared) = @_;
	my $thres = $shared->{kBa} * $shared->{filecount};
	my $klen = length(pack('n', 999));
	my @ignores;
	for(keys %$db) {
		my $v = $db->{$_};
		push @ignores, $_ if length($v)/$klen > $thres;
		
	}		
	for(@ignores) {
		delete $db->{$_};
	}
	#DEBUG "Ignore ", join ("\n", @ignores);
}

# end of eCa::dVa
1;
