# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 405 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/parse_parms_old.al)"
sub parse_parms_old{
	my ($str) = @_;
	return {} if not $str;
	my @kvs = ($str =~ /(\w+="[^"]+")/g);
	my $hsh = {};
	for my $s (@kvs) {
		$s =~ /(\w+)="(.*)"/;
		$hsh->{$1} = $2;
	}
	return $hsh;
}

# end of sVa::parse_parms_old
1;
