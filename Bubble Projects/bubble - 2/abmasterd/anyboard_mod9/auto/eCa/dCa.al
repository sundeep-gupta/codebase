# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package eCa;

#line 436 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/eCa/dCa.al)"
sub dCa {
	my $self = shift;
	my $nA = shift || \*STDOUT;
	my $kFa= $self->{kFa};
	my %indexdb;
	die unless (-f $kFa && -r _);
	eJa(\%indexdb,$kFa, $eCa::sep);
	my %index = ( %indexdb );
	my $w;
	for $w( sort { length($index{$b}) <=> length($index{$a}) }
				keys %index ) {
		print $nA $w, "\t", length($index{$w}) / 2, "\n"; 
	}
	ePa(\%indexdb);
}

# end of eCa::dCa
1;
