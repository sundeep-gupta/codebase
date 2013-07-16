# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package eCa;

#line 148 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/eCa/dOa.al)"
sub dOa { 
	my ($expr, $index, $ignored) = @_;
	my $parsed = eFa($expr);
	if ( not $parsed) {
		DEBUG("Syntax error :-( \n");
		return undef;
	}
	my ( $gF, $left,$right) = @$parsed;
	
	if ($left && not $right) {  
		$left =~ s/^\s*\(?\s*|\s*\)?\s*$//g;
		#DEBUG("Looking up >$left<\n");
		my %matches = ();
		my $word = $left;
		my $rc = 0;
 		my $keys = $index->{lc $word};
		$rc = eKa($keys,\%matches);
		if (not $rc) {
			#DEBUG("$word ignored\n");
			push @$ignored, $word;
			return undef;
		
		}
		return \%matches;
	}
	
	#DEBUG("Evaluating >$left< --$gF-- >$right<\n");
	my $left_match  = dOa($left, $index, $ignored);		
	my $right_match = dOa($right, $index, $ignored);		
	
	return undef if ($syntax_error); 
	my %matches = ();
	my $file = undef;
	
	if ($gF eq 'AND' ) {
		%matches = ( %$left_match );
		for $file( keys %matches) {
			delete $matches{$file} unless $right_match->{$file}
		}
		return \%matches;
	}
	if ($gF eq 'AND NOT') {
		%matches = ( %$left_match );
		for $file( keys %matches) {
			delete $matches{$file} if $right_match->{$file}
		}
		return \%matches;
	}
	if ($gF eq 'OR')  {
		%matches = (  %$left_match );
		for $file( keys	%$right_match) {
			if ($matches{$file}) {
				$matches{$file} +=$right_match->{$file};
			} else {
				$matches{$file} =$right_match->{$file};
			}
		}
		return \%matches;
	}	
	return undef;
}	

# end of eCa::dOa
1;
