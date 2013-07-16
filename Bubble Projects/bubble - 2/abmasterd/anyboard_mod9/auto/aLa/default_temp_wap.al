# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package aLa;

#line 486 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/aLa/default_temp_wap.al)"
sub default_temp_wap {
 my ($self, $viewonly, $skips)=@_;
	my $aJa = $self->{zKz};
	my @gHz;

	my ($p, $k, $i);
 my $zDz;

 $i =1;
	my @opts;
	foreach $p (@{$aJa->{jF}}) {
 next if not $p;
 next if $p->[1] eq 'skip';
		if($p->[1] eq 'head') {
 			my $h = $p->[2];
 			push @gHz, qq(<b>$h</b>);
 			next;
		}
 my $ele= $aJa->{bLa}->{$p->[0]};
		next if not $ele;
		my ($k, $t, $d) =  @{$ele}{qw(name type desc)};
 if ($t eq 'hidden' || $t eq 'command' || $t eq 'checkbox' || $t eq 'select') {
 next;
 }
		next if $skips->{$k};
		next if $self->tGa("skip_undef") && not $self->{$k};
 if (not $d) {
 $d = $k;
 $d =~ s/_/ /g;
 $d = ucfirst($d);
 }
		if($aJa->{_opt_fields}->{$k}) {
	        	push @opts, qq(<b>$d</b>:\{$k\});
		}else {
	        	push @gHz, qq(<b>$d</b>:\{$k\});
		}
	}
	push @gHz, "\{_COMMAND_\}\n" if not $viewonly;
 return join "<br/>", @gHz;
}

# end of aLa::default_temp_wap
1;
