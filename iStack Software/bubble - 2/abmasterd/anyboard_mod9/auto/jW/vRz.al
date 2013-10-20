# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 825 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/vRz.al)"
sub vRz {
	my ($self, @xlines) = @_;
 	my ($n, $p, $e, $t, $fUz, $gDz, $gIz, $ut, $fXz, $fSz, $noti);
 my $cnt=0;
 my $line1 = shift @xlines;
 abmain::error('inval', "First line of data file must be the magic string <i>$UDMAGIC</i>") unless $line1 =~ /$UDMAGIC/;
	foreach (@xlines) {
 ($n, $p, $e, $t, $fUz, $gDz, $gIz, $ut, $fXz, $fSz, $noti) = split /\t/;
	  next if !$n =~ /\S+/;
 $p = abmain::lKz($n) if not $p;
 	  $self->aG(lc($n), $p, $e, $fUz, $gDz, $gIz, $ut, $fXz, $fSz, $noti);
 $cnt ++;
 }
 return $cnt;
}

# end of jW::vRz
1;
