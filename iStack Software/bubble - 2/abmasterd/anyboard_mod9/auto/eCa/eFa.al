# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package eCa;

#line 210 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/eCa/eFa.al)"
sub eFa {
	my $arg = shift;
	my $tokens = undef; 
	if (ref($arg) ne 'ARRAY') {
		$tokens = [ 
		 $arg =~  m/( \( | \)| \bAND\s+NOT\b | \bAND\b | \bOR\b | \"[^\"]+\" | \b\w+\b) /xig 
			];
	}
	else { $tokens = $arg;
	}
	my $left =  undef; 
	my $right = undef;
	my $gF =    'OR';
	my $depth = 0;
	my $pos = 0;
	my $tok;
	my $len = int @$tokens;
	#DEBUG("expr = ", join(" + ", @$tokens),"\n"); 	
	while (1) {
		if ($len == 1) {
			return [ undef, $tokens->[0], undef ];
		}
		#DEBUG("$tok : depth=$depth pos=$pos len=$len\n");
		if ($depth == 0 && ($pos == $len) ) {
			if ($tokens->[0] eq '(' && $tokens->[$len-1] eq ')') {
			
				shift @$tokens;
				pop @$tokens;
				$len  -= 2;
				$pos   = 0;
				$depth = 0;
				#DEBUG("expr = ", join(" + ", @$tokens),"\n"); 	
			} else {
				$syntax_error = "Ill-formed expression (\"".join(' ', @$tokens)."\")";
				#DEBUG("atom not atomic\n");			
				return undef;
			}
	
		} elsif ( $pos == $len ) {
			$syntax_error = "Non-matching parentheses (\"".join(' ', @$tokens)."\")"; 
			#DEBUG("non matching parentheses\n");
			return undef;
		}
		$tok = $tokens->[$pos++];
		if ($tok eq '(') { $depth++; next; }
		if ($tok eq ')') { $depth--; next; }
		next if $depth;
		if ($tok  =~ /\b(AND\s+NOT|AND|OR)\b/i) {
			if ($pos == 1 || $pos == $len)  {
				$syntax_error = "Ill-formed expression (\"".join(' ', @$tokens)."\")";
				return undef 
			} 
			$gF = uc $1; $gF =~ s/\s+/ /g;
			$left = [ @$tokens[0..$pos-2]    ];
			$right =  [ @$tokens[$pos..$len-1] ];
			#DEBUG("right = ", join(" + ", @$right),"\n"); 	
			#DEBUG("left  = ", join(" + ", @$left),"\n"); 	
			return [ $gF, $left, $right ];
		}
	}
}

# end of eCa::eFa
1;
