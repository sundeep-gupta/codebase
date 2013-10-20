# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1212 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/iA.al)"
sub iA {
 my($self, @cB) = @_;
 $self->{eF} = {};
 my $fF;
 foreach $fF (@cB) {
 	foreach  (@{$fF}) {
 next if($_->[1] eq 'head');
 next if($_->[1] eq 'const');
 next if($_->[1] eq 'fixed');
 	   my $fU = $_->[0];
 next if $self->{xcfgfs} && not $self->{xcfgfs}->{$fU};
	   if($_->[1] eq lc("password") ) {
 	        $self->{eF}->{$fU} = $abmain::gJ{$fU} if $abmain::gJ{$fU};
 }elsif ($_->[1] eq 'date') {
 	        $self->{$fU} = abmain::xUz(\%abmain::gJ, $fU); 
 }elsif( $_->[1] eq 'perlre') {
 	$abmain::gJ{$fU}=~ s/^\|+//;
 	$abmain::gJ{$fU} =~ s/\|+$//;
		if( test_pattern($abmain::gJ{$fU}) ) {
 	        	$self->{$fU} = $abmain::gJ{$fU}; 
		}else {
			abmain::error('inval', "Invalid pattern: $abmain::gJ{$fU}");
		}
	   }else { 
 $abmain::gJ{$fU} =~ s/</\&lt;/g if($self->{iPa} && $_->[1] =~ /^text/);
 &jEz(\$abmain::gJ{$fU}) if($self->{hZa} && $_->[1] =~ /^text/);
 	        $self->{$fU} = $abmain::gJ{$fU}; 
 }
	  
 	}
 }
}

# end of jW::iA
1;
