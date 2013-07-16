# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package aLa;

#line 1106 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/aLa/aAa.al)"
sub aAa {
 my($self, $other, $def, $idx) = @_;
 my $fF;
 my $aJa = $self->{zKz};
 my @fs;
 my $ksuffix="";
 if($idx>0) {
		$ksuffix ="_aef_ss_$idx";
 }
 foreach (@{$aJa->{jF}}) {
 next if not $_;
	my $k = $_->[0];
	my $ks = "$k$ksuffix";
 	my $ele = $self->{zKz}->{bLa}->{$k};
 if($ele->{type} eq 'date' || $ele->{type} eq 'time') {
		next if $def && not exists $other->{$ks."_year"};
	}else {
		next if $def && not exists $other->{$ks};
	}
	$self->aPa($k, $other, $ks);
	push @fs, $k;
 }
 return @fs;
}

# end of aLa::aAa
1;
