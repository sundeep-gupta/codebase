# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1162 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/cJ.al)"
sub cJ {
 my($self, $cL, @cB) = @_;
 my %fL;
 my ($k, $v, $pos);
 open lW, "<$cL" or abmain::error('sys', "On reading file $cL: $!") ;
 while(<lW>){
 chomp;
 $pos = index $_, '=';
 $k = substr $_, 0, $pos;
 $v = substr $_, $pos+1;
 if($abmain::do_untaint) {$v =~ /(.*)/s; $v=$1;}
	  $jW::mid = pack("h*", $v) if($k eq '-');
	  if($k) {
		$v =~ s/\r$//;
 $v =~ s/%([0-9A-Fa-f][0-9A-Fa-f])/chr(hex($1))/ge; 
 $fL{$k} = $v;
	  }
 }
 close lW;
 if($self->{_blind_cfgs}) {
	for(keys %fL) {
		$self->{$_} = $fL{$_};
 }
	return;
 }
 
 my $fF;
 my $sq = '&#39;';
 foreach $fF (@cB) {
 next if not $fF;
 	foreach  (@{$fF}) {
 	   my $fU = $_->[0];
 	   next if not exists $fL{$fU}; 
 next if ($_->[1] eq 'head' || $_->[1] eq 'const' || $_->[1] eq 'fixed');
 	   $self->{$fU} = $fL{$fU} if exists $fL{$fU}; 
 $self->{$fU} =~ s/%([0-9A-Fa-f][0-9A-Fa-f])/chr(hex($1))/ge; 
 $self->{$fU} =~ s/'/$sq/ge if($_->[1] eq 'text' || $_->[1] eq 'color') ;
 $self->{$fU} = pack("h*", $self->{$fU}) if($_->[1] eq 'htext') ;
 	}
 }
 
}

# end of jW::cJ
1;
