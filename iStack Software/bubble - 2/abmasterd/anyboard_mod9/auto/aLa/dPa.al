# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package aLa;

#line 1348 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/aLa/dPa.al)"
sub dPa{
 my($self, $lRa, $init) = @_;
 my %fL;

 for my $ent(@{$lRa->{parts}}) {
 my $name= $ent->{eJz};
 my $val = $ent->eHz();
 if (length($ent->{eFz})>0) {
 $ent->{eFz} =~ s/\s+/_/g;
 $fL{$name} = [$ent->{eFz}, $val, $ent->{head}->{'content-type'}];
 } else {
 	              if (defined($fL{$name})){
 	              	$fL{$name} .= "\0" if defined($fL{$name}); 
 }
 	              $fL{$name} .=  $val;
 }
 }
 
 if($init) {
 $self->zLz(\%fL,undef, 1);
 return;
 }
 delete $fL{_af_tlist};
 delete $fL{_af_xlist};

 my $fF;
 my $aJa = $self->{zKz};
 foreach  (@{$aJa->{jF}}) {
 next if not $_;
 	   my $fU = $_->[0];
 	   my $t = $_->[1];
	   my $v;
 	   next if not exists $fL{$fU}; 
 next if ($t eq 'head' || $t eq 'fixed' || $t eq 'command');
 	   $v = $fL{$fU} if exists $fL{$fU}; 
	   $self->dNa($fU, $v);
 }
}

# end of aLa::dPa
1;
