# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 1284 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/tmplCode.al)"
sub tmplCode {
	my ($tmpl, $vals, $title, $capt, $fH) = @_;
	return if not $vals;	
 my $str;
	my $min= $fH->{min};
	my $max = $fH->{max} || 999;
	my $cnt = scalar(@$vals);
	if($cnt < $min) {
		my $dif = $min - $cnt;
		for(my $i=0; $i<$dif; $i++) {
			push @$vals,  undef;
		}

	}

	my $beg = $fH->{begin};
	my $end = $fH->{end};
	$beg =~ s/\bETITLE\b/$title/g if $title;
	$beg =~ s/\bECAPTION\b/$capt/g if $capt;
	$end =~ s/\bETITLE\b/$title/g if $title;
	$end =~ s/\bECAPTION\b/$capt/g if $capt;

	$str .= $beg if $fH->{begin};
 my $i =0;	
	my @gHz;
	for my $v(@$vals) {
		my $tmp = $fH->{"tmpl_$i"} || $tmpl;
		my $idx = $i++%2;
		$tmp =~ s/EDATA/$v/g;
		$tmp =~ s/E_E_O/$idx/g;
		$tmp =~ s/_E_E_I/$i/g;
		$tmp .="\n";
		push @gHz, $tmp;
		last if $i >= $max;
	}
	$str .= join($fH->{sep}, @gHz);
	$str .= $end if $fH->{end};
	return $str;
}

# end of sVa::tmplCode
1;
