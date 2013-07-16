# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 417 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/parse_parms.al)"
sub parse_parms{
	my ($str) = @_;
	return {} if not $str;
	my $hsh = {};
#	while ($str =~ /(\w+)="([^"]|\\")+"/g){

	while ($str =~ /(\w+)\s*=\s*"([^"]*)"/g){
		my $v = $2;
		my $k = $1;
		$v =~ s/\&quot;/"/go;
		$v =~ s/''/"/go;
		$hsh->{$k} = $v;
	}
	return $hsh;
}

# end of sVa::parse_parms
1;
