# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1150 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/wRz.al)"
sub wRz {
 my($self, @cB) = @_;
 my $fF;
 foreach $fF (@cB) {
 	foreach  (@{$fF}) {
 	   my $fU = $_->[0];
 next if ($_->[1] eq 'head' || $_->[1] eq 'const' || $_->[1] eq 'fixed');
 $self->{$fU} = undef;
 	}
 }
 
}

# end of jW::wRz
1;
