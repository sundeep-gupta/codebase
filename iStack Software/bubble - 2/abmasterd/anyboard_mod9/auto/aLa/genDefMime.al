# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package aLa;

#line 1387 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/aLa/genDefMime.al)"
sub genDefMime {
 my($self) = @_;
 my $aJa = $self->{zKz};
 my @fs =();
 my $cJa= dZz->zVz("def");
 
 my $dlen = @bAa::fs;
 foreach my $p (@{$aJa->{jF}}) {
 next if not $p;
 my $fn = $p->[0];
	    for (my $i=0; $i<$dlen; $i++){ 
 	$cJa->zRz(dZz->zVz("$fn.".$bAa::fs[$i], [$p->[$i]], "text/plain"));
	    }
	    push @fs, $fn;
 }
 $cJa->zRz(dZz->zVz("_af_xlist_", [join ("-", @fs)], "text/plain"));
 $cJa->zRz(dZz->zVz("_af_temp_", [$self->{temp}], "text/plain"));
 return $cJa;

}

# end of aLa::genDefMime
1;
