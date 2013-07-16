# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/qWa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package qWa;

#line 263 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/qWa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/qWa/qPa.al)"
sub qPa{
	my $self = shift;
 my $mf = shift;
	my $t0 = time();

	my ($dir, @urls);

	my $i=0;
 if($t0 - (stat($self->rCa($i)))[9] > 3600*$mf->{"siteidx_ref$i"}) {
 	$dir = $mf->{siteidx_topdir} if $mf->{siteidx_method} eq 'file';
		push @urls,  [0, $mf->{siteidx_url0}] if $mf->{siteidx_method} eq 'http';
 }
	for($i=1; $i<6; $i++) {
		next if not $mf->{"siteidx_url$i"};
		next if $t0 - (stat($self->rCa($i)))[9] < 3600*$mf->{"siteidx_ref$i"};
		push @urls, [$i, $mf->{"siteidx_url$i"}] if $mf->{"siteidx_url$i"};
	}

 $mf->{siteidx_wsplit} =~ s/\|+$//;
 $mf->{siteidx_wsplit} =~ s/^\|+//;
	open F, ">"."$self->{siteidx}.log";
 for(@urls) {
		$self->rDa($mf, $_->[0], $_->[1], undef, \*F, 1);
	}
	$self->rDa($mf, 0, undef, $dir, \*F, 1) if $dir;
	close F;
}

# end of qWa::qPa
1;
