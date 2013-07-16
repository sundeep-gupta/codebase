# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package eCa;

#line 91 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/eCa/eKa.al)"
sub eKa {  
	my ($keys, $hash) = @_;
	my $key;
	my %fkwt= unpack("n*", $keys);
	foreach $key (keys %fkwt ) { 
		return 0 if  $key == 0 ; 
		$hash->{$key} += $fkwt{$key};
	}
	return 1;
}

# end of eCa::eKa
1;
