# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package rNa;

#line 918 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/rNa/tOa.al)"
sub tOa{
 my ($self, $input) = @_;
 my $xZa = $input->{uVa};
 my ($bt, $at, $pat);
 my $isadm = $self->eVa();
 $bt = time() - $input->{vHa} *24*3600 if $input->{vHa};
 $at = time() - $input->{vWa} *24*3600 if $input->{vWa};
 my $extract=undef;
 if($input->{extract_fields} ne '') {
		my @fs = split /\s+/, $input->{extract_fields};
		$extract = [@fs];
 }

 return $self->sSa($isadm, $xZa, 'A', $at, $bt, $input->{pat}, 1, lc($input->{sortkey}), $input->{sortorder}, undef, $extract);
}

# end of rNa::tOa
1;
